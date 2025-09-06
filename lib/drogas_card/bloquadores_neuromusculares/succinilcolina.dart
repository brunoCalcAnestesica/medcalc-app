import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoSuccinilcolina {
  static const String nome = 'Succinilcolina';
  static const String idBulario = 'succinilcolina';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/succinilcolina.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário da succinilcolina: $e');
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
      conteudo: _buildConteudoSuccinilcolina(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoSuccinilcolina(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Anectine®, Celoklin®, Succinilcolina®'),
        _linhaInfo('Classificação', 'Bloqueador neuromuscular despolarizante'),
        _linhaInfo('Mecanismo', 'Agonista da acetilcolina (despolarização)'),
        _linhaInfo('Duração', 'Ultracurta (5-10 min)'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Frasco 20mg/mL', '10mL = 200mg'),
        _linhaInfo('Frasco 50mg/mL', '10mL = 500mg'),
        _linhaInfo('Forma', 'Solução injetável'),
        _linhaInfo('Via', 'IV exclusiva'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Administração', 'IV direta lenta (30-60s)'),
        _linhaInfo('Restrição', 'NUNCA usar em infusão contínua'),
        _linhaInfo('Armazenamento', 'Refrigerar entre 2-8°C'),
        _linhaInfo('Estabilidade', '24h após reconstituição'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        _linhaIndicacaoDoseCalculada(
          titulo: 'Intubação de sequência rápida (ISR)',
          descricaoDose: '1–1,5 mg/kg IV bolus',
          unidade: 'mg',
          dosePorKgMinima: 1.0,
          dosePorKgMaxima: 1.5,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Laringoscopia / intubação breve',
          descricaoDose: '0,6–1 mg/kg IV bolus',
          unidade: 'mg',
          dosePorKgMinima: 0.6,
          dosePorKgMaxima: 1.0,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Laringoespasmo refratário',
          descricaoDose: '0,1–0,2 mg/kg IV bolus',
          unidade: 'mg',
          dosePorKgMinima: 0.1,
          dosePorKgMaxima: 0.2,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Eletroconvulsoterapia (ECT)',
          descricaoDose: '0,5–1 mg/kg IV bolus',
          unidade: 'mg',
          dosePorKgMinima: 0.5,
          dosePorKgMaxima: 1.0,
          peso: peso,
        ),

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Despolarizante de ultracurta duração'),
        _textoObs('• Único bloqueador neuromuscular despolarizante'),
        _textoObs('• NÃO usar em infusão contínua (paralisia prolongada)'),
        _textoObs('• Monitorar ECG e temperatura'),
        _textoObs('• Ter dantroleno disponível para hipertermia maligna'),
        _textoObs('• Cuidado com hipercalemia em trauma/queimaduras'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Início de ação', '30–60 segundos'),
        _linhaInfo('Pico de efeito', '1–2 minutos'),
        _linhaInfo('Duração', '5–10 minutos'),
        _linhaInfo('Metabolização', 'Colinesterase plasmática'),
        _linhaInfo('Meia-vida', '2–3 minutos'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Trauma > 48h, queimaduras > 48h'),
        _textoObs('• Paralisias e doenças neuromusculares'),
        _textoObs('• Hipercalemia conhecida'),
        _textoObs('• Histórico de hipertermia maligna'),
        _textoObs('• Glaucoma de ângulo fechado'),
        _textoObs('• Deficiência de colinesterase plasmática'),

        // Reações Adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('Comuns (1–10%): Fasciculações musculares, bradicardia'),
        _textoObs('Incomuns (0,1–1%): Hipercalemia, arritmias'),
        _textoObs('Raras (<0,1%): Hipertermia maligna, paralisia prolongada'),

        // Interações
        const SizedBox(height: 16),
        const Text('Interações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Potencializado por inibidores da colinesterase'),
        _textoObs('• Potencializado por anestésicos voláteis'),
        _textoObs('• Cuidado com outros bloqueadores'),
        _textoObs('• Interação com aminoglicosídeos'),

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