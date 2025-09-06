import 'package:flutter/material.dart';
import '../drogas.dart';

Widget buildCardDextrocetamina(BuildContext context, double peso, bool isAdulto) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 16),
      const Text('Apresentação', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),
      _linhaPreparo('Ampola 25mg/mL (Ketanest S®)', ''),

      const SizedBox(height: 16),
      const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),
      _linhaPreparo('Diluir em SF 0,9% ou SG 5%', 'Ex: 100mg em 100mL (1mg/mL)'),
      _linhaPreparo('Utilizar bomba de infusão para infusões contínuas', ''),

      const SizedBox(height: 16),
      const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),

      if (isAdulto) ...[
        _linhaIndicacaoDoseCalculada(
          titulo: 'Indução anestésica (IV)',
          descricaoDose: '0,5–1 mg/kg IV lenta',
          unidade: 'mg',
          dosePorKgMinima: 0.5,
          dosePorKgMaxima: 1.0,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Analgesia subanestésica em UTI',
          descricaoDose: '0,05–0,5 mg/kg/h IV contínua',
          peso: peso,
        ),
      ] else ...[
        _linhaIndicacaoDoseCalculada(
          titulo: 'Indução anestésica pediátrica',
          descricaoDose: '1–1,5 mg/kg IV',
          unidade: 'mg',
          dosePorKgMinima: 1.0,
          dosePorKgMaxima: 1.5,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Sedação subanestésica',
          descricaoDose: '0,1–0,5 mg/kg/h IV contínua',
          peso: peso,
        ),
      ],

      const SizedBox(height: 16),
      const Text('Cálculo da Infusão', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),
      ConversaoInfusaoSlider(
        peso: peso,
        opcoesConcentracoes: {
          '100mg/100mL (1mg/mL)': 1000,
          '200mg/100mL (2mg/mL)': 2000,
        },
        unidade: 'mg/kg/h',
        doseMin: 0.05,
        doseMax: 0.5,
      ),

      const SizedBox(height: 16),
      const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),
      _textoObs('• Enantiômero S(+) da cetamina: maior potência anestésica e menos efeitos psicodislépticos.'),
      _textoObs('• Promove analgesia, anestesia e sedação dose-dependentes.'),
      _textoObs('• Preserva reflexos de vias aéreas e drive respiratório.'),
      _textoObs('• Pode causar hipertensão e taquicardia, especialmente em bolus.'),
      _textoObs('• Usar com cautela em pacientes com hipertensão intracraniana.'),
    ],
  );
}

Widget _linhaPreparo(String texto, String obs) {
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

Widget _linhaIndicacaoDoseCalculada({
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

Widget _textoObs(String texto) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 2),
    child: Text(texto, style: const TextStyle(fontSize: 13, color: Colors.black87)),
  );
} 