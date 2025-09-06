import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoFentanil {
  static const String nome = 'Fentanil';
  static const String idBulario = 'fentanil';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/fentanil.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário do fentanil: $e');
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
      conteudo: _buildConteudoFentanil(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoFentanil(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Fentanil Cristália®, Dimorfent®, Sublimaze®'),
        _linhaInfo('Classificação', 'Opioide sintético; analgésico narcótico potente'),
        _linhaInfo('Mecanismo', 'Agonista μ-opioide puro'),
        _linhaInfo('Potência', '50–100x mais potente que a morfina'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Ampolas', '50mcg/mL (2mL, 5mL, 10mL)'),
        _linhaInfo('Adesivos', '12,5mcg/h, 25mcg/h, 50mcg/h, 75mcg/h, 100mcg/h'),
        _linhaInfo('Comprimidos', '100mcg, 200mcg, 400mcg (sublingual)'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Via IV', 'Diluir em SF 0,9%; administrar lentamente (1–2min)'),
        _linhaInfo('Infusão contínua', '500mcg/50mL = 10mcg/mL ou 250mcg/50mL = 5mcg/mL'),
        _linhaInfo('Cuidado', 'Evitar bolus rápido — risco de rigidez torácica'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        _linhaIndicacaoDoseCalculada(
          titulo: 'Indução anestésica (pré-intubação)',
          descricaoDose: '1–5 mcg/kg IV lenta',
          unidade: 'mcg',
          dosePorKgMinima: 1.0,
          dosePorKgMaxima: 5.0,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Manutenção anestésica (infusão)',
          descricaoDose: '1–3 mcg/kg/h IV',
          unidade: 'mcg/kg/h',
          dosePorKgMinima: 1.0,
          dosePorKgMaxima: 3.0,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Sedação em UTI',
          descricaoDose: '0,5–2 mcg/kg/h IV contínua',
          unidade: 'mcg/kg/h',
          dosePorKgMinima: 0.5,
          dosePorKgMaxima: 2.0,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Analgesia intraoperatória (bolus)',
          descricaoDose: '25–100 mcg IV a cada 30–60 min',
          unidade: 'mcg',
          dosePorKgMinima: 25.0 / peso,
          dosePorKgMaxima: 100.0 / peso,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Analgesia pós-operatória',
          descricaoDose: '0,5–1,5 mcg/kg IV a cada 1–2h',
          unidade: 'mcg',
          dosePorKgMinima: 0.5,
          dosePorKgMaxima: 1.5,
          peso: peso,
        ),

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Opioide μ-agonista puro com potência 50–100x maior que a morfina'),
        _textoObs('• Início de ação rápido (2–5min), duração intermediária (30–60min)'),
        _textoObs('• Alto risco de rigidez torácica e depressão respiratória'),
        _textoObs('• Lipossolúvel — acúmulo em tecido adiposo'),
        _textoObs('• Monitorização contínua obrigatória (FR, SpO₂, sedação)'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Início de ação', '2–5min (IV), 15–30min (transdérmico)'),
        _linhaInfo('Pico de efeito', '5–15min (IV), 12–24h (transdérmico)'),
        _linhaInfo('Duração', '30–60min (bolus IV), 72h (adesivo)'),
        _linhaInfo('Metabolização', 'Hepática extensa (CYP3A4)'),
        _linhaInfo('Meia-vida', '3–7h (eliminação terminal)'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade ao fentanil'),
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