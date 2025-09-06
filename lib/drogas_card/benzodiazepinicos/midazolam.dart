import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoMidazolam {
  static const String nome = 'Midazolam';
  static const String idBulario = 'midazolam';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/midazolam.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário do midazolam: $e');
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
      conteudo: _buildConteudoMidazolam(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoMidazolam(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Versed®, Dormonid®, Midazolam®'),
        _linhaInfo('Classificação', 'Benzodiazepínico de curta duração'),
        _linhaInfo('Mecanismo', 'Agonista do receptor GABA-A'),
        _linhaInfo('Duração', 'Curta (1-2h)'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Ampola 5mg/mL', '1mL = 5mg'),
        _linhaInfo('Ampola 15mg/3mL', '3mL = 15mg'),
        _linhaInfo('Forma', 'Solução injetável'),
        _linhaInfo('Via', 'IV, IM, VO'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Bolus', 'Uso direto IV ou IM'),
        _linhaInfo('Infusão contínua', '50mg/50mL SF = 1mg/mL'),
        _linhaInfo('Concentração', '1mg/mL para bomba'),
        _linhaInfo('Estabilidade', '24h em temperatura ambiente'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        if (isAdulto) ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Sedação consciente',
            descricaoDose: '1–2,5 mg IV lenta, repetir se necessário',
            unidade: 'mg',
            dosePorKgMinima: 0.015,
            dosePorKgMaxima: 0.07,
            doseMaxima: 5,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Indução anestésica',
            descricaoDose: '0,1–0,2 mg/kg IV lenta',
            unidade: 'mg',
            dosePorKgMinima: 0.1,
            dosePorKgMaxima: 0.2,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Infusão contínua em UTI',
            descricaoDose: '0,02–0,1 mg/kg/h IV contínua',
            unidade: 'mg/kg/h',
            dosePorKgMinima: 0.02,
            dosePorKgMaxima: 0.1,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Ansiedade pré-operatória',
            descricaoDose: '0,5–2 mg IV ou IM',
            unidade: 'mg',
            dosePorKgMinima: 0.5,
            dosePorKgMaxima: 2,
            peso: peso,
          ),
        ] else ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Convulsão pediátrica aguda',
            descricaoDose: '0,1–0,2 mg/kg IV ou IM',
            unidade: 'mg',
            dosePorKgMinima: 0.1,
            dosePorKgMaxima: 0.2,
            doseMaxima: 10,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Sedação pediátrica contínua',
            descricaoDose: '0,05–0,2 mg/kg/h IV',
            unidade: 'mg/kg/h',
            dosePorKgMinima: 0.05,
            dosePorKgMaxima: 0.2,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Sedação para procedimentos',
            descricaoDose: '0,05–0,1 mg/kg IV',
            unidade: 'mg',
            dosePorKgMinima: 0.05,
            dosePorKgMaxima: 0.1,
            peso: peso,
          ),
        ],

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Ação rápida e curta, ideal para sedação procedural'),
        _textoObs('• Potente ansiolítico, hipnótico e anticonvulsivante'),
        _textoObs('• Amnésia anterógrada frequente'),
        _textoObs('• Depressão respiratória especialmente com opioides'),
        _textoObs('• Metabolismo hepático extenso'),
        _textoObs('• Reversível com flumazenil'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Início de ação', '1–2 minutos (IV), 5–15 min (IM)'),
        _linhaInfo('Pico de efeito', '3–5 minutos (IV)'),
        _linhaInfo('Duração', '1–2 horas'),
        _linhaInfo('Metabolização', 'Hepática (CYP3A4)'),
        _linhaInfo('Meia-vida', '1,5–3 horas'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade ao midazolam'),
        _textoObs('• Glaucoma de ângulo fechado'),
        _textoObs('• Miastenia gravis'),
        _textoObs('• Apneia do sono grave'),
        _textoObs('• Insuficiência respiratória grave'),

        // Reações Adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('Comuns (1–10%): Sedação, amnésia, depressão respiratória'),
        _textoObs('Incomuns (0,1–1%): Paradoja, hipotensão'),
        _textoObs('Raras (<0,1%): Reações alérgicas graves'),

        // Interações
        const SizedBox(height: 16),
        const Text('Interações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Potencializado por opioides'),
        _textoObs('• Potencializado por álcool'),
        _textoObs('• Potencializado por inibidores CYP3A4'),
        _textoObs('• Antagonizado por flumazenil'),

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