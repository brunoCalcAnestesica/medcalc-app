import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

/// Card de informações da Atropina
Widget _buildCardAtropina(
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
      const Text('Atropina', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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
      _linhaPreparo('Ampola 0,5 mg/mL ou 1 mg/mL (1 mL)', 'Atropina Sulfato®'),

      const SizedBox(height: 16),
      const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),
      _linhaPreparo('Uso IV direto em bolus ou diluída em SF 0,9%', ''),
      _linhaPreparo('Pode ser usada também por via IM, SC ou endotraqueal (em emergências)', ''),

      const SizedBox(height: 16),
      const Text('Indicações clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),
      if (faixaEtaria == 'Recém-nascido') ...[
        _linhaIndicacaoDoseCalculada(
          titulo: 'Bradicardia neonatal',
          descricaoDose: '0,02 mg/kg IV (mín 0,1 mg – máx 0,5 mg por dose)',
          unidade: 'mg',
          dosePorKg: 0.02,
          doseMaxima: 0.5,
          peso: peso,
        ),
      ] else if (faixaEtaria == 'Lactente' || faixaEtaria == 'Criança') ...[
        _linhaIndicacaoDoseCalculada(
          titulo: 'Bradicardia sintomática',
          descricaoDose: '0,02 mg/kg IV (mín 0,1 mg – máx 0,5 mg por dose)',
          unidade: 'mg',
          dosePorKg: 0.02,
          doseMaxima: 0.5,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Pré-medicação anestésica',
          descricaoDose: '0,01–0,02 mg/kg IM 30–60 min antes da indução (máx 1 mg)',
          unidade: 'mg',
          dosePorKgMinima: 0.01,
          dosePorKgMaxima: 0.02,
          doseMaxima: 1.0,
          peso: peso,
        ),
      ] else if (faixaEtaria == 'Adolescente' || faixaEtaria == 'Adulto') ...[
        _linhaIndicacaoDoseCalculada(
          titulo: 'Bradicardia sintomática',
          descricaoDose: '0,5 mg IV a cada 3–5 min (máximo 3 mg)',
          unidade: 'mg',
          dosePorKgMinima: 0.5 / peso,
          dosePorKgMaxima: 0.5 / peso,
          doseMaxima: 3.0,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Intoxicação por organofosforado ou carbamato',
          descricaoDose: '2–5 mg IV lenta a cada 5–10 min até sinais de atropinização (sem dose máxima)',
          unidade: 'mg',
          dosePorKgMinima: 2.0 / peso,
          doseMaxima: 5.0,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Pré-medicação anestésica',
          descricaoDose: '0,01–0,02 mg/kg IM 30–60 min antes da indução (máx 1 mg)',
          unidade: 'mg',
          dosePorKgMinima: 0.01,
          dosePorKgMaxima: 0.02,
          doseMaxima: 1.0,
          peso: peso,
        ),
      ] else if (faixaEtaria == 'Idoso') ...[
        _linhaIndicacaoDoseCalculada(
          titulo: 'Bradicardia sintomática',
          descricaoDose: '0,5 mg IV a cada 3–5 min (máximo 2 mg)',
          unidade: 'mg',
          dosePorKgMinima: 0.5 / peso,
          dosePorKgMaxima: 0.5 / peso,
          doseMaxima: 2.0,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Pré-medicação anestésica',
          descricaoDose: '0,01 mg/kg IM 30–60 min antes da indução (máx 0,5 mg)',
          unidade: 'mg',
          dosePorKg: 0.01,
          doseMaxima: 0.5,
          peso: peso,
        ),
      ],

      const SizedBox(height: 16),
      const Text('Off-label', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),
      if (faixaEtaria == 'Recém-nascido') ...[
        _textoObs('• Uso em neonatos é off-label mas respaldado por diretrizes de RCP neonatal.'),
      ] else if (faixaEtaria == 'Lactente' || faixaEtaria == 'Criança') ...[
        _textoObs('• Uso pediátrico é off-label mas amplamente aceito na prática clínica.'),
      ] else if (faixaEtaria == 'Adolescente' || faixaEtaria == 'Adulto') ...[
        _textoObs('• Uso em intoxicações por organofosforados é off-label mas padrão de tratamento.'),
        _textoObs('• Doses altas em intoxicações podem ser necessárias sem limite máximo.'),
      ] else if (faixaEtaria == 'Idoso') ...[
        _textoObs('• Em idosos, doses mais baixas são recomendadas devido ao risco cardiovascular aumentado.'),
      ],

      const SizedBox(height: 16),
      const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),
      _textoObs('• Antagonista muscarínico → inibe ação vagal e secreções.'),
      _textoObs('• Primeira escolha para bradicardias sintomáticas e intoxicações colinérgicas.'),
      _textoObs('• Sinais de atropinização: taquicardia, midríase, pele seca, confusão.'),
      _textoObs('• Em intoxicações, manter dose até controle de secreções e FC >80 bpm.'),
      _textoObs('• Cuidado em idosos e cardiopatas: risco de arritmias e retenção urinária.'),

      const SizedBox(height: 16),
      const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),
      _textoObs('• Metabolização hepática.'),
      _textoObs('• Excreção renal (50-60% inalterada).'),
      _textoObs('• Meia-vida plasmática de 2-4 horas.'),
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

class MedicamentoAtropina {
  static const String nome = 'Atropina';
  static const String idBulario = 'atropina';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/atropina.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário do atropina: $e');
      return {};
    }
  }

  static Widget buildCard(BuildContext context, Set<String> favoritos, void Function(String) onToggleFavorito) {
    final peso = SharedData.peso ?? 70;
    final idade = SharedData.idade ?? 18;
    final isAdulto = idade >= 18;
    final isFavorito = favoritos.contains(nome);

    return buildMedicamentoExpansivel(
      context: context,
      nome: nome,
      idBulario: idBulario,
      isFavorito: isFavorito,
      onToggleFavorito: () => onToggleFavorito(nome),
      conteudo: _buildConteudoAtropina(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoAtropina(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Atropina Sulfato®, Atropina®'),
        _linhaInfo('Classificação', 'Anticolinérgico'),
        _linhaInfo('Mecanismo', 'Antagonista muscarínico competitivo'),
        _linhaInfo('Duração', '2-4 horas'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Ampola 0,5mg/mL', '1mL = 0,5mg'),
        _linhaInfo('Ampola 1mg/mL', '1mL = 1mg'),
        _linhaInfo('Forma', 'Solução injetável'),
        _linhaInfo('Via', 'IV, IM, SC, ET'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Bolus', 'Uso IV direto ou diluído em SF'),
        _linhaInfo('IM/SC', 'Uso direto sem diluição'),
        _linhaInfo('Endotraqueal', 'Diluir em 2-5mL SF'),
        _linhaInfo('Estabilidade', '24h após diluição'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        if (isAdulto) ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Bradicardia sintomática',
            descricaoDose: '0,5 mg IV a cada 3–5 min',
            unidade: 'mg',
            dosePorKg: 0.5 / peso,
            doseMaxima: 3.0,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Intoxicação por organofosforado',
            descricaoDose: '2–5 mg IV lenta a cada 5–10 min até atropinização',
            unidade: 'mg',
            dosePorKgMinima: 2.0 / peso,
            dosePorKgMaxima: 5.0 / peso,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Pré-medicação anestésica',
            descricaoDose: '0,01–0,02 mg/kg IM 30–60 min antes da indução',
            unidade: 'mg',
            dosePorKgMinima: 0.01,
            dosePorKgMaxima: 0.02,
            doseMaxima: 1.0,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Bradicardia em RCP',
            descricaoDose: '1 mg IV a cada 3–5 min',
            unidade: 'mg',
            doseMaxima: 3.0,
            peso: peso,
          ),
        ] else ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Bradicardia sintomática pediátrica',
            descricaoDose: '0,02 mg/kg IV (mín 0,1 mg – máx 0,5 mg)',
            unidade: 'mg',
            dosePorKg: 0.02,
            doseMaxima: 0.5,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Pré-medicação anestésica pediátrica',
            descricaoDose: '0,01–0,02 mg/kg IM 30–60 min antes da indução',
            unidade: 'mg',
            dosePorKgMinima: 0.01,
            dosePorKgMaxima: 0.02,
            doseMaxima: 1.0,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Bradicardia neonatal',
            descricaoDose: '0,02 mg/kg IV (mín 0,1 mg – máx 0,5 mg)',
            unidade: 'mg',
            dosePorKg: 0.02,
            doseMaxima: 0.5,
            peso: peso,
          ),
        ],

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Antagonista muscarínico → inibe ação vagal e secreções'),
        _textoObs('• Primeira escolha para bradicardias sintomáticas e intoxicações colinérgicas'),
        _textoObs('• Sinais de atropinização: taquicardia, midríase, pele seca, confusão'),
        _textoObs('• Em intoxicações, manter dose até controle de secreções e FC >80 bpm'),
        _textoObs('• Cuidado em idosos e cardiopatas: risco de arritmias e retenção urinária'),
        _textoObs('• Contraindicado em glaucoma de ângulo fechado'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Início de ação', '1–2 minutos (IV), 15–30 min (IM)'),
        _linhaInfo('Pico de efeito', '15–30 minutos'),
        _linhaInfo('Duração', '2–4 horas'),
        _linhaInfo('Metabolização', 'Hepática'),
        _linhaInfo('Meia-vida', '2–4 horas'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade ao atropina'),
        _textoObs('• Glaucoma de ângulo fechado'),
        _textoObs('• Hiperplasia prostática benigna'),
        _textoObs('• Retenção urinária'),
        _textoObs('• Miastenia gravis'),

        // Reações Adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('Comuns (1–10%): Taquicardia, boca seca, visão turva'),
        _textoObs('Incomuns (0,1–1%): Retenção urinária, delirium'),
        _textoObs('Raras (<0,1%): Arritmias cardíacas, reações alérgicas'),

        // Interações
        const SizedBox(height: 16),
        const Text('Interações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Potencializado por outros anticolinérgicos'),
        _textoObs('• Potencializado por antidepressivos tricíclicos'),
        _textoObs('• Antagonizado por anticolinesterásicos'),
        _textoObs('• Pode reduzir absorção de outros fármacos'),

        const SizedBox(height: 16),
      ],
    );
  }

  static Widget _linhaInfo(String titulo, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(titulo, style: const TextStyle(fontWeight: FontWeight.w500)),
          ),
          Expanded(child: Text(valor)),
        ],
      ),
    );
  }

  static Widget _linhaIndicacaoDoseCalculada({
    required String titulo,
    required String descricaoDose,
    required String unidade,
    double? dosePorKg,
    double? dosePorKgMinima,
    double? dosePorKgMaxima,
    double? doseMaxima,
    required double peso,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titulo, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(descricaoDose, style: const TextStyle(fontSize: 13)),
          if (dosePorKg != null) 
            Text('Dose: ${(dosePorKg * peso).toStringAsFixed(1)} $unidade', 
                 style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.blue)),
          if (dosePorKgMinima != null && dosePorKgMaxima != null)
            Text('Dose: ${(dosePorKgMinima * peso).toStringAsFixed(1)}–${(dosePorKgMaxima * peso).toStringAsFixed(1)} $unidade', 
                 style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.blue)),
          if (doseMaxima != null) 
            Text('Dose máxima: $doseMaxima $unidade', 
                 style: const TextStyle(fontSize: 12, color: Colors.red)),
        ],
      ),
    );
  }

  static Widget _textoObs(String texto) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Text(texto, style: const TextStyle(fontSize: 13, color: Colors.black87)),
    );
  }
} 