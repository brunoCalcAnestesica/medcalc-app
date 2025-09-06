import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoBicarbonatoSodio {
  static const String nome = 'Bicarbonato de Sódio';
  static const String idBulario = 'bicarbonato_sodio';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/bicarbonato_sodio.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário do bicarbonato de sódio: $e');
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
      conteudo: _buildConteudoBicarbonatoSodio(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoBicarbonatoSodio(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Bicarbonato de Sódio®, Sodium Bicarbonate®'),
        _linhaInfo('Classificação', 'Alcalinizante sistêmico'),
        _linhaInfo('Mecanismo', 'Neutralização de ácidos, tampão bicarbonato'),
        _linhaInfo('pH', '8,4 (solução alcalina)'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Ampola 8,4%', '1 mEq/mL – 10mL = 10 mEq'),
        _linhaInfo('Ampola 50mL', '50 mEq (8,4%)'),
        _linhaInfo('Concentração', '1 mEq/mL'),
        _linhaInfo('Osmolaridade', '2000 mOsm/L (hipertônica)'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Bolus IV', 'Pode ser usado direto IV em bolus'),
        _linhaInfo('Diluição', 'Diluir em SG 5% se necessário'),
        _linhaInfo('Evitar', 'Diluir em SF 0,9% – risco de precipitação'),
        _linhaInfo('Via', 'IV lenta (1–2min)'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        _linhaIndicacaoDoseCalculada(
          titulo: 'Parada cardiorrespiratória (acidose metabólica)',
          descricaoDose: '1 mEq/kg em bolus IV (Ex: 1 ampola 50mL = 50 mEq)',
          unidade: 'mEq',
          dosePorKg: 1.0,
          doseMaxima: 100,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Intoxicação por antidepressivos tricíclicos ou salicilatos',
          descricaoDose: '1–2 mEq/kg IV lenta + infusão contínua (pH alvo 7,45–7,55)',
          unidade: 'mEq',
          dosePorKgMinima: 1.0,
          dosePorKgMaxima: 2.0,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Hipercalemia com alterações no ECG',
          descricaoDose: '50–100 mEq IV lenta (com monitoramento contínuo)',
          unidade: 'mEq',
          doseMaxima: 100,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Acidose metabólica grave (pH < 7,1)',
          descricaoDose: '0,5–1 mEq/kg IV lenta, repetir conforme necessário',
          unidade: 'mEq',
          dosePorKgMinima: 0.5,
          dosePorKgMaxima: 1.0,
          peso: peso,
        ),

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Alcalinizante sistêmico para acidose grave e intoxicações específicas'),
        _textoObs('• Monitorar pH arterial e potássio sérico'),
        _textoObs('• Pode causar hipernatremia, alcalose e sobrecarga volêmica'),
        _textoObs('• Uso em PCR apenas se acidose metabólica evidente'),
        _textoObs('• Extravasamento → risco de necrose tecidual'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Início de ação', 'Imediato (bolus IV)'),
        _linhaInfo('Pico de efeito', '2–5 minutos'),
        _linhaInfo('Duração', '30–60 minutos'),
        _linhaInfo('Eliminação', 'Renal (como CO2 e água)'),
        _linhaInfo('Meia-vida', 'Variável (depende da função renal)'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade ao bicarbonato de sódio'),
        _textoObs('• Alcalose metabólica'),
        _textoObs('• Edema pulmonar'),
        _textoObs('• Insuficiência cardíaca congestiva'),

        // Reações Adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('Comuns (1–10%): Hipernatremia, alcalose metabólica'),
        _textoObs('Incomuns (0,1–1%): Hipocalemia, tetania'),
        _textoObs('Raras (<0,1%): Extravasamento com necrose tecidual'),

        // Interações
        const SizedBox(height: 16),
        const Text('Interações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Incompatível com cálcio, catecolaminas'),
        _textoObs('• Pode precipitar com SF 0,9%'),
        _textoObs('• Altera absorção de outros medicamentos'),

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