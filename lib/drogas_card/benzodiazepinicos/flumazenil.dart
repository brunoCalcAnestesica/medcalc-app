import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoFlumazenil {
  static const String nome = 'Flumazenil';
  static const String idBulario = 'flumazenil';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/flumazenil.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário do flumazenil: $e');
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
      conteudo: _buildConteudoFlumazenil(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoFlumazenil(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Lanexat®, Anexate®, Flumazenil®'),
        _linhaInfo('Classificação', 'Antagonista benzodiazepínico'),
        _linhaInfo('Mecanismo', 'Antagonista competitivo GABA-A'),
        _linhaInfo('Duração', 'Curta (1-2h)'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Ampola 0,1mg/mL', '5mL = 0,5mg'),
        _linhaInfo('Forma', 'Solução injetável'),
        _linhaInfo('Via', 'IV'),
        _linhaInfo('Concentração', '0,1mg/mL'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Bolus', '0,2mg IV a cada 60s até resposta'),
        _linhaInfo('Infusão contínua', '0,1–0,4mg/h diluído em SF'),
        _linhaInfo('Diluição', '0,5mg/100mL SF = 0,005mg/mL'),
        _linhaInfo('Dose máxima', '1mg total'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        if (isAdulto) ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Reversão de sedação',
            descricaoDose: '0,2mg IV a cada 60s até resposta',
            unidade: 'mg',
            dosePorKgMinima: 0.002,
            dosePorKgMaxima: 0.01,
            doseMaxima: 1.0,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Manutenção pós-reversão',
            descricaoDose: '0,1–0,4mg/h IV contínua',
            unidade: 'mg/h',
            dosePorKgMinima: 0.001,
            dosePorKgMaxima: 0.006,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Overdose benzodiazepínico',
            descricaoDose: '0,2mg IV a cada 60s (máx 3mg)',
            unidade: 'mg',
            dosePorKgMinima: 0.002,
            dosePorKgMaxima: 0.01,
            doseMaxima: 3.0,
            peso: peso,
          ),
        ] else ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Reversão pediátrica',
            descricaoDose: '0,01mg/kg IV lenta (máx 0,2mg)',
            unidade: 'mg',
            dosePorKgMinima: 0.005,
            dosePorKgMaxima: 0.01,
            doseMaxima: 0.2,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Manutenção pediátrica',
            descricaoDose: '0,005–0,01mg/kg/h IV',
            unidade: 'mg/kg/h',
            dosePorKgMinima: 0.005,
            dosePorKgMaxima: 0.01,
            peso: peso,
          ),
        ],

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Antagonista competitivo dos benzodiazepínicos'),
        _textoObs('• Meia-vida curta (~1h): risco de ressedação'),
        _textoObs('• Cuidado em epilepsia tratada com BZD'),
        _textoObs('• Risco de convulsões em overdose mista'),
        _textoObs('• Monitorização por 2h após reversão'),
        _textoObs('• Não reverte depressão respiratória isolada'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Início de ação', '1–2 minutos'),
        _linhaInfo('Pico de efeito', '6–10 minutos'),
        _linhaInfo('Duração', '1–2 horas'),
        _linhaInfo('Metabolização', 'Hepática'),
        _linhaInfo('Meia-vida', '0,7–1,3 horas'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade ao flumazenil'),
        _textoObs('• Epilepsia controlada com benzodiazepínicos'),
        _textoObs('• Overdose mista com convulsivantes'),
        _textoObs('• Trauma craniano com risco de convulsões'),
        _textoObs('• Dependência de benzodiazepínicos'),

        // Reações Adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('Comuns (1–10%): Náusea, vômito, ansiedade'),
        _textoObs('Incomuns (0,1–1%): Convulsões, arritmias'),
        _textoObs('Raras (<0,1%): Reações alérgicas graves'),

        // Interações
        const SizedBox(height: 16),
        const Text('Interações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Antagoniza todos os benzodiazepínicos'),
        _textoObs('• Não reverte outros sedativos'),
        _textoObs('• Pode precipitar síndrome de abstinência'),
        _textoObs('• Interfere com monitorização BIS'),

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
            Text('Dose: ${(dosePorKg * peso).toStringAsFixed(2)} $unidade', 
                 style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.blue)),
          if (dosePorKgMinima != null && dosePorKgMaxima != null)
            Text('Dose: ${(dosePorKgMinima * peso).toStringAsFixed(2)}–${(dosePorKgMaxima * peso).toStringAsFixed(2)} $unidade', 
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