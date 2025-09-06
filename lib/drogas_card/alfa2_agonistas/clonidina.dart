import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoClonidina {
  static const String nome = 'Clonidina';
  static const String idBulario = 'clonidina';

  static Future<Map<String, dynamic>> carregarBulario() async {
    final String jsonStr = await rootBundle.loadString('assets/medicamentos/clonidina.json');
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
      conteudo: _buildCardClonidina(context, peso, isAdulto, faixaEtaria),
    );
  }

  static Widget _buildCardClonidina(BuildContext context, double peso, bool isAdulto, String faixaEtaria) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const Text('Clonidina', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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
        _linhaPreparo('Ampola 150mcg/mL (1mL)', 'Diluição recomendada antes do uso'),
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('150mcg em 15mL SF 0,9%', '10 mcg/mL'),
        _linhaPreparo('150mcg em 50mL SF 0,9%', '3 mcg/mL (infusão pediátrica)'),
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        if (isAdulto) ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Hipertensão arterial grave',
            descricaoDose: '50–150 mcg VO ou 1–2 mcg/kg IV lento',
            unidade: 'mcg',
            dosePorKgMinima: 1,
            dosePorKgMaxima: 2,
            doseMaxima: 150,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Sedação leve em UTI',
            descricaoDose: '0,2–1 mcg/kg/h IV contínua',
            peso: peso,
          ),
        ] else ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Sedação pediátrica (off-label)',
            descricaoDose: '0,25–1 mcg/kg/h IV contínua',
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Controle da pressão arterial em TCE',
            descricaoDose: '0,5–1 mcg/kg IV lento ou infusão',
            unidade: 'mcg',
            dosePorKgMinima: 0.5,
            dosePorKgMaxima: 1,
            peso: peso,
          ),
        ],
        const SizedBox(height: 16),
        const Text('Cálculo da Infusão', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        ConversaoInfusaoSlider(
          peso: peso,
          opcoesConcentracoes: {
            '150mcg/15mL (10 mcg/mL)': 10,
            '150mcg/50mL (3 mcg/mL)': 3,
          },
          unidade: 'mcg/kg/h',
          doseMin: 0.2,
          doseMax: 1.0,
        ),
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Agonista seletivo de receptores alfa-2 adrenérgicos com efeito hipotensor e sedativo.'),
        _textoObs('• Efeito semelhante à dexmedetomidina, porém com menor custo.'),
        _textoObs('• Pode causar bradicardia e hipotensão.'),
        _textoObs('• Útil como coadjuvante na anestesia e em síndromes de abstinência.'),
        _textoObs('• Evitar suspensão abrupta após uso prolongado → risco de efeito rebote.'),
      ],
    );
  }

  static Widget _linhaPreparo(String texto, String marca) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black87),
                children: [
                  TextSpan(text: texto),
                  if (marca.isNotEmpty) ...[
                    const TextSpan(text: ' | ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: marca, style: const TextStyle(fontStyle: FontStyle.italic)),
                  ],
                ],
              ),
            ),
          ),
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
    double? doseCalculada;
    String? textoDose;

    if (dosePorKg != null) {
      doseCalculada = dosePorKg * peso;
      textoDose = '${doseCalculada.toStringAsFixed(1)} $unidade';
    } else if (dosePorKgMinima != null && dosePorKgMaxima != null) {
      double doseMin = dosePorKgMinima * peso;
      double doseMax = dosePorKgMaxima * peso;
      if (doseMaxima != null) {
        doseMax = doseMax > doseMaxima ? doseMaxima : doseMax;
      }
      textoDose = '${doseMin.toStringAsFixed(1)}–${doseMax.toStringAsFixed(1)} $unidade';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            descricaoDose,
            style: const TextStyle(fontSize: 13),
          ),
          if (textoDose != null) ...[
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Text(
                'Dose calculada: $textoDose',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade700,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  static Widget _textoObs(String texto) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(texto)),
        ],
      ),
    );
  }
} 