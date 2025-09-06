import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoBuprenorfina {
  static const String nome = 'Buprenorfina';
  static const String idBulario = 'buprenorfina';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/buprenorfina.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário da buprenorfina: $e');
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
      conteudo: _buildConteudoBuprenorfina(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoBuprenorfina(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Temgesic®, Suboxone®, Buprenex®'),
        _linhaInfo('Classificação', 'Opioide semissintético; agonista parcial μ-opioide'),
        _linhaInfo('Mecanismo', 'Agonista parcial μ-opioide com antagonismo κ-opioide'),
        _linhaInfo('Potência', '25–40x mais potente que a morfina'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Ampolas', '0,3mg/mL (1mL)'),
        _linhaInfo('Comprimidos sublinguais', '0,2mg, 0,4mg, 2mg, 8mg'),
        _linhaInfo('Filmes sublinguais', '2mg/0,5mg, 4mg/1mg, 8mg/2mg (buprenorfina/naloxona)'),
        _linhaInfo('Adesivos transdérmicos', '5mcg/h, 10mcg/h, 20mcg/h'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Via IV', 'Diluir em SF 0,9%; administrar lentamente (2–3min)'),
        _linhaInfo('Via IM', 'Administrar diretamente'),
        _linhaInfo('Via sublingual', 'Manter sob língua até dissolver completamente'),
        _linhaInfo('Cuidado', 'Não triturar ou engolir comprimidos sublinguais'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        _linhaIndicacaoDoseCalculada(
          titulo: 'Dor aguda moderada a intensa (parenteral)',
          descricaoDose: '0,3–0,6mg IV ou IM a cada 6–8h',
          unidade: 'mg',
          dosePorKgMinima: 0.3 / peso,
          dosePorKgMaxima: 0.6 / peso,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Dor crônica (sublingual)',
          descricaoDose: '0,2–0,4mg SL a cada 6–8h',
          unidade: 'mg',
          dosePorKgMinima: 0.2 / peso,
          dosePorKgMaxima: 0.4 / peso,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Tratamento de dependência de opioides',
          descricaoDose: '2–8mg SL/dia (dose única ou dividida)',
          unidade: 'mg',
          dosePorKgMinima: 2.0 / peso,
          dosePorKgMaxima: 8.0 / peso,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Analgesia transdérmica',
          descricaoDose: '5–20mcg/h a cada 7 dias',
          unidade: 'mcg/h',
          dosePorKgMinima: 5.0,
          dosePorKgMaxima: 20.0,
          peso: peso,
        ),

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Agonista parcial μ-opioide com efeito teto para depressão respiratória'),
        _textoObs('• Meia-vida longa (24–48h) — acúmulo possível com uso prolongado'),
        _textoObs('• Difícil antagonização com naloxona devido à alta afinidade pelos receptores'),
        _textoObs('• Efeito teto analgésico — não aumenta efeito com doses maiores'),
        _textoObs('• Útil em tratamento de dependência e dor crônica'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Início de ação', '15–30min (IV/IM), 30–60min (SL), 12–24h (adesivo)'),
        _linhaInfo('Pico de efeito', '1–2h (IV/IM), 2–4h (SL), 48–72h (adesivo)'),
        _linhaInfo('Duração', '6–8h (bolus), 7 dias (adesivo)'),
        _linhaInfo('Metabolização', 'Hepática extensa (CYP3A4)'),
        _linhaInfo('Meia-vida', '24–48h (eliminação terminal)'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade à buprenorfina'),
        _textoObs('• Insuficiência respiratória grave'),
        _textoObs('• Uso concomitante com IMAO'),
        _textoObs('• Paralisia intestinal'),

        // Reações Adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('Comuns (1–10%): Sedação, euforia, náuseas, vômitos, constipação'),
        _textoObs('Incomuns (0,1–1%): Depressão respiratória leve, disforia'),
        _textoObs('Raras (<0,1%): Síndrome serotoninérgica, arritmias'),

        // Interações
        const SizedBox(height: 16),
        const Text('Interações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Potencialização com outros depressores do SNC'),
        _textoObs('• Interação com inibidores CYP3A4'),
        _textoObs('• Difícil antagonização com naloxona'),

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