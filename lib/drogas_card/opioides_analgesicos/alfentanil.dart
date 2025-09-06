import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoAlfentanil {
  static const String nome = 'Alfentanil';
  static const String idBulario = 'alfentanil';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/alfentanil.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário do alfentanil: $e');
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
      conteudo: _buildConteudoAlfentanil(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoAlfentanil(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Rapifen®, Alfenta®, Alfentanil®'),
        _linhaInfo('Classificação', 'Opioide sintético; analgésico narcótico ultrarrápido'),
        _linhaInfo('Mecanismo', 'Agonista μ-opioide puro'),
        _linhaInfo('Potência', '1/4 da potência do fentanil'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Ampolas', '0,5mg/mL (2mL, 10mL)'),
        _linhaInfo('Concentração', '500mcg/mL'),
        _linhaInfo('Estabilidade', '24h após diluição em SF 0,9%'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Via IV', 'Bolus lento ou infusão contínua'),
        _linhaInfo('Diluição', '5mg em 50mL SF = 0,1mg/mL (100mcg/mL)'),
        _linhaInfo('Administração', 'Bolus: 1–2min; Infusão: titulável'),
        _linhaInfo('Cuidado', 'Evitar bolus rápido — risco de rigidez torácica'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        _linhaIndicacaoDoseCalculada(
          titulo: 'Indução e intubação',
          descricaoDose: '10–50 mcg/kg IV lento',
          unidade: 'mcg',
          dosePorKgMinima: 10.0,
          dosePorKgMaxima: 50.0,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Manutenção anestésica (procedimentos curtos)',
          descricaoDose: '0,5–1 mcg/kg/min IV contínua',
          unidade: 'mcg/kg/min',
          dosePorKgMinima: 0.5,
          dosePorKgMaxima: 1.0,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Sedação em procedimentos',
          descricaoDose: '0,25–0,5 mcg/kg/min IV contínua',
          unidade: 'mcg/kg/min',
          dosePorKgMinima: 0.25,
          dosePorKgMaxima: 0.5,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Analgesia intraoperatória (bolus)',
          descricaoDose: '5–15 mcg/kg IV a cada 5–10 min',
          unidade: 'mcg',
          dosePorKgMinima: 5.0,
          dosePorKgMaxima: 15.0,
          peso: peso,
        ),

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Opioide μ-agonista com início ultrarrápido (30–60 segundos)'),
        _textoObs('• Duração muito curta (5–10 min) — ideal para procedimentos curtos'),
        _textoObs('• Excelente para intubação de sequência rápida'),
        _textoObs('• Alto risco de rigidez torácica e depressão respiratória'),
        _textoObs('• Monitorização contínua obrigatória (FR, SpO₂, sedação)'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Início de ação', '30–60 segundos (IV)'),
        _linhaInfo('Pico de efeito', '1–2 minutos (IV)'),
        _linhaInfo('Duração', '5–10 minutos (bolus)'),
        _linhaInfo('Metabolização', 'Hepática extensa (CYP3A4)'),
        _linhaInfo('Meia-vida', '1,5–2 horas (eliminação terminal)'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade ao alfentanil'),
        _textoObs('• Insuficiência respiratória grave'),
        _textoObs('• Uso concomitante com IMAO'),
        _textoObs('• Paralisia intestinal'),

        // Reações Adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('Comuns (1–10%): Sedação, euforia, náuseas, vômitos, constipação'),
        _textoObs('Incomuns (0,1–1%): Rigidez torácica, depressão respiratória, bradicardia'),
        _textoObs('Raras (<0,1%): Arritmias, síndrome serotoninérgica'),

        // Interações
        const SizedBox(height: 16),
        const Text('Interações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Potencialização com outros depressores do SNC'),
        _textoObs('• Interação com inibidores CYP3A4'),
        _textoObs('• Risco de rigidez torácica com benzodiazepínicos'),

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