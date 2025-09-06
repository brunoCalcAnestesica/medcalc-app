import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoAzulMetileno {
  static const String nome = 'Azul de Metileno';
  static const String idBulario = 'azul_metileno';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/azul_metileno.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário do azul de metileno: $e');
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
      conteudo: _buildConteudoAzulMetileno(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoAzulMetileno(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        
        // Informações Gerais
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Classificação', 'Corante tiazínico; antídoto para metaemoglobinemia'),
        _linhaInfo('Mecanismo de Ação', 'Agente oxidante-reduzível; reduz metaemoglobina à hemoglobina funcional'),
        _linhaInfo('Meia-vida', '5-6 horas'),
        _linhaInfo('Pico de ação', '30-60 minutos após IV'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaApresentacao('Ampola 10mL', '10mg/mL', 'Solução injetável 1%'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('Diluir 1–2mg/kg em 50–100mL SF 0,9%', 'Infusão IV lenta em 5–10 minutos'),
        _linhaPreparo('Proteger da luz', 'Usar imediatamente após preparo'),

        // Indicações Clínicas com Cálculo de Dose
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Metaemoglobinemia',
          descricaoDose: '1–2 mg/kg IV lento',
          unidade: 'mg',
          dosePorKgMinima: 1.0,
          dosePorKgMaxima: 2.0,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Intoxicação por cianeto',
          descricaoDose: '1,5–2 mg/kg IV lento',
          unidade: 'mg',
          dosePorKgMinima: 1.5,
          dosePorKgMaxima: 2.0,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Vasoplegia pós-CEC',
          descricaoDose: '1,5 mg/kg IV lento',
          unidade: 'mg',
          dosePorKg: 1.5,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Corante vital (cirurgia)',
          descricaoDose: '1–2 mg/kg IV',
          unidade: 'mg',
          dosePorKgMinima: 1.0,
          dosePorKgMaxima: 2.0,
          peso: peso,
        ),

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Antídoto específico para metaemoglobinemia e intoxicação por cianeto'),
        _textoObs('• Pode causar coloração azulada da pele e urina (normal)'),
        _textoObs('• Contraindicado em pacientes com deficiência de G6PD'),
        _textoObs('• Monitorar saturação de oxigênio e sinais vitais'),
        _textoObs('• Pode ser necessário repetir a dose em casos graves'),
        _textoObs('• Dose máxima total: 7 mg/kg por episódio'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Absorção', 'Rápida após administração IV'),
        _linhaInfo('Distribuição', 'Ampla distribuição tecidual, incluindo cérebro'),
        _linhaInfo('Metabolismo', 'Hepático, reduzido a leucoazul de metileno'),
        _linhaInfo('Excreção', 'Renal (80%) e biliar (20%)'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade ao azul de metileno'),
        _textoObs('• Deficiência de G6PD (risco de hemólise)'),
        _textoObs('• Insuficiência renal grave (sem diálise)'),

        // Reações Adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Comuns: urina azul-esverdeada, náusea, cefaleia'),
        _textoObs('• Incomuns: metaemoglobinemia paradoxal, hipotensão, taquicardia'),
        _textoObs('• Raras: anafilaxia, hemólise, arritmias, convulsões'),

        // Interações
        const SizedBox(height: 16),
        const Text('Interações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Pode interferir com oximetria de pulso (falsamente baixa)'),
        _textoObs('• Cautela com agentes oxidantes'),
        _textoObs('• Pode reduzir eficácia de agentes redutores'),

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

  static Widget _linhaApresentacao(String apresentacao, String concentracao, String observacao) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(child: Text(apresentacao)),
          const SizedBox(width: 8),
          Text(concentracao, style: const TextStyle(fontWeight: FontWeight.w500)),
          if (observacao.isNotEmpty) ...[
            const SizedBox(width: 8),
            Flexible(child: Text(observacao, style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 12))),
          ]
        ],
      ),
    );
  }

  static Widget _linhaPreparo(String texto, String obs) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
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
    String? unidade,
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
          if (dosePorKg != null && unidade != null) 
            Text('Dose: ${(dosePorKg * peso).toStringAsFixed(2)} $unidade', 
                 style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.blue)),
          if (dosePorKgMinima != null && dosePorKgMaxima != null && unidade != null)
            Text('Dose: ${(dosePorKgMinima * peso).toStringAsFixed(2)}–${(dosePorKgMaxima * peso).toStringAsFixed(2)} $unidade', 
                 style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.blue)),
          if (doseMaxima != null && unidade != null) 
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