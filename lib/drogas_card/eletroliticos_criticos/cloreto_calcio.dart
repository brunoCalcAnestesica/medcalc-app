import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoCloretoCalcio {
  static const String nome = 'Cloreto de Cálcio';
  static const String idBulario = 'cloreto_calcio';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/cloreto_calcio.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário do cloreto de cálcio: $e');
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
      conteudo: _buildConteudoCloretoCalcio(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoCloretoCalcio(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Hipercal®, Calcium Chloride®'),
        _linhaInfo('Classificação', 'Eletrolítico crítico'),
        _linhaInfo('Mecanismo', 'Reposição de cálcio ionizado'),
        _linhaInfo('Concentração', '10% (1g/10mL = 27mg/mL Ca²⁺)'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Ampola 10%', '1g/10mL = 27mg/mL de Ca²⁺'),
        _linhaInfo('Concentração', '100mg/mL (cloreto)'),
        _linhaInfo('Cálcio elementar', '27mg/mL (3x mais que gluconato)'),
        _linhaInfo('Osmolaridade', '2040 mOsm/L (hipertônica)'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Via IV', 'Lenta (3–5 min) ou infusão em bomba'),
        _linhaInfo('Acesso', 'Preferir acesso central'),
        _linhaInfo('Evitar', 'Via periférica — risco de necrose'),
        _linhaInfo('Diluição', 'Pode ser usado direto ou diluído'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        _linhaIndicacaoDoseCalculada(
          titulo: 'Hipocalcemia sintomática / Hipercalemia grave',
          descricaoDose: '10–20mg/kg Ca²⁺ elementar IV lenta (máx 1g)',
          unidade: 'mg',
          dosePorKgMinima: 10,
          dosePorKgMaxima: 20,
          doseMaxima: 1000,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Intoxicação por bloqueadores de canal de cálcio',
          descricaoDose: '500–1000mg (1 ampola) IV em bolus + infusão contínua (0,5–1 mg/kg/h)',
          unidade: 'mg',
          doseMaxima: 1000,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Antagonismo da toxicidade do magnésio',
          descricaoDose: '500–1000mg IV lenta',
          unidade: 'mg',
          doseMaxima: 1000,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Parada cardiorrespiratória (hipocalcemia)',
          descricaoDose: '500–1000mg IV em bolus',
          unidade: 'mg',
          doseMaxima: 1000,
          peso: peso,
        ),

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Reposição mais concentrada que gluconato'),
        _textoObs('• 3x mais cálcio elementar que o gluconato de cálcio'),
        _textoObs('• Incompatível com bicarbonato na mesma via (precipita)'),
        _textoObs('• Extravasamento → risco de necrose → preferir acesso central'),
        _textoObs('• Monitorar ECG e eletrólitos durante infusão'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Início de ação', 'Imediato (bolus IV)'),
        _linhaInfo('Pico de efeito', '2–5 minutos'),
        _linhaInfo('Duração', '30–60 minutos'),
        _linhaInfo('Distribuição', '50% ligado à albumina'),
        _linhaInfo('Eliminação', 'Renal (60%) e fecal (40%)'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade ao cloreto de cálcio'),
        _textoObs('• Hipercalcemia'),
        _textoObs('• Insuficiência renal grave'),
        _textoObs('• Arritmias cardíacas'),

        // Reações Adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('Comuns (1–10%): Sensação de calor, rubor'),
        _textoObs('Incomuns (0,1–1%): Bradicardia, arritmias'),
        _textoObs('Raras (<0,1%): Extravasamento com necrose tecidual'),

        // Interações
        const SizedBox(height: 16),
        const Text('Interações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Incompatível com bicarbonato de sódio'),
        _textoObs('• Potencializa digitálicos'),
        _textoObs('• Interfere com absorção de tetraciclinas'),

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