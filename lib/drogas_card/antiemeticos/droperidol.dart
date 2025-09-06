import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoDroperidol {
  static const String nome = 'Droperidol';
  static const String idBulario = 'droperidol';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/droperidol.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário do droperidol: $e');
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
      conteudo: _buildConteudoDroperidol(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoDroperidol(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Droperidol®, Inapsine®'),
        _linhaInfo('Classificação', 'Antipsicótico butirofenona'),
        _linhaInfo('Mecanismo', 'Antagonista D2 + Antiemético'),
        _linhaInfo('Duração', '2-4 horas'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Ampola 2,5mg/mL', '2mL = 5mg'),
        _linhaInfo('Ampola 5mg/mL', '1mL = 5mg'),
        _linhaInfo('Forma', 'Solução injetável'),
        _linhaInfo('Via', 'IV, IM'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Bolus', 'IV lenta ou IM direta'),
        _linhaInfo('Infusão', 'Diluir em SF para infusão lenta'),
        _linhaInfo('Velocidade IV', '2,5mg em 2-3 minutos'),
        _linhaInfo('Estabilidade', '24h após diluição'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        if (isAdulto) ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Náuseas e vômitos refratários',
            descricaoDose: '0,625–1,25mg IV lenta',
            unidade: 'mg',
            dosePorKgMinima: 0.01,
            dosePorKgMaxima: 0.02,
            doseMaxima: 1.25,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Agitação psicomotora',
            descricaoDose: '2,5–5mg IM ou IV lenta',
            unidade: 'mg',
            dosePorKgMinima: 0.03,
            dosePorKgMaxima: 0.07,
            doseMaxima: 5,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Sedação rápida',
            descricaoDose: '5–10mg IM ou IV lenta',
            unidade: 'mg',
            dosePorKgMinima: 0.07,
            dosePorKgMaxima: 0.15,
            doseMaxima: 10,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Delírio agudo',
            descricaoDose: '2,5–5mg IM ou IV lenta',
            unidade: 'mg',
            dosePorKgMinima: 0.03,
            dosePorKgMaxima: 0.07,
            doseMaxima: 5,
            peso: peso,
          ),
        ] else ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Antiemético pediátrico',
            descricaoDose: '0,015–0,05 mg/kg IV ou IM',
            unidade: 'mg',
            dosePorKgMinima: 0.015,
            dosePorKgMaxima: 0.05,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Agitação pediátrica',
            descricaoDose: '0,05–0,1 mg/kg IM',
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
        _textoObs('• Antiemético potente com efeito antipsicótico e sedativo'),
        _textoObs('• Prolonga o intervalo QT – monitorar ECG se dose ≥1mg'),
        _textoObs('• Eficaz em náuseas refratárias e delírios agudos'),
        _textoObs('• Pode causar hipotensão, sedação profunda e distonia'),
        _textoObs('• Contraindicado em pacientes com histórico de QT longo'),
        _textoObs('• Cuidado em pacientes com Parkinson'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Início de ação', '3–10 minutos (IV), 10–30 min (IM)'),
        _linhaInfo('Pico de efeito', '30–60 minutos'),
        _linhaInfo('Duração', '2–4 horas'),
        _linhaInfo('Metabolização', 'Hepática'),
        _linhaInfo('Meia-vida', '2–3 horas'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade ao droperidol'),
        _textoObs('• Síndrome do QT longo'),
        _textoObs('• Arritmias cardíacas'),
        _textoObs('• Doença de Parkinson'),
        _textoObs('• Coma ou depressão do SNC'),
        _textoObs('• Feocromocitoma'),

        // Reações Adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('Comuns (1–10%): Sedação, hipotensão, distonia'),
        _textoObs('Incomuns (0,1–1%): Prolongamento do QT, arritmias'),
        _textoObs('Raras (<0,1%): Síndrome neuroléptica maligna'),

        // Interações
        const SizedBox(height: 16),
        const Text('Interações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Potencializado por outros antipsicóticos'),
        _textoObs('• Potencializado por depressores do SNC'),
        _textoObs('• Potencializado por antiarrítmicos classe IA/III'),
        _textoObs('• Antagonizado por levodopa'),
        _textoObs('• Pode potencializar efeitos hipotensores'),

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