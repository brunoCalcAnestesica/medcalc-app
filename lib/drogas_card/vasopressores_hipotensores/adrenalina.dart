import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoAdrenalina {
  static const String nome = 'Adrenalina';
  static const String idBulario = 'adrenalina';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/adrenalina.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário da adrenalina: $e');
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
      conteudo: _buildConteudoAdrenalina(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoAdrenalina(BuildContext context, double peso, bool isAdulto) {
    final faixaEtaria = SharedData.faixaEtaria ?? '';
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        
        // Informações gerais
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        if (faixaEtaria.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 12),
            child: Text('Faixa etária: $faixaEtaria', style: const TextStyle(fontSize: 14)),
          ),
        
        // Apresentações
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('Ampola 1 mg/mL (1:1000)', 'uso IM/SC'),
        _linhaPreparo('Ampola 1 mg/10 mL (1:10.000)', 'uso IV'),
        _linhaPreparo('Auto-injetor 0,3 mg (adulto)', ''),
        _linhaPreparo('Auto-injetor 0,15 mg (infantil)', ''),

        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('1 mg puro (1 mL)', ''),
        _linhaPreparo('1 mg em 9 mL SF', '0,1 mg/mL (1:10.000)'),
        _linhaPreparo('6 mg em 94 mL SF', '60 mcg/mL'),
        _linhaPreparo('Push dose: 1 mg em 100 mL', '10 mcg/mL'),
        _linhaPreparo('Push dose: 0,5 mg em 10 mL', '50 mcg/mL'),

        const SizedBox(height: 16),
        const Text('Indicações clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _buildIndicacoesClinicas(faixaEtaria, peso),

        const SizedBox(height: 16),
        const Text('Off-label', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _buildOffLabel(faixaEtaria),

        const SizedBox(height: 16),
        const Text('Cálculo de Infusão', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        ConversaoInfusaoSlider(
          peso: peso,
          opcoesConcentracoes: {
            '6 mg/94 mL (60 mcg/mL)': 60,
          },
          unidade: 'mcg/kg/min',
          doseMin: 0.05,
          doseMax: 2.0,
        ),

        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Vasopressor e broncodilatador de ação imediata.'),
        _textoObs('• Ideal para situações de emergência.'),
        _textoObs('• Monitorar ritmo cardíaco e pressão arterial.'),
        _textoObs('• Risco de arritmias em altas doses.'),
        _textoObs('• Uso cuidadoso em idosos e cardiopatas.'),

        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Metabolização hepática por MAO e COMT.'),
        _textoObs('• Excreção renal.'),
        _textoObs('• Pode ter efeito prolongado em disfunção hepática grave.'),
        _textoObs('• Usar com cautela em disfunção renal ou cardíaca.'),

        const SizedBox(height: 16),
      ],
    );
  }

  static Widget _linhaPreparo(String texto, String observacao) {
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

  static Widget _buildIndicacoesClinicas(String faixaEtaria, double peso) {
    switch (faixaEtaria) {
      case 'Recém-nascido':
        return Column(
          children: [
            _linhaIndicacaoDoseCalculada(
              titulo: 'Parada cardíaca',
              descricaoDose: '0,01 mg/kg IV (1:10.000) cada 3–5 min',
              dosePorKg: 0.01,
              doseMaxima: 1.0,
              unidade: 'mg',
              peso: peso,
            ),
            _linhaIndicacaoDoseCalculada(
              titulo: 'Bradicardia neonatal',
              descricaoDose: '0,01 mg/kg IV (1:10.000) após ventilação adequada',
              dosePorKg: 0.01,
              doseMaxima: 1.0,
              unidade: 'mg',
              peso: peso,
            ),
            _linhaIndicacaoDoseCalculada(
              titulo: 'Choque refratário',
              descricaoDose: '0,05–2 mcg/kg/min IV infusão',
              peso: peso,
            ),
          ],
        );
      case 'Lactente':
      case 'Criança':
        return Column(
          children: [
            _linhaIndicacaoDoseCalculada(
              titulo: 'Parada cardíaca',
              descricaoDose: '0,01 mg/kg IV (1:10.000) cada 3–5 min (máx 1 mg)',
              dosePorKg: 0.01,
              doseMaxima: 1.0,
              unidade: 'mg',
              peso: peso,
            ),
            _linhaIndicacaoDoseCalculada(
              titulo: 'Anafilaxia',
              descricaoDose: '0,01 mg/kg IM (1:1000) (máx 0,3 mg)',
              dosePorKg: 0.01,
              doseMaxima: 0.3,
              unidade: 'mg',
              peso: peso,
            ),
            _linhaIndicacaoDoseCalculada(
              titulo: 'Broncoespasmo',
              descricaoDose: '0,01 mg/kg SC/IM (máx 0,3 mg)',
              dosePorKg: 0.01,
              doseMaxima: 0.3,
              unidade: 'mg',
              peso: peso,
            ),
            _linhaIndicacaoDoseCalculada(
              titulo: 'Crup',
              descricaoDose: '5 mg em 5 mL SF nebulizado (dose única)',
              peso: peso,
            ),
            _linhaIndicacaoDoseCalculada(
              titulo: 'Choque refratário',
              descricaoDose: '0,05–2 mcg/kg/min IV infusão',
              peso: peso,
            ),
            _linhaIndicacaoDoseCalculada(
              titulo: 'Bradicardia',
              descricaoDose: '0,01 mg/kg IV bolus (máx 1 mg) + 0,1–1 mcg/kg/min infusão',
              dosePorKg: 0.01,
              doseMaxima: 1.0,
              unidade: 'mg',
              peso: peso,
            ),
          ],
        );
      case 'Adolescente':
      case 'Adulto':
        return Column(
          children: [
            _linhaIndicacaoDoseCalculada(
              titulo: 'Parada cardíaca',
              descricaoDose: '1 mg IV (1:10.000) cada 3–5 min',
              dosePorKg: 1.0,
              doseMaxima: 1.0,
              unidade: 'mg',
              peso: peso,
            ),
            _linhaIndicacaoDoseCalculada(
              titulo: 'Anafilaxia',
              descricaoDose: '0,3–0,5 mg IM (1:1000)',
              dosePorKgMinima: 0.3,
              dosePorKgMaxima: 0.5,
              doseMaxima: 0.5,
              unidade: 'mg',
              peso: peso,
            ),
            _linhaIndicacaoDoseCalculada(
              titulo: 'Broncoespasmo',
              descricaoDose: '0,3–0,5 mg SC/IM (1:1000)',
              dosePorKgMinima: 0.3,
              dosePorKgMaxima: 0.5,
              doseMaxima: 0.5,
              unidade: 'mg',
              peso: peso,
            ),
            _linhaIndicacaoDoseCalculada(
              titulo: 'Choque refratário',
              descricaoDose: '0,05–2 mcg/kg/min IV infusão',
              peso: peso,
            ),
            _linhaIndicacaoDoseCalculada(
              titulo: 'Bradicardia',
              descricaoDose: '2–10 mL/h IV infusão contínua',
              unidade: 'mL/h',
              dosePorKgMinima: 2 / peso,
              dosePorKgMaxima: 10 / peso,
              peso: peso,
            ),
          ],
        );
      case 'Idoso':
        return Column(
          children: [
            _linhaIndicacaoDoseCalculada(
              titulo: 'Parada cardíaca',
              descricaoDose: '1 mg IV (1:10.000) cada 3–5 min',
              dosePorKg: 1.0,
              doseMaxima: 1.0,
              unidade: 'mg',
              peso: peso,
            ),
            _linhaIndicacaoDoseCalculada(
              titulo: 'Anafilaxia',
              descricaoDose: '0,3–0,5 mg IM (1:1000)',
              dosePorKgMinima: 0.3,
              dosePorKgMaxima: 0.5,
              doseMaxima: 0.5,
              unidade: 'mg',
              peso: peso,
            ),
            _linhaIndicacaoDoseCalculada(
              titulo: 'Broncoespasmo',
              descricaoDose: '0,3–0,5 mg SC/IM (1:1000)',
              dosePorKgMinima: 0.3,
              dosePorKgMaxima: 0.5,
              doseMaxima: 0.5,
              unidade: 'mg',
              peso: peso,
            ),
            _linhaIndicacaoDoseCalculada(
              titulo: 'Choque refratário',
              descricaoDose: '0,05–2 mcg/kg/min IV infusão',
              peso: peso,
            ),
            _linhaIndicacaoDoseCalculada(
              titulo: 'Bradicardia',
              descricaoDose: '2–10 mL/h IV infusão contínua',
              unidade: 'mL/h',
              dosePorKgMinima: 2 / peso,
              dosePorKgMaxima: 10 / peso,
              peso: peso,
            ),
          ],
        );
      default:
        return Column(
          children: [
            _linhaIndicacaoDoseCalculada(
              titulo: 'Parada cardíaca',
              descricaoDose: '1 mg IV (1:10.000) cada 3–5 min',
              dosePorKg: 1.0,
              doseMaxima: 1.0,
              unidade: 'mg',
              peso: peso,
            ),
            _linhaIndicacaoDoseCalculada(
              titulo: 'Anafilaxia',
              descricaoDose: '0,3–0,5 mg IM (1:1000)',
              dosePorKgMinima: 0.3,
              dosePorKgMaxima: 0.5,
              doseMaxima: 0.5,
              unidade: 'mg',
              peso: peso,
            ),
            _linhaIndicacaoDoseCalculada(
              titulo: 'Broncoespasmo',
              descricaoDose: '0,3–0,5 mg SC/IM (1:1000)',
              dosePorKgMinima: 0.3,
              dosePorKgMaxima: 0.5,
              doseMaxima: 0.5,
              unidade: 'mg',
              peso: peso,
            ),
            _linhaIndicacaoDoseCalculada(
              titulo: 'Choque refratário',
              descricaoDose: '0,05–2 mcg/kg/min IV infusão',
              peso: peso,
            ),
          ],
        );
    }
  }

  static Widget _buildOffLabel(String faixaEtaria) {
    String textoOffLabel = '';
    
    switch (faixaEtaria) {
      case 'Recém-nascido':
        textoOffLabel = '• Uso off-label restrito a bradicardia refratária e choque com indicação de infusão contínua sob monitoração intensiva.';
        break;
      case 'Lactente':
      case 'Criança':
        textoOffLabel = '• Nebulização em crup viral grave é prática consagrada, porém não consta em bula.';
        break;
      case 'Adolescente':
      case 'Adulto':
        textoOffLabel = '• Infusão contínua para bradicardia refratária é fora da bula, mas respaldada por diretrizes clínicas em situações críticas.';
        break;
      case 'Idoso':
        textoOffLabel = '• Em idosos, uso para bradicardia refratária é off-label e demanda monitorização rigorosa devido ao risco cardiovascular aumentado.';
        break;
      default:
        textoOffLabel = '• Uso off-label deve ser avaliado individualmente conforme diretrizes clínicas.';
    }

    return _textoObs(textoOffLabel);
  }

  static Widget _linhaIndicacaoDoseCalculada({
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

    // Identificar se é dose de infusão
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

  static Widget _textoObs(String texto) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        texto,
        style: const TextStyle(fontSize: 13),
      ),
    );
  }
}