import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'shared_data.dart';
import 'formatters.dart';
import 'fisiologia.dart';
import 'drogas_card/drogas.dart';
import 'pcr.dart';
import 'inducao.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class MinhaPagina extends StatelessWidget {
  const MinhaPagina({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MedCalc'),
        actions: [
          IconButton(
            icon: const Icon(Icons.mail_outline,color: Colors.white,),
            tooltip: 'Queremos saber sua opinião. Ajude-nos a melhorar.',
            onPressed: () async {
              final Uri emailUri = Uri(
                scheme: 'mailto',
                path: 'bhdaroz@gmail.com',
                query: Uri.encodeFull(
                  'subject=Feedback sobre o MedCalc&body=Olá,\n\nQueremos saber sua opinião. Ajude-nos a melhorar o aplicativo MedCalc!',
                ),
              );
              if (await canLaunchUrl(emailUri)) {
                await launchUrl(emailUri);
              } else {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Não foi possível abrir o aplicativo de e-mail.')),
                  );
                }
              }
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Conteúdo da página'),
      ),
    );
  }
}


class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // <<< ESSA LINHA AQUI CORRIGE TUDO!

  final TextEditingController _pesoAtualController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();

  String _idadeTipo = 'anos'; // 'dias', 'meses', 'anos'
  String? _faixaEtaria;
  String _sexoSelecionado = 'Masculino';

  void _atualizarDados() {
    print('=== INÍCIO DA ATUALIZAÇÃO ===');
    
    // Obter valores dos campos
    String pesoText = _pesoAtualController.text.trim();
    String idadeText = _idadeController.text.trim();
    String alturaText = _alturaController.text.trim();
    
    print('Valores dos campos:');
    print('Peso: "$pesoText"');
    print('Idade: "$idadeText"');
    print('Altura: "$alturaText"');
    print('Tipo: $_idadeTipo');
    print('Sexo: $_sexoSelecionado');

    // Verificar se os campos não estão vazios
    if (pesoText.isEmpty || idadeText.isEmpty || alturaText.isEmpty) {
      print('ERRO: Campos vazios');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, preencha todos os campos.'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // Converter para double
    double? peso = double.tryParse(pesoText.replaceAll(',', '.'));
    double? idade = double.tryParse(idadeText.replaceAll(',', '.'));
    double? altura = double.tryParse(alturaText.replaceAll(',', '.'));

    print('Valores convertidos:');
    print('Peso: $peso');
    print('Idade: $idade');
    print('Altura: $altura');

    if (peso == null || idade == null || altura == null) {
      print('ERRO: Valores inválidos');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, insira valores numéricos válidos.'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // Atualizar SharedData
    SharedData.peso = peso;
    SharedData.altura = altura;
    
    // Converter idade baseado no tipo
    if (_idadeTipo == 'dias') {
      SharedData.idade = idade / 365.0;
    } else if (_idadeTipo == 'meses') {
      SharedData.idade = idade / 12.0;
    } else {
      SharedData.idade = idade;
    }
    
    SharedData.sexo = _sexoSelecionado;
    SharedData.idadeTipo = _idadeTipo;

    print('SharedData atualizado:');
    print('Peso: ${SharedData.peso}');
    print('Idade: ${SharedData.idade}');
    print('Altura: ${SharedData.altura}');
    print('Sexo: ${SharedData.sexo}');

    // Atualizar UI
    setState(() {
      _faixaEtaria = SharedData.faixaEtaria;
    });

    // Salvar no dispositivo
    _savePacientePreferences();

    // Fechar teclado
    FocusScope.of(context).unfocus();

    // Mostrar confirmação
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Dados atualizados com sucesso!'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );

    print('=== ATUALIZAÇÃO CONCLUÍDA ===');
  }



  Future<void> _savePacientePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble('peso', SharedData.peso ?? 0);
    prefs.setDouble('altura', SharedData.altura ?? 0);
    prefs.setDouble('idade', SharedData.idade ?? 0);
    prefs.setString('sexo', SharedData.sexo);
    prefs.setString('idadeTipo', SharedData.idadeTipo);
  }

  @override
  void initState() {
    super.initState();
    _carregarPacientePreferences();
  }

  Future<void> _carregarPacientePreferences() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      SharedData.peso = prefs.getDouble('peso');
      SharedData.altura = prefs.getDouble('altura');
      SharedData.idade = prefs.getDouble('idade');
      SharedData.sexo = prefs.getString('sexo') ?? 'Masculino';
      SharedData.idadeTipo = prefs.getString('idadeTipo') ?? 'anos';

      _pesoAtualController.text = SharedData.peso != null ? SharedData.peso!.round().toString() : '';
      _alturaController.text = SharedData.altura != null ? SharedData.altura!.round().toString() : '';
      _idadeController.text = SharedData.idade != null
          ? _formatarValorIdadeOriginal(SharedData.idade!, SharedData.idadeTipo)
          : '';
      _sexoSelecionado = SharedData.sexo;
      _idadeTipo = SharedData.idadeTipo;
      _faixaEtaria = SharedData.faixaEtaria;
    });
  }

  String _formatarValorIdadeOriginal(double idadeEmAnos, String tipo) {
    if (tipo == 'dias') return (idadeEmAnos * 365).round().toString();
    if (tipo == 'meses') return (idadeEmAnos * 12).round().toString();
    return idadeEmAnos.round().toString();
  }

  @override
  void dispose() {
    _pesoAtualController.dispose();
    _alturaController.dispose();
    _idadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MedCalc'),
      ),
      body: Column(
        children: [
          _buildPacienteInfoHeader(),
          Expanded(
            child:IndexedStack(
              index: _currentIndex,
              children: [
                _buildPacienteForm(),
                FisiologiaPage(key: UniqueKey()),
                DrogasPage(key: UniqueKey()),
                const PcrPage(),
                const InducaoPage(),
                // <<< NOVA ABA
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (SharedData.peso == null || SharedData.altura == null || SharedData.idade == null) {            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Preencha os dados para continuar.'),
                backgroundColor: Colors.redAccent,
                behavior: SnackBarBehavior.floating,
              ),
            );
            return; // Impede a troca de aba
          }

          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Paciente'),
          BottomNavigationBarItem(icon: Icon(Icons.monitor_heart), label: 'Fisiologia'),
          BottomNavigationBarItem(icon: Icon(Icons.medication), label: 'Drogas'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Farmacoteca'),
          BottomNavigationBarItem(icon: Icon(Icons.local_hospital), label: 'Indução'),

          //BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'PCR'),
        ],
      ),
    );
  }

  Widget _buildPacienteForm() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 400,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Dados do Paciente',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Campo Peso
              TextField(
                controller: _pesoAtualController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Peso (kg)',
                  prefixIcon: Icon(Icons.monitor_weight),
                  hintText: 'Ex: 70.5',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: (value) {
                  print('Peso digitado: $value'); // Debug
                  setState(() {
                    SharedData.peso = double.tryParse(value.replaceAll(',', '.'));
                  });
                },
              ),

              const SizedBox(height: 16),

              // Campo Idade
              TextField(
                controller: _idadeController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Idade',
                  prefixIcon: Icon(Icons.cake),
                  hintText: 'Ex: 30',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: (value) {
                  print('Idade digitada: $value'); // Debug
                  setState(() {
                    double? idade = double.tryParse(value.replaceAll(',', '.'));
                    if (idade != null) {
                      if (_idadeTipo == 'dias') {
                        SharedData.idade = idade / 365.0;
                      } else if (_idadeTipo == 'meses') {
                        SharedData.idade = idade / 12.0;
                      } else {
                        SharedData.idade = idade;
                      }
                    }
                  });
                },
              ),

              const SizedBox(height: 16),

              // Campo Altura
              TextField(
                controller: _alturaController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Altura (cm)',
                  hintText: 'Ex: 175.5',
                  prefixIcon: Icon(Icons.straighten),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: (value) {
                  print('Altura digitada: $value'); // Debug
                  setState(() {
                    SharedData.altura = double.tryParse(value.replaceAll(',', '.'));
                  });
                },
              ),

              const SizedBox(height: 16),

              // Tipo de Idade
              DropdownButtonFormField<String>(
                value: _idadeTipo,
                decoration: const InputDecoration(
                  labelText: 'Tipo de Idade',
                  prefixIcon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                items: const [
                  DropdownMenuItem(value: 'dias', child: Text('Dias')),
                  DropdownMenuItem(value: 'meses', child: Text('Meses')),
                  DropdownMenuItem(value: 'anos', child: Text('Anos')),
                ],
                onChanged: (value) {
                  print('Tipo de idade selecionado: $value'); // Debug
                  setState(() {
                    _idadeTipo = value!;
                  });
                },
              ),

              const SizedBox(height: 16),

              // Sexo
              DropdownButtonFormField<String>(
                value: _sexoSelecionado,
                decoration: const InputDecoration(
                  labelText: 'Sexo',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Masculino',
                    child: Row(
                      children: [
                        Icon(Icons.male, color: Colors.blue),
                        SizedBox(width: 8),
                        Text('Masculino'),
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'Feminino',
                    child: Row(
                      children: [
                        Icon(Icons.female, color: Colors.pink),
                        SizedBox(width: 8),
                        Text('Feminino'),
                      ],
                    ),
                  ),
                ],
                onChanged: (value) {
                  print('Sexo selecionado: $value'); // Debug
                  setState(() {
                    _sexoSelecionado = value!;
                  });
                },
              ),

              const SizedBox(height: 30),

              // Botão de Atualizar
              ElevatedButton.icon(
                onPressed: () {
                  print('Botão pressionado!'); // Debug
                  print('Peso: ${_pesoAtualController.text}');
                  print('Idade: ${_idadeController.text}');
                  print('Altura: ${_alturaController.text}');
                  _atualizarDados();
                },
                icon: const Icon(Icons.check_circle),
                label: const Text('Atualizar Dados'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),

              const SizedBox(height: 20),

              // Debug info
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Debug Info:', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Peso: ${_pesoAtualController.text}'),
                    Text('Idade: ${_idadeController.text}'),
                    Text('Altura: ${_alturaController.text}'),
                    Text('Tipo: $_idadeTipo'),
                    Text('Sexo: $_sexoSelecionado'),
                    Text('SharedData.peso: ${SharedData.peso}'),
                    Text('SharedData.idade: ${SharedData.idade}'),
                    Text('SharedData.altura: ${SharedData.altura}'),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              if (_faixaEtaria != null)
                Text(
                  'Faixa Etária: $_faixaEtaria',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
                ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildPacienteInfoHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.indigo.shade100,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildInfoItem('Idade', _formatarIdade()),
          _buildInfoItem('Peso', SharedData.peso != null ? '${SharedData.peso!.round()} kg' : '-'),
          _buildInfoItem('Altura', SharedData.altura != null ? '${SharedData.altura!.round()} cm' : '-'),
          _buildInfoItem('Faixa', SharedData.faixaEtaria),
          _buildSexoInfoItem(),
        ],
      ),
    );
  }

  Widget _buildSexoInfoItem() {
    IconData icon = SharedData.sexo == 'Feminino' ? Icons.female : Icons.male;
    Color color = SharedData.sexo == 'Feminino' ? Colors.pink : Colors.blue;

    return Column(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 4),
        Text(
          SharedData.sexo,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }


  Widget _buildInfoItem(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        Text(value, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}

String _formatarIdade() {
  if (SharedData.idade == null) return '-';
  double idade = SharedData.idade!;

  if (SharedData.idadeTipo == 'dias') {
    int dias = (idade * 365).round();
    return '$dias dias';
  } else if (SharedData.idadeTipo == 'meses') {
    int meses = (idade * 12).round();
    return '$meses meses';
  } else {
    return '${idade.round()} anos';
  }
}
