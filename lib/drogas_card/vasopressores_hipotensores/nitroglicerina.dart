import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

/// Cria um card expansível para exibir informações de um medicamento.
Widget buildMedicamentoExpansivel({
  required BuildContext context,
  required String nome,
  required String idBulario,
  required bool isFavorito,
  required VoidCallback onToggleFavorito,
  required Widget conteudo,
}) {
  return _CustomExpansionCard(
    nome: nome,
    isFavorito: isFavorito,
    onToggleFavorito: onToggleFavorito,
    onBularioPressed: () {
      Navigator.pushNamed(context, '/bulario', arguments: idBulario);
    },
    conteudo: conteudo,
  );
}

class _CustomExpansionCard extends StatefulWidget {
  final String nome;
  final bool isFavorito;
  final VoidCallback onToggleFavorito;
  final VoidCallback onBularioPressed;
  final Widget conteudo;

  const _CustomExpansionCard({
    required this.nome,
    required this.isFavorito,
    required this.onToggleFavorito,
    required this.onBularioPressed,
    required this.conteudo,
  });

  @override
  State<_CustomExpansionCard> createState() => _CustomExpansionCardState();
}

class _CustomExpansionCardState extends State<_CustomExpansionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _heightFactor;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _heightFactor = _controller.drive(CurveTween(curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Column(
        children: [
          // Header
          GestureDetector(
            onTap: _toggleExpansion,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.indigo,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.nome,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          widget.isFavorito ? Icons.star_rounded : Icons.star_border_rounded,
                          color: widget.isFavorito ? Colors.amber[700] : Colors.grey[400],
                          size: 24,
                        ),
                        tooltip: widget.isFavorito ? 'Remover dos favoritos' : 'Adicionar aos favoritos',
                        onPressed: widget.onToggleFavorito,
                        visualDensity: VisualDensity.compact,
                      ),
                      IconButton(
                        icon: const Icon(Icons.medical_information_rounded, size: 24, color: Colors.blueGrey),
                        tooltip: 'Abrir bulário',
                        onPressed: widget.onBularioPressed,
                        visualDensity: VisualDensity.compact,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Content
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return ClipRect(
                child: Align(
                  heightFactor: _heightFactor.value,
                  child: _isExpanded
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: widget.conteudo,
                        )
                      : null,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

Widget _buildCardNitroglicerina(
  BuildContext context,
  double peso,
  bool isAdulto,
  bool isFavorito,
  VoidCallback onToggleFavorito,
) {
  final faixaEtaria = SharedData.faixaEtaria;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 16),
      const Text('Nitroglicerina', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      if (faixaEtaria.isNotEmpty)
        Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 8),
          child: Text(
            'Faixa etária: $faixaEtaria',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.indigo),
          ),
        ),
      const Text('Apresentação', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),
      _linhaPreparo('Ampola 50mg/10mL (5mg/mL)', ''),

      const SizedBox(height: 16),
      const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),
      _linhaPreparo('50mg em 250mL SG 5%', '200 mcg/mL'),
      _linhaPreparo('50mg em 500mL SG 5%', '100 mcg/mL'),

      const SizedBox(height: 16),
      const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),

      if (isAdulto) ...[
        _linhaIndicacaoDoseCalculada(
          titulo: 'Angina instável / IAM com supra',
          descricaoDose: '5–200 mcg/min IV contínua',
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Edema agudo de pulmão (vasodilatador venoso)',
          descricaoDose: '20–100 mcg/min IV contínua',
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Crise hipertensiva',
          descricaoDose: '5–100 mcg/min IV contínua',
          peso: peso,
        ),
      ] else ...[
        _linhaIndicacaoDoseCalculada(
          titulo: 'Controle da pré/pós-carga em cirurgia cardíaca',
          descricaoDose: '0,5–5 mcg/kg/min IV contínua',
          peso: peso,
        ),
      ],

      const SizedBox(height: 16),
      const Text('Usos Off-Label', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),
      if (faixaEtaria == 'Recém-nascido') ...[
        _textoObs('• Neonatos (0–28 dias): uso restrito à hipertensão pulmonar grave em ambiente de UTI neonatal sob monitoração invasiva.'),
      ] else if (faixaEtaria == 'Lactente' || faixaEtaria == 'Criança') ...[
        _textoObs('• Lactentes e crianças pequenas (1 mês a 6 anos): uso em controle de pré-carga no pós-operatório de cirurgia cardíaca.'),
      ] else if (faixaEtaria == 'Adolescente' || faixaEtaria == 'Adulto') ...[
        _textoObs('• Crianças maiores, adolescentes e adultos: uso amplamente aceito em síndrome coronariana aguda e edema agudo de pulmão.'),
      ] else if (faixaEtaria == 'Idoso') ...[
        _textoObs('• Idosos: uso com cautela devido ao risco aumentado de hipotensão e taquicardia reflexa.'),
      ],

      const SizedBox(height: 16),
      const Text('Cálculo da Infusão', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),
      ConversaoInfusaoSlider(
        peso: peso,
        opcoesConcentracoes: {
          '50mg/250mL (200mcg/mL)': 200,
          '50mg/500mL (100mcg/mL)': 100,
        },
        unidade: isAdulto ? 'mcg/min' : 'mcg/kg/min',
        doseMin: isAdulto ? 5 : 0.5,
        doseMax: isAdulto ? 100 : 5.0,
      ),

      const SizedBox(height: 16),
      const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),
      _textoObs('• Vasodilatador venoso potente com leve ação arterial em doses mais altas.'),
      _textoObs('• Reduz pré-carga e demanda miocárdica por oxigênio.'),
      _textoObs('• Pode causar hipotensão e taquicardia reflexa.'),
      _textoObs('• Monitorar pressão arterial e frequência cardíaca.'),
      _textoObs('• Evitar em hipotensão grave e estenose aórtica crítica.'),

      const SizedBox(height: 16),
      const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),
      _textoObs('• Metabolização hepática extensiva por nitroredutases.'),
      _textoObs('• Excreção renal como metabólitos inativos.'),
      _textoObs('• Meia-vida plasmática: 1–4 minutos.'),
      _textoObs('• Início de ação IV: 1–2 minutos.'),
    ],
  );
}

// Funções auxiliares necessárias
Widget _linhaPreparo(String texto, String observacao) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('• ', style: TextStyle(fontWeight: FontWeight.bold)),
        Expanded(
          child: Text(
            texto,
            style: const TextStyle(fontSize: 14),
          ),
        ),
        if (observacao.isNotEmpty)
          Text(
            ' ($observacao)',
            style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
          ),
      ],
    ),
  );
}

Widget _linhaIndicacaoDoseCalculada({
  required String titulo,
  required String descricaoDose,
  String unidade = '',
  double? dosePorKg,
  double? dosePorKgMinima,
  double? dosePorKgMaxima,
  double? doseMaxima,
  required double peso,
}) {
  double? doseCalculada;
  double? doseCalculadaMin;
  double? doseCalculadaMax;

  // Nova lógica: identificar se é dose de infusão
  final isInfusao = descricaoDose.contains('/kg/min') ||
      descricaoDose.contains('/kg/h') ||
      descricaoDose.contains('mcg/kg/min') ||
      descricaoDose.contains('mg/kg/h') ||
      descricaoDose.contains('infusão contínua') ||
      descricaoDose.contains('IV contínua') ||
      descricaoDose.contains('EV contínua') ||
      descricaoDose.contains('mg/h') ||
      descricaoDose.contains('mcg/min');

  if (dosePorKg != null) {
    doseCalculada = dosePorKg * peso;
    if (doseMaxima != null && doseCalculada > doseMaxima) {
      doseCalculada = doseMaxima;
    }
  }

  if (dosePorKgMinima != null) {
    doseCalculadaMin = dosePorKgMinima * peso;
    if (doseMaxima != null && doseCalculadaMin > doseMaxima) {
      doseCalculadaMin = doseMaxima;
    }
  }

  if (dosePorKgMaxima != null) {
    doseCalculadaMax = dosePorKgMaxima * peso;
    if (doseMaxima != null && doseCalculadaMax > doseMaxima) {
      doseCalculadaMax = doseMaxima;
    }
  }

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 4),
        Text(
          descricaoDose,
          style: const TextStyle(fontSize: 13),
        ),
        if (!isInfusao && doseCalculada != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              'Dose calculada: ${doseCalculada.toStringAsFixed(1)} $unidade',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
          ),
        if (!isInfusao && doseCalculadaMin != null && doseCalculadaMax != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              'Dose calculada: ${doseCalculadaMin.toStringAsFixed(1)}–${doseCalculadaMax.toStringAsFixed(1)} $unidade',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
          ),
      ],
    ),
  );
}

Widget _textoObs(String texto) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Text(
      texto,
      style: const TextStyle(fontSize: 13),
    ),
  );
}

class MedicamentoNitroglicerina {
  static const String nome = 'Nitroglicerina';
  static const String idBulario = 'nitroglicerina';

  static Future<Map<String, dynamic>> carregarBulario() async {
    final String jsonStr = await rootBundle.loadString('assets/medicamentos/nitroglicerina.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonStr);
    return jsonMap['PT']['bulario'];
  }

  static Widget buildCard(BuildContext context, Set<String> favoritos, void Function(String) onToggleFavorito) {
    final peso = SharedData.peso ?? 70;
    final isAdulto = SharedData.faixaEtaria == 'Adulto' || SharedData.faixaEtaria == 'Idoso';
    final isFavorito = favoritos.contains(nome);

    return buildMedicamentoExpansivel(
      context: context,
      nome: nome,
      idBulario: idBulario,
      isFavorito: isFavorito,
      onToggleFavorito: () => onToggleFavorito(nome),
      conteudo: _buildCardNitroglicerina(
        context,
        peso,
        isAdulto,
        isFavorito,
        () => onToggleFavorito(nome),
      ),
    );
  }
} 