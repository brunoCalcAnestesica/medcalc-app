import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TestForm extends StatefulWidget {
  const TestForm({super.key});

  @override
  State<TestForm> createState() => _TestFormState();
}

class _TestFormState extends State<TestForm> {
  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();
  
  String _sexo = 'Masculino';
  String _tipoIdade = 'anos';

  @override
  void dispose() {
    _pesoController.dispose();
    _idadeController.dispose();
    _alturaController.dispose();
    super.dispose();
  }

  void _testarEntrada() {
    print('=== TESTE DE ENTRADA ===');
    print('Peso: "${_pesoController.text}"');
    print('Idade: "${_idadeController.text}"');
    print('Altura: "${_alturaController.text}"');
    print('Sexo: $_sexo');
    print('Tipo: $_tipoIdade');
    
    // Testar conversão
    double? peso = double.tryParse(_pesoController.text.replaceAll(',', '.'));
    double? idade = double.tryParse(_idadeController.text.replaceAll(',', '.'));
    double? altura = double.tryParse(_alturaController.text.replaceAll(',', '.'));
    
    print('Conversões:');
    print('Peso: $peso');
    print('Idade: $idade');
    print('Altura: $altura');
    
    if (peso != null && idade != null && altura != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sucesso! Peso: $peso, Idade: $idade, Altura: $altura'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro na conversão dos valores'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teste de Entrada'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Campo Peso
            TextField(
              controller: _pesoController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Peso (kg)',
                hintText: 'Ex: 70.5',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.monitor_weight),
              ),
              onChanged: (value) {
                print('Peso digitado: $value');
              },
            ),
            
            const SizedBox(height: 16),
            
            // Campo Idade
            TextField(
              controller: _idadeController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Idade',
                hintText: 'Ex: 30',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.cake),
              ),
              onChanged: (value) {
                print('Idade digitada: $value');
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
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.straighten),
              ),
              onChanged: (value) {
                print('Altura digitada: $value');
              },
            ),
            
            const SizedBox(height: 16),
            
            // Tipo de Idade
            DropdownButtonFormField<String>(
              value: _tipoIdade,
              decoration: const InputDecoration(
                labelText: 'Tipo de Idade',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.calendar_today),
              ),
              items: const [
                DropdownMenuItem(value: 'dias', child: Text('Dias')),
                DropdownMenuItem(value: 'meses', child: Text('Meses')),
                DropdownMenuItem(value: 'anos', child: Text('Anos')),
              ],
              onChanged: (value) {
                setState(() {
                  _tipoIdade = value!;
                });
                print('Tipo selecionado: $value');
              },
            ),
            
            const SizedBox(height: 16),
            
            // Sexo
            DropdownButtonFormField<String>(
              value: _sexo,
              decoration: const InputDecoration(
                labelText: 'Sexo',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'Masculino', child: Text('Masculino')),
                DropdownMenuItem(value: 'Feminino', child: Text('Feminino')),
              ],
              onChanged: (value) {
                setState(() {
                  _sexo = value!;
                });
                print('Sexo selecionado: $value');
              },
            ),
            
            const SizedBox(height: 32),
            
            // Botão de Teste
            ElevatedButton.icon(
              onPressed: _testarEntrada,
              icon: const Icon(Icons.play_arrow),
              label: const Text('Testar Entrada'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Informações de Debug
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Debug Info:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text('Peso: "${_pesoController.text}"'),
                  Text('Idade: "${_idadeController.text}"'),
                  Text('Altura: "${_alturaController.text}"'),
                  Text('Tipo: $_tipoIdade'),
                  Text('Sexo: $_sexo'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
