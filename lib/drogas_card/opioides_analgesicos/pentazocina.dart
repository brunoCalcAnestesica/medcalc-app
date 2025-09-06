import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoPentazocina {
  static const String nome = 'Pentazocina';
  static const String idBulario = 'pentazocina';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/pentazocina.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário da pentazocina: $e');
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
      conteudo: _buildConteudoPentazocina(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoPentazocina(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Fortral®, Talwin®'),
        _linhaInfo('Classificação', 'Agonista-antagonista opioide'),
        _linhaInfo('Mecanismo', 'Agonista κ-opioide e antagonista μ-opioide'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('Ampola 30mg/mL (1mL)', 'Fortral®, Talwin®'),
        _linhaPreparo('Comprimidos 50mg e 100mg', 'Via oral'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('IV lenta', 'Diluir 30mg em 10-20mL SF 0,9%'),
        _linhaPreparo('IM/SC', 'Administrar puro'),
        _linhaPreparo('Via oral', 'Comprimidos inteiros, com ou sem alimentos'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        _linhaIndicacaoDoseCalculada(
          titulo: 'Dor aguda moderada a intensa',
          descricaoDose: '30–60mg IV ou IM a cada 3–4h',
          unidade: 'mg',
          dosePorKgMinima: 30 / peso,
          dosePorKgMaxima: 60 / peso,
          doseMaxima: 360,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Dor pós-operatória',
          descricaoDose: '30mg IV ou IM a cada 3–4h conforme necessidade',
          unidade: 'mg',
          dosePorKgMinima: 30 / peso,
          dosePorKgMaxima: 30 / peso,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Via oral',
          descricaoDose: '50–100mg a cada 3–4h (máx 600mg/dia)',
          unidade: 'mg',
          dosePorKgMinima: 50 / peso,
          dosePorKgMaxima: 100 / peso,
          doseMaxima: 600,
          peso: peso,
        ),

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Efeito teto para depressão respiratória (menor risco que opioides μ-puros).'),
        _textoObs('• Alternativa à morfina em pacientes com risco de apneia.'),
        _textoObs('• Pode causar sedação, náuseas, sudorese e disforia.'),
        _textoObs('• Evitar uso concomitante com opioides μ-puros (antagonismo).'),
        _textoObs('• Menor potencial de abuso e dependência.'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Início de ação: 15–30 min (VO/IM/SC), 2–3 min (IV).'),
        _textoObs('• Duração: 3–4 horas.'),
        _textoObs('• Meia-vida: 2–4 horas.'),
        _textoObs('• Metabolização hepática (CYP450).'),
        _textoObs('• Excreção renal como metabólitos.'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade à pentazocina.'),
        _textoObs('• Insuficiência coronariana grave.'),
        _textoObs('• Uso concomitante com opioides agonistas plenos.'),
        _textoObs('• Hipertensão descompensada.'),
        _textoObs('• Histórico de psicose ou esquizofrenia.'),

        // Reações Adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Muito comuns: náusea, tontura, sonolência, efeitos psicomiméticos.'),
        _textoObs('• Comuns: vômitos, constipação, taquicardia, sudorese, elevação da PA.'),
        _textoObs('• Incomuns: reações alérgicas, rash, tremores, insônia.'),
        _textoObs('• Raras: depressão respiratória (IV rápida), crise hipertensiva.'),

        // Interações
        const SizedBox(height: 16),
        const Text('Interações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Potencialização com álcool, benzodiazepínicos e depressores do SNC.'),
        _textoObs('• Redução de efeito de agonistas μ (morfina, oxicodona).'),
        _textoObs('• Uso com inibidores da MAO: risco de hipertensão.'),
        _textoObs('• Evitar uso com clonidina (antagonismo analgésico).'),

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

  static Widget _linhaPreparo(String texto, String obs) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text(texto)),
          if (obs.isNotEmpty) ...[
            const SizedBox(width: 8),
            Flexible(child: Text(obs, style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 12))),
          ]
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
            Text('Dose máxima: $doseMaxima $unidade/dia', 
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