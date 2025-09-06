import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoDiazepam {
  static const String nome = 'Diazepam';
  static const String idBulario = 'diazepam';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/diazepam.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário do diazepam: $e');
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
      conteudo: _buildConteudoDiazepam(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoDiazepam(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Valium®, Uni-Diazepam®, Diazepam®'),
        _linhaInfo('Classificação', 'Benzodiazepínico de longa duração'),
        _linhaInfo('Mecanismo', 'Agonista do receptor GABA-A'),
        _linhaInfo('Duração', 'Longa (24-48h)'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Ampola 10mg/2mL', '5mg/mL'),
        _linhaInfo('Forma', 'Solução injetável'),
        _linhaInfo('Via', 'IV, IM, VO'),
        _linhaInfo('Concentração', '5mg/mL'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Bolus', 'Uso direto IV ou IM'),
        _linhaInfo('Velocidade IV', '5mg/min máximo'),
        _linhaInfo('Diluição', 'Evitar - instável em soluções aquosas'),
        _linhaInfo('Estabilidade', '24h após abertura'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        if (isAdulto) ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Crise convulsiva aguda',
            descricaoDose: '5–10 mg IV lenta ou IM (repetir após 10–15min)',
            unidade: 'mg',
            doseMaxima: 20,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Abstinência alcoólica',
            descricaoDose: '10 mg IV ou IM a cada 6–8h',
            unidade: 'mg',
            doseMaxima: 10,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Agitação psicomotora',
            descricaoDose: '5–10 mg IV ou IM',
            unidade: 'mg',
            doseMaxima: 10,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Ansiedade / Pré-medicação',
            descricaoDose: '0,1–0,2 mg/kg IM ou VO',
            unidade: 'mg',
            dosePorKgMinima: 0.1,
            dosePorKgMaxima: 0.2,
            doseMaxima: 10,
            peso: peso,
          ),
        ] else ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Convulsão pediátrica',
            descricaoDose: '0,2–0,3 mg/kg IV (máx 10mg)',
            unidade: 'mg',
            dosePorKgMinima: 0.2,
            dosePorKgMaxima: 0.3,
            doseMaxima: 10,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Sedação leve',
            descricaoDose: '0,1–0,2 mg/kg IM',
            unidade: 'mg',
            dosePorKgMinima: 0.1,
            dosePorKgMaxima: 0.2,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Ansiedade pediátrica',
            descricaoDose: '0,05–0,1 mg/kg IM ou VO',
            unidade: 'mg',
            dosePorKgMinima: 0.05,
            dosePorKgMaxima: 0.1,
            peso: peso,
          ),
        ],

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Ação longa, risco de acúmulo'),
        _textoObs('• Contraindicado para infusão contínua'),
        _textoObs('• Antagonizável com flumazenil'),
        _textoObs('• Metabolismo hepático extenso'),
        _textoObs('• Metabólitos ativos de longa duração'),
        _textoObs('• Cuidado em idosos e insuficiência hepática'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Início de ação', '1–3 minutos (IV), 15–30 min (IM)'),
        _linhaInfo('Pico de efeito', '15–30 minutos (IV)'),
        _linhaInfo('Duração', '24–48 horas'),
        _linhaInfo('Metabolização', 'Hepática (CYP2C19, CYP3A4)'),
        _linhaInfo('Meia-vida', '20–50 horas'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade ao diazepam'),
        _textoObs('• Glaucoma de ângulo fechado'),
        _textoObs('• Miastenia gravis'),
        _textoObs('• Apneia do sono grave'),
        _textoObs('• Insuficiência respiratória grave'),
        _textoObs('• Infusão contínua'),

        // Reações Adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('Comuns (1–10%): Sedação, amnésia, depressão respiratória'),
        _textoObs('Incomuns (0,1–1%): Paradoja, hipotensão'),
        _textoObs('Raras (<0,1%): Reações alérgicas graves'),

        // Interações
        const SizedBox(height: 16),
        const Text('Interações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Potencializado por opioides'),
        _textoObs('• Potencializado por álcool'),
        _textoObs('• Potencializado por inibidores CYP2C19'),
        _textoObs('• Antagonizado por flumazenil'),

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