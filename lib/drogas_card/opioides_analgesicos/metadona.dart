import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoMetadona {
  static const String nome = 'Metadona';
  static const String idBulario = 'metadona';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/metadona.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário da metadona: $e');
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
      conteudo: _buildConteudoMetadona(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoMetadona(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Metadon®, Dolophine®, Methadone®'),
        _linhaInfo('Classificação', 'Opioide sintético; analgésico narcótico'),
        _linhaInfo('Mecanismo', 'Agonista μ-opioide com antagonismo NMDA'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Comprimidos', '5mg, 10mg, 40mg'),
        _linhaInfo('Ampolas', '10mg/mL'),
        _linhaInfo('Solução oral', '1mg/mL, 2mg/mL'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Via oral', 'Uso direto'),
        _linhaInfo('Via IV', 'Diluir em SF 0,9%; administrar lentamente (1mg/min)'),
        _linhaInfo('Ajuste de dose', 'Extremo cuidado — risco de acúmulo'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        _linhaIndicacaoDoseCalculada(
          titulo: 'Dor crônica intensa / refratária',
          descricaoDose: '2,5–10mg VO ou IV a cada 6–8h',
          unidade: 'mg',
          dosePorKgMinima: 2.5 / peso,
          dosePorKgMaxima: 10.0 / peso,
          doseMaxima: 80,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Substituição em dependência de opioides',
          descricaoDose: '20–30mg VO inicial, ajuste gradual até 60–120mg/dia',
          unidade: 'mg',
          dosePorKg: 20,
          doseMaxima: 120,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Síndrome de abstinência em UTI / cuidados paliativos',
          descricaoDose: '2,5–5mg VO ou SC a cada 12h, ajuste lento',
          unidade: 'mg',
          dosePorKgMinima: 2.5 / peso,
          dosePorKgMaxima: 5.0 / peso,
          peso: peso,
        ),

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Agonista μ-opioide com meia-vida longa (15–60h)'),
        _textoObs('• Atua também como inibidor da recaptação de serotonina e noradrenalina'),
        _textoObs('• Alto risco de acúmulo e toxicidade — ajustes extremamente cautelosos'),
        _textoObs('• Risco de prolongamento de QT e arritmias — ECG recomendado'),
        _textoObs('• Conversão de outros opioides deve ser feita por especialistas'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Início de ação', '30–60min (VO), 10–20min (IM/IV)'),
        _linhaInfo('Pico de efeito', '2–4h (VO), 1–2h (IM/IV)'),
        _linhaInfo('Duração', '6–8h (analgesia), 24–36h (supressão abstinência)'),
        _linhaInfo('Metabolização', 'Hepática extensa (CYP3A4, CYP2B6)'),
        _linhaInfo('Meia-vida', '15–60h (variável)'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade à metadona'),
        _textoObs('• Uso concomitante com IMAO'),
        _textoObs('• Insuficiência respiratória grave'),
        _textoObs('• Paralisia intestinal'),

        // Reações Adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('Comuns (1–10%): Sedação, euforia, náuseas, vômitos, constipação'),
        _textoObs('Incomuns (0,1–1%): Depressão respiratória, prolongamento QTc'),
        _textoObs('Raras (<0,1%): Síndrome serotoninérgica, arritmias cardíacas'),

        // Interações
        const SizedBox(height: 16),
        const Text('Interações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Potencialização com outros depressores do SNC'),
        _textoObs('• Interação com inibidores CYP3A4'),
        _textoObs('• Risco de prolongamento QTc com outros medicamentos'),

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