import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoMetoclopramida {
  static const String nome = 'Metoclopramida';
  static const String idBulario = 'metoclopramida';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/metoclopramida.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário do metoclopramida: $e');
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
      conteudo: _buildConteudoMetoclopramida(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoMetoclopramida(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Plasil®, Metoclopramida®'),
        _linhaInfo('Classificação', 'Antagonista dopaminérgico'),
        _linhaInfo('Mecanismo', 'Antagonista D2 + Procinético'),
        _linhaInfo('Duração', '6-8 horas'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Ampola 10mg/2mL', '5mg/mL'),
        _linhaInfo('Comprimido 10mg', 'Via oral'),
        _linhaInfo('Forma', 'Solução injetável'),
        _linhaInfo('Via', 'IV, IM, VO'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Bolus', 'IV lenta ou IM direta'),
        _linhaInfo('Infusão', 'Diluir em 20–50mL SF para infusão lenta'),
        _linhaInfo('Velocidade IV', '10mg em 2-3 minutos'),
        _linhaInfo('Estabilidade', '24h após diluição'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        if (isAdulto) ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Náuseas e vômitos',
            descricaoDose: '10mg IV lenta ou IM a cada 8h',
            unidade: 'mg',
            doseMaxima: 10,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Náuseas pós-operatórias',
            descricaoDose: '10mg IV lenta a cada 8h',
            unidade: 'mg',
            doseMaxima: 10,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Gastroparesia',
            descricaoDose: '10mg VO ou IV 3x/dia, 30min antes das refeições',
            unidade: 'mg',
            doseMaxima: 10,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Coadjuvante na enxaqueca',
            descricaoDose: '10mg IV lenta no início da crise (associado a AINEs)',
            unidade: 'mg',
            doseMaxima: 10,
            peso: peso,
          ),
        ] else ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Antiemético pediátrico',
            descricaoDose: '0,1–0,2 mg/kg IV ou IM a cada 8h',
            unidade: 'mg',
            dosePorKgMinima: 0.1,
            dosePorKgMaxima: 0.2,
            doseMaxima: 10,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Gastroparesia pediátrica',
            descricaoDose: '0,1 mg/kg VO 3x/dia',
            unidade: 'mg',
            dosePorKg: 0.1,
            peso: peso,
          ),
        ],

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Antagonista dopaminérgico com efeito antiemético e procinético'),
        _textoObs('• Útil em náuseas pós-operatórias, gastroenterite e enxaqueca'),
        _textoObs('• Pode causar efeitos extrapiramidais, especialmente em jovens'),
        _textoObs('• Evitar em pacientes com Parkinson ou uso de antipsicóticos'),
        _textoObs('• Contraindicado em epilepsia ou obstrução intestinal mecânica'),
        _textoObs('• Cuidado em pacientes com depressão'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Início de ação', '10–30 minutos (IV), 30–60 min (IM)'),
        _linhaInfo('Pico de efeito', '1–2 horas'),
        _linhaInfo('Duração', '6–8 horas'),
        _linhaInfo('Metabolização', 'Hepática'),
        _linhaInfo('Meia-vida', '5–6 horas'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade ao metoclopramida'),
        _textoObs('• Obstrução intestinal mecânica'),
        _textoObs('• Perfuração gastrintestinal'),
        _textoObs('• Hemorragia gastrintestinal'),
        _textoObs('• Epilepsia não controlada'),
        _textoObs('• Feocromocitoma'),

        // Reações Adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('Comuns (1–10%): Sonolência, diarreia, cefaleia'),
        _textoObs('Incomuns (0,1–1%): Efeitos extrapiramidais, galactorreia'),
        _textoObs('Raras (<0,1%): Síndrome neuroléptica maligna'),

        // Interações
        const SizedBox(height: 16),
        const Text('Interações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Potencializado por outros antagonistas D2'),
        _textoObs('• Potencializado por antipsicóticos'),
        _textoObs('• Antagonizado por levodopa'),
        _textoObs('• Pode reduzir absorção de digoxina'),
        _textoObs('• Pode aumentar absorção de outros fármacos'),

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