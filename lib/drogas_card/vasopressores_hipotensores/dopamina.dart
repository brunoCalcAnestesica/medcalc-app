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
  required VoidCallback onBularioPressed,
  required Widget conteudo,
}) {
  return _CustomExpansionCard(
    nome: nome,
    isFavorito: isFavorito,
    onToggleFavorito: onToggleFavorito,
    onBularioPressed: onBularioPressed,
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

Widget _buildCardDopamina(
  BuildContext context,
  double peso,
  bool isAdulto,
  bool isFavorito,
  VoidCallback onToggleFavorito,
) {
  final faixaEtaria = SharedData.faixaEtaria ?? '';
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 16),
      const Text('Dopamina', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      if (faixaEtaria.isNotEmpty)
        Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 8),
          child: Text(
            'Faixa etária: $faixaEtaria',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.indigo),
          ),
        ),
      const Text('Apresentação',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),
      _linhaPreparo('Ampola 200mg/5mL (40mg/mL)', ''),

      const SizedBox(height: 16),
      const Text('Preparo',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),
      _linhaPreparo('200mg em 250mL SG 5%', '0,8 mg/mL (800 mcg/mL)'),
      _linhaPreparo('400mg em 250mL SG 5%', '1,6 mg/mL (1600 mcg/mL)'),

      const SizedBox(height: 16),
      const Text('Indicações Clínicas',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),
      if (faixaEtaria == 'Recém-nascido') ...[
        _linhaIndicacaoDoseCalculada(
          titulo: 'Choque com baixa perfusão',
          descricaoDose: '2–20 mcg/kg/min IV contínua',
          peso: peso,
        ),
      ] else if (faixaEtaria == 'Lactente' || faixaEtaria == 'Criança') ...[
        _linhaIndicacaoDoseCalculada(
          titulo: 'Choque séptico ou cardiogênico',
          descricaoDose: '2–20 mcg/kg/min IV contínua',
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Insuficiência cardíaca aguda',
          descricaoDose: '2–20 mcg/kg/min IV contínua',
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Suporte hemodinâmico pós-operatório',
          descricaoDose: '2–20 mcg/kg/min IV contínua',
          peso: peso,
        ),
      ] else if (faixaEtaria == 'Adolescente' || faixaEtaria == 'Adulto') ...[
        _linhaIndicacaoDoseCalculada(
          titulo: 'Choque séptico, cardiogênico ou hipovolêmico',
          descricaoDose: '2–20 mcg/kg/min IV contínua',
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Insuficiência cardíaca aguda com baixo débito',
          descricaoDose: '2–20 mcg/kg/min IV contínua',
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Hipotensão refratária',
          descricaoDose: '2–20 mcg/kg/min IV contínua',
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Bradicardia sintomática com instabilidade',
          descricaoDose: '2–10 mcg/kg/min IV contínua',
          peso: peso,
        ),
      ] else if (faixaEtaria == 'Idoso') ...[
        _linhaIndicacaoDoseCalculada(
          titulo: 'Choque séptico, cardiogênico ou hipovolêmico',
          descricaoDose: '2–20 mcg/kg/min IV contínua',
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Insuficiência cardíaca aguda com baixo débito',
          descricaoDose: '2–20 mcg/kg/min IV contínua',
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Hipotensão refratária',
          descricaoDose: '2–20 mcg/kg/min IV contínua',
          peso: peso,
        ),
      ],

      const SizedBox(height: 16),
      const Text('Off Label',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),
      if (faixaEtaria == 'Recém-nascido') ...[
        _textoObs('• Neonatos: uso restrito a casos selecionados de choque refratário, com monitoração intensiva obrigatória.'),
      ] else if (faixaEtaria == 'Lactente' || faixaEtaria == 'Criança') ...[
        _textoObs('• Crianças: uso em suporte hemodinâmico pós-operatório é amplamente empregado, mas não consta formalmente na bula.'),
      ] else if (faixaEtaria == 'Adolescente' || faixaEtaria == 'Adulto') ...[
        _textoObs('• Adultos: uso em bradicardia sintomática é off-label mas aceito na prática clínica.'),
      ] else if (faixaEtaria == 'Idoso') ...[
        _textoObs('• Idosos: uso exige cautela redobrada devido ao maior risco de arritmias e isquemia miocárdica.'),
      ],

      const SizedBox(height: 16),
      const Text('Cálculo da Infusão',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),
      ConversaoInfusaoSlider(
        peso: peso,
        opcoesConcentracoes: {
          '200mg/250mL (800mcg/mL)': 800,
          '400mg/250mL (1600mcg/mL)': 1600,
        },
        unidade: 'mcg/kg/min',
        doseMin: 2.0,
        doseMax: 20.0,
      ),

      const SizedBox(height: 16),
      const Text('Observações',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),
      _textoObs('• Ação dose-dependente:'),
      _textoObs('  • Baixa (1–3 mcg/kg/min): efeito dopaminérgico renal (não recomendado mais para este fim).'),
      _textoObs('  • Média (5–10 mcg/kg/min): efeito beta-1 inotrópico (aumento do débito cardíaco).'),
      _textoObs('  • Alta (10–20 mcg/kg/min): efeito alfa-1 vasoconstritor (aumenta PA).'),
      _textoObs('• Monitorar ritmo cardíaco e pressão arterial constantemente.'),
      _textoObs('• Preferencialmente utilizar bomba de infusão.'),
      _textoObs('• Pode causar arritmias, taquicardia e isquemia em altas doses.'),
      _textoObs('• Corrigir hipovolemia antes de iniciar.'),

      const SizedBox(height: 16),
      const Text('Metabolismo',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),
      _textoObs('• Metabolização rápida por COMT e MAO no fígado, rins e plasma.'),
      _textoObs('• Excreção predominantemente renal como ácido homovanílico (HVA).'),
      _textoObs('• Meia-vida plasmática de ~2 minutos.'),
      _textoObs('• Início de ação em 2–5 minutos IV.'),
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
      descricaoDose.contains('EV contínua');

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

class MedicamentoDopamina {
  static const String nome = 'Dopamina';
  static const String idBulario = 'dopamina';

  static Future<Map<String, dynamic>> carregarBulario() async {
    final String jsonStr = await rootBundle.loadString('assets/medicamentos/dopamina.json');
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
      onBularioPressed: () {
        Navigator.pushNamed(context, '/bulario', arguments: idBulario);
      },
      conteudo: _buildCardDopamina(
        context,
        peso,
        isAdulto,
        isFavorito,
        () => onToggleFavorito(nome),
      ),
    );
  }
} 