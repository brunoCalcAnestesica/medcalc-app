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

Widget _buildCardDobutamina(
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
      const Text('Dobutamina', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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
      _linhaPreparo('Ampola 250mg/20mL (12,5mg/mL)', ''),

      const SizedBox(height: 16),
      const Text('Preparo',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),
      _linhaPreparo('250mg em 250mL SG 5%', '1 mg/mL'),
      _linhaPreparo('500mg em 250mL SG 5%', '2 mg/mL'),

      const SizedBox(height: 16),
      const Text('Indicações Clínicas',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),
      if (faixaEtaria == 'Recém-nascido') ...[
        _linhaIndicacaoDoseCalculada(
          titulo: 'Insuficiência cardíaca aguda',
          descricaoDose: '2–20 mcg/kg/min IV contínua',
          peso: peso,
        ),
      ] else if (faixaEtaria == 'Lactente' || faixaEtaria == 'Criança') ...[
      _linhaIndicacaoDoseCalculada(
        titulo: 'Insuficiência cardíaca aguda/descompensada',
        descricaoDose: '2–20 mcg/kg/min IV contínua',
        peso: peso,
      ),
      _linhaIndicacaoDoseCalculada(
        titulo: 'Choque cardiogênico',
        descricaoDose: '2–20 mcg/kg/min IV contínua',
        peso: peso,
      ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Baixo débito pós-operatório',
          descricaoDose: '2–20 mcg/kg/min IV contínua',
          peso: peso,
        ),
      ] else if (faixaEtaria == 'Adolescente' || faixaEtaria == 'Adulto') ...[
        _linhaIndicacaoDoseCalculada(
          titulo: 'Insuficiência cardíaca aguda/descompensada',
          descricaoDose: '2,5–20 mcg/kg/min IV contínua',
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Choque cardiogênico',
          descricaoDose: '2,5–20 mcg/kg/min IV contínua',
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Suporte inotrópico perioperatório',
          descricaoDose: '2,5–20 mcg/kg/min IV contínua',
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Teste de estresse farmacológico',
          descricaoDose: '5–40 mcg/kg/min IV contínua',
          peso: peso,
        ),
      ] else if (faixaEtaria == 'Idoso') ...[
        _linhaIndicacaoDoseCalculada(
          titulo: 'Insuficiência cardíaca aguda/descompensada',
          descricaoDose: '2,5–20 mcg/kg/min IV contínua',
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Choque cardiogênico',
          descricaoDose: '2,5–20 mcg/kg/min IV contínua',
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Suporte inotrópico perioperatório',
          descricaoDose: '2,5–20 mcg/kg/min IV contínua',
          peso: peso,
        ),
      ],

      const SizedBox(height: 16),
      const Text('Off Label',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),
      if (faixaEtaria == 'Recém-nascido') ...[
        _textoObs('• Neonatos: uso restrito a casos selecionados de insuficiência cardíaca grave, com monitoração intensiva obrigatória.'),
      ] else if (faixaEtaria == 'Lactente' || faixaEtaria == 'Criança') ...[
        _textoObs('• Crianças: uso em baixo débito pós-operatório é amplamente empregado, mas não consta formalmente na bula.'),
      ] else if (faixaEtaria == 'Adolescente' || faixaEtaria == 'Adulto') ...[
        _textoObs('• Adultos: uso em teste de estresse farmacológico é off-label mas amplamente aceito na prática clínica.'),
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
          '250mg/250mL (1mg/mL)': 1000,
          '500mg/250mL (2mg/mL)': 2000,
        },
        unidade: 'mcg/kg/min',
        doseMin: 100/peso,
        doseMax: 500/peso,
      ),

      const SizedBox(height: 16),
      const Text('Observações',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),
      _textoObs('• Agonista beta-1 predominante com leve efeito beta-2 e alfa-1.'),
      _textoObs('• Aumenta contratilidade e débito sem grande vasoconstrição.'),
      _textoObs('• Pode causar taquiarritmias em altas doses.'),
      _textoObs('• Útil em baixo débito e hipoperfusão.'),
      _textoObs('• Monitorizar ECG e sinais vitais continuamente.'),
      _textoObs('• Corrigir hipovolemia antes de iniciar.'),

      const SizedBox(height: 16),
      const Text('Metabolismo',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),
      _textoObs('• Metabolização hepática e por COMT.'),
      _textoObs('• Excreção renal como metabólitos inativos.'),
      _textoObs('• Meia-vida plasmática de ~2 minutos.'),
      _textoObs('• Início de ação em 1–2 minutos IV.'),
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

class MedicamentoDobutamina {
  static const String nome = 'Dobutamina';
  static const String idBulario = 'dobutamina';

  static Future<Map<String, dynamic>> carregarBulario() async {
    final String jsonStr = await rootBundle.loadString('assets/medicamentos/dobutamina.json');
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
      conteudo: _buildCardDobutamina(
        context,
        peso,
        isAdulto,
        isFavorito,
        () => onToggleFavorito(nome),
      ),
    );
  }
}