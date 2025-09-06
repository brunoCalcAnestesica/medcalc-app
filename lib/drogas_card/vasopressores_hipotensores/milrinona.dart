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

Widget _buildCardMilrinona(
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
      const Text('Milrinona', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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
      _linhaPreparo('Ampola 10mg/10mL (1mg/mL)', ''),

      const SizedBox(height: 16),
      const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),
      _linhaPreparo('10mg em 100mL SG 5%', '100 mcg/mL'),
      _linhaPreparo('20mg em 100mL SG 5%', '200 mcg/mL'),

      const SizedBox(height: 16),
      const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),

      if (isAdulto) ...[
        _linhaIndicacaoDoseCalculada(
          titulo: 'Insuficiência cardíaca aguda descompensada',
          descricaoDose: 'Bolus: 50 mcg/kg IV em 10 min, seguido de 0,375–0,75 mcg/kg/min',
          dosePorKg: 0.05,
          doseMaxima: 0.05,
          unidade: 'mg',
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Choque cardiogênico',
          descricaoDose: '0,5–0,75 mcg/kg/min IV contínua',
          peso: peso,
        ),
      ] else ...[
        _linhaIndicacaoDoseCalculada(
          titulo: 'Insuficiência cardíaca pediátrica',
          descricaoDose: 'Bolus: 50 mcg/kg IV, seguido de 0,25–0,75 mcg/kg/min',
          dosePorKg: 0.05,
          doseMaxima: 0.05,
          unidade: 'mg',
          peso: peso,
        ),
      ],

      const SizedBox(height: 16),
      const Text('Usos Off-Label', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),
      if (faixaEtaria == 'Recém-nascido') ...[
        _textoObs('• Neonatos (0–28 dias): uso restrito à insuficiência cardíaca grave em ambiente de UTI neonatal sob monitoração invasiva.'),
      ] else if (faixaEtaria == 'Lactente' || faixaEtaria == 'Criança') ...[
        _textoObs('• Lactentes e crianças pequenas (1 mês a 6 anos): uso em insuficiência cardíaca aguda e pós-operatório de cirurgia cardíaca.'),
      ] else if (faixaEtaria == 'Adolescente' || faixaEtaria == 'Adulto') ...[
        _textoObs('• Crianças maiores, adolescentes e adultos: uso amplamente aceito em insuficiência cardíaca aguda e choque cardiogênico.'),
      ] else if (faixaEtaria == 'Idoso') ...[
        _textoObs('• Idosos: uso com cautela devido ao risco aumentado de arritmias e hipotensão.'),
      ],

      const SizedBox(height: 16),
      const Text('Cálculo da Infusão', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),
      ConversaoInfusaoSlider(
        peso: peso,
        opcoesConcentracoes: {
          '10mg/100mL (100mcg/mL)': 100,
          '20mg/100mL (200mcg/mL)': 200,
        },
        unidade: 'mcg/kg/min',
        doseMin: 0.25,
        doseMax: 0.75,
      ),

      const SizedBox(height: 16),
      const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),
      _textoObs('• Inibidor da fosfodiesterase tipo III (inotrópico e vasodilatador).'),
      _textoObs('• Aumenta contratilidade e reduz pós-carga sem aumentar consumo de O2.'),
      _textoObs('• Pode causar hipotensão e taquicardia.'),
      _textoObs('• Monitorar pressão arterial e frequência cardíaca.'),
      _textoObs('• Útil em insuficiência cardíaca com baixo débito.'),

      const SizedBox(height: 16),
      const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),
      _textoObs('• Metabolização hepática mínima.'),
      _textoObs('• Excreção predominantemente renal inalterado (~80%).'),
      _textoObs('• Meia-vida plasmática: 2,3 horas.'),
      _textoObs('• Início de ação: 5–15 minutos.'),
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
      descricaoDose.contains('mg/h');

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

class MedicamentoMilrinona {
  static const String nome = 'Milrinona';
  static const String idBulario = 'milrinona';

  static Future<Map<String, dynamic>> carregarBulario() async {
    final String jsonStr = await rootBundle.loadString('assets/medicamentos/milrinona.json');
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
      conteudo: _buildCardMilrinona(
        context,
        peso,
        isAdulto,
        isFavorito,
        () => onToggleFavorito(nome),
      ),
    );
  }
} 