import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

/// Card de informações da Vasopressina
Widget _buildCardVasopressina(
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
      const Text('Vasopressina', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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
      _linhaPreparo('Ampola 20 UI/mL (solução injetável)', 'uso IV'),

      const SizedBox(height: 16),
      const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),
      _linhaPreparo('20 UI em 100 mL SF 0,9%', '0,2 UI/mL'),
      _linhaPreparo('20 UI em 50 mL SF 0,9%', '0,4 UI/mL'),
      _linhaPreparo('40 UI em 100 mL SF 0,9%', '0,4 UI/mL (alta concentração)'),

      const SizedBox(height: 16),
      const Text('Indicações clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),
      if (faixaEtaria == 'Recém-nascido') ...[
        _linhaIndicacaoDoseCalculada(
          titulo: 'Choque séptico neonatal refratário',
          descricaoDose: '0,0003–0,002 UI/kg/min IV contínua',
          peso: peso,
        ),
      ] else if (faixaEtaria == 'Lactente' || faixaEtaria == 'Criança') ...[
        _linhaIndicacaoDoseCalculada(
          titulo: 'Choque séptico pediátrico refratário',
          descricaoDose: '0,0003–0,002 UI/kg/min IV contínua',
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Parada cardíaca (dose única)',
          descricaoDose: '0,4 UI/kg IV bolus (máx 40 UI)',
          dosePorKg: 0.4,
          doseMaxima: 40,
          unidade: 'UI',
          peso: peso,
        ),
      ] else if (faixaEtaria == 'Adolescente' || faixaEtaria == 'Adulto') ...[
        _linhaIndicacaoDoseCalculada(
          titulo: 'Choque vasodilatador (sépse/refratário)',
          descricaoDose: '0,01–0,04 UI/min IV contínua',
          unidade: 'UI/min',
          dosePorKgMinima: 0.01 / peso,
          dosePorKgMaxima: 0.04 / peso,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Parada cardiorrespiratória',
          descricaoDose: '40 UI IV bolus (dose única alternativa à adrenalina)',
          doseMaxima: 40,
          unidade: 'UI',
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Choque neurogênico refratário',
          descricaoDose: '0,01–0,04 UI/min IV contínua',
          peso: peso,
        ),
      ] else if (faixaEtaria == 'Idoso') ...[
        _linhaIndicacaoDoseCalculada(
          titulo: 'Choque vasodilatador (sépse/refratário)',
          descricaoDose: '0,01–0,03 UI/min IV contínua',
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Parada cardiorrespiratória',
          descricaoDose: '40 UI IV bolus (dose única)',
          doseMaxima: 40,
          unidade: 'UI',
          peso: peso,
        ),
      ],

      const SizedBox(height: 16),
      const Text('Off-label', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),
      if (faixaEtaria == 'Recém-nascido') ...[
        _textoObs('• Uso off-label em neonatos com choque refratário, sob monitoração intensiva rigorosa.'),
      ] else if (faixaEtaria == 'Lactente' || faixaEtaria == 'Criança') ...[
        _textoObs('• Uso pediátrico é off-label mas respaldado por diretrizes de choque séptico pediátrico.'),
        _textoObs('• Dose única em PCR pediátrico é prática emergencial off-label.'),
      ] else if (faixaEtaria == 'Adolescente' || faixaEtaria == 'Adulto') ...[
        _textoObs('• Uso em choque neurogênico é off-label mas amplamente aceito na prática clínica.'),
        _textoObs('• Dose única em PCR é alternativa à adrenalina em casos específicos.'),
      ] else if (faixaEtaria == 'Idoso') ...[
        _textoObs('• Em idosos, doses mais baixas podem ser necessárias devido ao risco cardiovascular aumentado.'),
      ],

      const SizedBox(height: 16),
      const Text('Cálculo de Infusão', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),
      ConversaoInfusaoSlider(
        peso: peso,
        opcoesConcentracoes: {
          '20 UI/100 mL (0,2 UI/mL)': 0.2,
          '20 UI/50 mL (0,4 UI/mL)': 0.4,
          '40 UI/100 mL (0,4 UI/mL)': 0.4,
        },
        unidade: 'UI/min',
        doseMin: 0.01,
        doseMax: 0.04,
      ),

      const SizedBox(height: 16),
      const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),
      _textoObs('• Agonista de receptores V1 (vasoconstrição) e V2 (antidiurético).'),
      _textoObs('• Reduz necessidade de catecolaminas no choque séptico.'),
      _textoObs('• Pode causar isquemia periférica e visceral.'),
      _textoObs('• Monitorar sinais de isquemia e função renal.'),
      _textoObs('• Útil como droga de resgate em choque refratário.'),
      _textoObs('• Preferencialmente via acesso central.'),

      const SizedBox(height: 16),
      const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),
      _textoObs('• Metabolização hepática e renal.'),
      _textoObs('• Meia-vida plasmática de 10-20 minutos.'),
      _textoObs('• Excreção renal.'),
      _textoObs('• Usar com cautela em disfunção hepática ou renal grave.'),
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
      descricaoDose.contains('UI/kg/min') ||
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

class MedicamentoVasopressina {
  static const String nome = 'Vasopressina';
  static const String idBulario = 'vasopressina';

  static Future<Map<String, dynamic>> carregarBulario() async {
    final String jsonStr = await rootBundle.loadString('assets/medicamentos/vasopressina.json');
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
      conteudo: _buildCardVasopressina(
        context,
        peso,
        isAdulto,
        isFavorito,
        () => onToggleFavorito(nome),
      ),
    );
  }
} 