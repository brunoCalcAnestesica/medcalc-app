import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoAdenosina {
  static const String nome = 'Adenosina';
  static const String idBulario = 'adenosina';

  static Future<Map<String, dynamic>> carregarBulario() async {
    final String jsonStr = await rootBundle.loadString('assets/medicamentos/adenosina.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonStr);
    return jsonMap['PT']['bulario'];
  }

  static Widget buildCard(BuildContext context, Set<String> favoritos, void Function(String) onToggleFavorito) {
    final peso = SharedData.peso ?? 70;
    final faixaEtaria = SharedData.faixaEtaria ?? '';
    final isAdulto = faixaEtaria == 'Adulto' || faixaEtaria == 'Idoso';
    final isFavorito = favoritos.contains(nome);

    return buildMedicamentoExpansivel(
      context: context,
      nome: nome,
      idBulario: idBulario,
      isFavorito: isFavorito,
      onToggleFavorito: () => onToggleFavorito(nome),
      conteudo: _buildCardAdenosina(context, peso, isAdulto, faixaEtaria),
    );
  }

  static Widget _buildCardAdenosina(BuildContext context, double peso, bool isAdulto, String faixaEtaria) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const Text('Adenosina', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        if (faixaEtaria.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 8),
            child: Text(
              'Faixa etária: $faixaEtaria',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.indigo),
            ),
          ),
        const Text('Apresentação', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('Ampola 6mg/2mL (3mg/mL)', 'Uso IV – bolus rápido'),
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('Aplicar em veia proximal (antecubital ou central)', ''),
        _linhaPreparo('Seguir imediatamente com flush de 20mL SF 0,9%', ''),
        const SizedBox(height: 16),
        const Text('Indicação Clínica: TSVP', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        if (isAdulto) ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Adenosina – Adulto',
            descricaoDose: '6mg IV bolus rápido.\nSe necessário, repetir 12mg após 1–2 min (máximo 18mg).',
            unidade: 'mg',
            peso: peso,
          ),
        ] else ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Adenosina – Pediátrico',
            descricaoDose: '0,1 mg/kg IV bolus.\nSe falha, repetir 0,2 mg/kg (máximo 12mg).',
            unidade: 'mg',
            dosePorKgMinima: 0.1,
            dosePorKgMaxima: 0.2,
            doseMaxima: 12,
            peso: peso,
          ),
        ],
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Antiarritmico classe V: bloqueia transitoriamente o nó AV.'),
        _textoObs('• Meia-vida plasmática ultracurta (~10 segundos).'),
        _textoObs('• Eficaz na conversão rápida de TSVP em ritmo sinusal.'),
        _textoObs('• Efeitos transitórios: rubor, dispneia, dor torácica, sensação de morte iminente e pausa sinusal.'),
        _textoObs('• ECG contínuo obrigatório durante e após a administração.'),
      ],
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
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(descricaoDose),
          if (dosePorKg != null && unidade != null) Text('Dose: ${(dosePorKg * peso).toStringAsFixed(2)} $unidade'),
          if (dosePorKgMinima != null && dosePorKgMaxima != null && unidade != null)
            Text('Dose: ${(dosePorKgMinima * peso).toStringAsFixed(2)}–${(dosePorKgMaxima * peso).toStringAsFixed(2)} $unidade'),
          if (doseMaxima != null && unidade != null) Text('Dose máxima: $doseMaxima $unidade'),
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