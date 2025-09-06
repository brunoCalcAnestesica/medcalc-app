import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoLorazepam {
  static const String nome = 'Lorazepam';
  static const String idBulario = 'lorazepam';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/lorazepam.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário do lorazepam: $e');
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
      conteudo: _buildConteudoLorazepam(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoLorazepam(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Lorax®, Ativan®, Lorazepam®'),
        _linhaInfo('Classificação', 'Benzodiazepínico de duração intermediária'),
        _linhaInfo('Mecanismo', 'Agonista do receptor GABA-A'),
        _linhaInfo('Duração', 'Intermediária (8-12h)'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Ampola 4mg/1mL', '1mL = 4mg'),
        _linhaInfo('Forma', 'Solução injetável'),
        _linhaInfo('Via', 'IV, IM, VO'),
        _linhaInfo('Concentração', '4mg/mL'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Bolus', 'Uso direto IV ou IM lenta'),
        _linhaInfo('Velocidade IV', '2mg/min máximo'),
        _linhaInfo('Diluição', 'Evitar SF - instável'),
        _linhaInfo('Alternativa', 'SG 5% se necessário'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        if (isAdulto) ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Estado de mal epiléptico',
            descricaoDose: '4mg IV lenta (2mg/min máx) → repetir após 10–15min',
            unidade: 'mg',
            doseMaxima: 8,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Agitação psicomotora',
            descricaoDose: '1–2mg IV ou IM a cada 6–8h se necessário',
            unidade: 'mg',
            doseMaxima: 2,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Ansiedade / Pré-medicação',
            descricaoDose: '0,05 mg/kg IM ou VO 1h antes',
            unidade: 'mg',
            dosePorKgMinima: 0.03,
            dosePorKgMaxima: 0.05,
            doseMaxima: 4,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Sedação em UTI',
            descricaoDose: '0,02–0,05 mg/kg IV a cada 6–8h',
            unidade: 'mg',
            dosePorKgMinima: 0.02,
            dosePorKgMaxima: 0.05,
            peso: peso,
          ),
        ] else ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Crise convulsiva pediátrica',
            descricaoDose: '0,05–0,1 mg/kg IV lenta (máx 4mg)',
            unidade: 'mg',
            dosePorKgMinima: 0.05,
            dosePorKgMaxima: 0.1,
            doseMaxima: 4,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Sedação leve UTI pediátrica',
            descricaoDose: '0,02–0,05 mg/kg IV a cada 6–8h',
            unidade: 'mg',
            dosePorKgMinima: 0.02,
            dosePorKgMaxima: 0.05,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Ansiedade pediátrica',
            descricaoDose: '0,02–0,05 mg/kg IM ou VO',
            unidade: 'mg',
            dosePorKgMinima: 0.02,
            dosePorKgMaxima: 0.05,
            peso: peso,
          ),
        ],

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Benzodiazepínico de duração intermediária'),
        _textoObs('• Primeira linha no status epilepticus hospitalar'),
        _textoObs('• Evitar infusão contínua – risco de acúmulo'),
        _textoObs('• Antagonizável com flumazenil'),
        _textoObs('• Metabolismo hepático independente da idade'),
        _textoObs('• Menos depressão respiratória que midazolam'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Início de ação', '1–3 minutos (IV), 15–30 min (IM)'),
        _linhaInfo('Pico de efeito', '15–30 minutos (IV)'),
        _linhaInfo('Duração', '8–12 horas'),
        _linhaInfo('Metabolização', 'Hepática (glicuronidação)'),
        _linhaInfo('Meia-vida', '10–20 horas'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade ao lorazepam'),
        _textoObs('• Glaucoma de ângulo fechado'),
        _textoObs('• Miastenia gravis'),
        _textoObs('• Apneia do sono grave'),
        _textoObs('• Insuficiência respiratória grave'),

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
        _textoObs('• Potencializado por outros sedativos'),
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