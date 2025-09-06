import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoBupivacaina {
  static const String nome = 'Bupivacaína';
  static const String idBulario = 'bupivacaina_infiltracao';

  static Future<Map<String, dynamic>> carregarBulario() async {
    final String jsonStr = await rootBundle.loadString('assets/medicamentos/bupivacaina_infiltracao.json');
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
      conteudo: _buildCardBupivacaina(context, peso, isAdulto, faixaEtaria),
    );
  }

  static Widget _buildCardBupivacaina(BuildContext context, double peso, bool isAdulto, String faixaEtaria) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const Text('Bupivacaína', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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
        _linhaPreparo('Ampolas 0,25%, 0,5% e 0,75%', 'Neocaína®, Bupivacaína Cristália®'),
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('Pronta para uso ou diluída em SF 0,9%', ''),
        _linhaPreparo('Volume e concentração dependem da técnica', ''),
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Peridural (cirurgia, obstetrícia)',
          descricaoDose: '1,5–2,5 mg/kg (máx 175mg/dose ou 400mg/24h)',
          unidade: 'mg',
          dosePorKgMinima: 1.5,
          dosePorKgMaxima: 2.5,
          doseMaxima: 400,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Raquianestesia',
          descricaoDose: '7,5–15mg (hiperbárica 0,5%)',
          unidade: 'mg',
          dosePorKgMinima: 7.5 / peso,
          dosePorKgMaxima: 15 / peso,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Bloqueio periférico (plexo, fascial)',
          descricaoDose: '1–2 mg/kg (máx 175mg)',
          unidade: 'mg',
          dosePorKgMinima: 1,
          dosePorKgMaxima: 2,
          doseMaxima: 175,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Infiltração cirúrgica (cateter)',
          descricaoDose: '0,25%–0,5%, infusão 5–8mL/h',
          unidade: 'mg/h',
          dosePorKg: 12.5 / peso,
          doseMaxima: 40,
          peso: peso,
        ),
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Anestésico potente e longa duração (~4–8h).'),
        _textoObs('• Alta lipossolubilidade → risco maior de toxicidade cardiovascular.'),
        _textoObs('• Não exceder 3mg/kg por dia, cautela em gestantes.'),
        _textoObs('• Vasoconstritor: contraindicado em áreas terminais.'),
        _textoObs('• Intoxicação: tratar com emulsão lipídica intravenosa (Intralipid®).'),
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