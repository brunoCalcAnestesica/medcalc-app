import 'package:flutter/material.dart';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoMetoprolol {
  static const String nome = 'Metoprolol';
  static const String idBulario = 'metoprolol';

  // Não há JSON de bulário, mas manter método para futura inclusão
  static Future<Map<String, dynamic>?> carregarBulario() async {
    return null;
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
      conteudo: _buildCardMetoprolol(context, peso, isAdulto, faixaEtaria),
    );
  }

  static Widget _buildCardMetoprolol(BuildContext context, double peso, bool isAdulto, String faixaEtaria) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const Text('Metoprolol', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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
        _linhaPreparo('Ampola 5mg/5mL (1mg/mL)', 'Metoprolol tartrato IV'),
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('IV lenta (1–2mg/min)', 'Pode diluir em 10–20mL SF 0,9%'),
        _linhaPreparo('Monitorar ECG e PA durante', ''),
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Taquiarritmias supraventriculares',
          descricaoDose: '2,5–5mg IV lenta cada 5min (máx 15mg)',
          unidade: 'mg',
          dosePorKgMinima: 0.05,
          dosePorKgMaxima: 0.1,
          doseMaxima: 15,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Controle PA e FC no IAM',
          descricaoDose: '5mg IV cada 5min (até 3 doses)',
          unidade: 'mg',
          doseMaxima: 15,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Hipertensão perioperatória',
          descricaoDose: '1–5mg IV lenta, repetir conforme resposta',
          unidade: 'mg',
          dosePorKgMinima: 0.02,
          dosePorKgMaxima: 0.08,
          doseMaxima: 5,
          peso: peso,
        ),
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Betabloqueador seletivo β1.'),
        _textoObs('• Cuidado em ICC, BAV e DPOC grave.'),
        _textoObs('• Monitorar ECG, PA e broncoespasmo.'),
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