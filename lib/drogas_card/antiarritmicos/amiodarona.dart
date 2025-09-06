import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

/// Card de informações da Amiodarona
Widget _buildCardAmiodarona(
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
      const Text('Amiodarona', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      if (faixaEtaria.isNotEmpty)
        Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 8),
          child: Text(
            'Faixa etária: $faixaEtaria',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.indigo),
          ),
        ),
      const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),
      _linhaPreparo('Ampola 150 mg/3 mL (50 mg/mL)', ''),

      const SizedBox(height: 16),
      const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),
      _linhaPreparo('Diluir sempre em SG 5% (nunca em SF)', ''),
      _linhaPreparo('Bolus: diluir 150 mg em 20 mL SG 5%', ''),
      _linhaPreparo('Infusão: 900 mg em 500 mL SG 5%', ''),

      const SizedBox(height: 16),
      const Text('Indicações clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),
      if (faixaEtaria == 'Recém-nascido') ...[
        _linhaIndicacaoDoseCalculada(
          titulo: 'Arritmias neonatais refratárias',
          descricaoDose: '5 mg/kg IV lento em 30–60 min (máx 300 mg)',
          unidade: 'mg',
          dosePorKg: 5.0,
          doseMaxima: 300,
          peso: peso,
        ),
      ] else if (faixaEtaria == 'Lactente' || faixaEtaria == 'Criança') ...[
        _linhaIndicacaoDoseCalculada(
          titulo: 'Parada cardíaca pediátrica (FV/TV sem pulso)',
          descricaoDose: '5 mg/kg IV bolus (máx 300 mg)',
          unidade: 'mg',
          dosePorKg: 5.0,
          doseMaxima: 300,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Arritmias pediátricas com pulso',
          descricaoDose: '5 mg/kg IV lento em 20–60 min.\nRepetir até 15 mg/kg/dia (máx 2,2 g)',
          unidade: 'mg',
          dosePorKgMinima: 5.0,
          dosePorKgMaxima: 15.0,
          doseMaxima: 2200,
          peso: peso,
        ),
      ] else if (faixaEtaria == 'Adolescente' || faixaEtaria == 'Adulto') ...[
        _linhaIndicacaoDoseCalculada(
          titulo: 'FV / TV sem pulso (parada)',
          descricaoDose: '300 mg IV bolus após 3º choque. Repetir 150 mg se necessário.',
          unidade: 'mg',
          doseMaxima: 300,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Arritmias com pulso (taquicardias)',
          descricaoDose: 'Bolus: 150 mg IV lento em 10 min.\nManutenção: 1 mg/min (6 h), depois 0,5 mg/min (18 h)',
          unidade: 'mg',
          doseMaxima: 150,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Taquicardia ventricular polimórfica',
          descricaoDose: '150 mg IV lento em 10 min, repetir se necessário',
          unidade: 'mg',
          doseMaxima: 150,
          peso: peso,
        ),
      ] else if (faixaEtaria == 'Idoso') ...[
        _linhaIndicacaoDoseCalculada(
          titulo: 'FV / TV sem pulso (parada)',
          descricaoDose: '300 mg IV bolus após 3º choque. Repetir 150 mg se necessário.',
          unidade: 'mg',
          doseMaxima: 300,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Arritmias com pulso (taquicardias)',
          descricaoDose: 'Bolus: 150 mg IV lento em 10 min.\nManutenção: 0,5 mg/min (24 h)',
          unidade: 'mg',
          doseMaxima: 150,
          peso: peso,
        ),
      ],

      const SizedBox(height: 16),
      const Text('Off-label', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),
      if (faixaEtaria == 'Recém-nascido') ...[
        _textoObs('• Uso em neonatos é off-label mas respaldado por diretrizes de arritmias neonatais.'),
      ] else if (faixaEtaria == 'Lactente' || faixaEtaria == 'Criança') ...[
        _textoObs('• Uso pediátrico é off-label mas amplamente aceito na prática clínica.'),
        _textoObs('• Doses pediátricas são baseadas em evidências limitadas.'),
      ] else if (faixaEtaria == 'Adolescente' || faixaEtaria == 'Adulto') ...[
        _textoObs('• Uso em taquicardia ventricular polimórfica é off-label mas padrão de tratamento.'),
        _textoObs('• Doses de manutenção podem ser necessárias por períodos prolongados.'),
      ] else if (faixaEtaria == 'Idoso') ...[
        _textoObs('• Em idosos, doses de manutenção mais baixas são recomendadas.'),
      ],

      const SizedBox(height: 16),
      const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),
      _textoObs('• Antiarrítmico classe III: bloqueia canais de potássio, sódio e cálcio.'),
      _textoObs('• Efeito prolongado e meia-vida longa (semanas).'),
      _textoObs('• Diluir sempre em SG 5%, risco de precipitação em SF.'),
      _textoObs('• Controle rigoroso de PA e ritmo (risco de hipotensão e bradicardia).'),
      _textoObs('• Evitar administrar por cateter periférico se possível (risco de flebite).'),
      _textoObs('• Monitorar função tireoidiana e hepática em uso prolongado.'),

      const SizedBox(height: 16),
      const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),
      _textoObs('• Metabolização hepática extensa.'),
      _textoObs('• Excreção principalmente fecal.'),
      _textoObs('• Meia-vida plasmática muito longa (25-110 dias).'),
      _textoObs('• Usar com extrema cautela em disfunção hepática grave.'),
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
      descricaoDose.contains('mg/min') ||
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
              'Dose calculada: ${doseCalculada.toStringAsFixed(2)} $unidade',
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
              'Dose calculada: ${doseCalculadaMin.toStringAsFixed(2)}–${doseCalculadaMax.toStringAsFixed(2)} $unidade',
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

class MedicamentoAmiodarona {
  static const String nome = 'Amiodarona';
  static const String idBulario = 'amiodarona';

  static Future<Map<String, dynamic>> carregarBulario() async {
    final String jsonStr = await rootBundle.loadString('assets/medicamentos/amiodarona.json');
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
      conteudo: _buildCardAmiodarona(
        context,
        peso,
        isAdulto,
        isFavorito,
        () => onToggleFavorito(nome),
      ),
    );
  }
} 