import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoRemimazolam {
  static const String nome = 'Remimazolam';
  static const String idBulario = 'remimazolam';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/remimazolam.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário do remimazolam: $e');
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
      conteudo: _buildConteudoRemimazolam(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoRemimazolam(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Byfavo®, Remimazolam®'),
        _linhaInfo('Classificação', 'Benzodiazepínico de ação ultra-curta'),
        _linhaInfo('Mecanismo', 'Agonista seletivo GABA-A (pró-fármaco)'),
        _linhaInfo('Duração', 'Ultra-curta (0,5-1,5h)'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Ampola 20mg/2mL', '10mg/mL'),
        _linhaInfo('Ampola 30mg/3mL', '10mg/mL'),
        _linhaInfo('Forma', 'Pó liofilizado para reconstituição'),
        _linhaInfo('Via', 'IV'),
        _linhaInfo('Concentração', '10mg/mL após reconstituição'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Reconstituição', 'Diluir em 2-3mL SF ou SG 5%'),
        _linhaInfo('Bolus', 'Uso direto IV'),
        _linhaInfo('Infusão contínua', '1-12mg/h IV'),
        _linhaInfo('Estabilidade', '4h após reconstituição'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        if (isAdulto) ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Sedação para procedimentos',
            descricaoDose: '0,1–0,2 mg/kg IV lenta',
            unidade: 'mg',
            dosePorKgMinima: 0.1,
            dosePorKgMaxima: 0.2,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Indução anestésica',
            descricaoDose: '0,2–0,3 mg/kg IV lenta',
            unidade: 'mg',
            dosePorKgMinima: 0.2,
            dosePorKgMaxima: 0.3,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Infusão contínua',
            descricaoDose: '1–12 mg/h IV contínua',
            unidade: 'mg/h',
            dosePorKgMinima: 0.014,
            dosePorKgMaxima: 0.17,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Sedação em UTI',
            descricaoDose: '0,1–0,2 mg/kg IV, seguido de 1–6 mg/h',
            unidade: 'mg',
            dosePorKgMinima: 0.1,
            dosePorKgMaxima: 0.2,
            peso: peso,
          ),
        ] else ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Sedação pediátrica',
            descricaoDose: '0,1–0,2 mg/kg IV lenta',
            unidade: 'mg',
            dosePorKgMinima: 0.1,
            dosePorKgMaxima: 0.2,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Infusão pediátrica',
            descricaoDose: '0,5–6 mg/h IV contínua',
            unidade: 'mg/h',
            dosePorKgMinima: 0.007,
            dosePorKgMaxima: 0.086,
            peso: peso,
          ),
        ],

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Benzodiazepínico de ação ultra-curta'),
        _textoObs('• Pró-fármaco metabolizado por esterase plasmática'),
        _textoObs('• Recuperação previsível independente da duração'),
        _textoObs('• Não se acumula no organismo'),
        _textoObs('• Ideal para procedimentos de curta duração'),
        _textoObs('• Antagonizável com flumazenil'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Início de ação', '1–2 minutos'),
        _linhaInfo('Pico de efeito', '2–3 minutos'),
        _linhaInfo('Duração', '0,5–1,5 horas'),
        _linhaInfo('Metabolização', 'Esterase plasmática (CNS7054)'),
        _linhaInfo('Meia-vida', '0,5–1,5 horas'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade ao remimazolam'),
        _textoObs('• Miastenia gravis não controlada'),
        _textoObs('• Insuficiência respiratória severa'),
        _textoObs('• Apneia do sono não tratada'),
        _textoObs('• Glaucoma de ângulo fechado'),

        // Reações Adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('Comuns (1–10%): Sedação, depressão respiratória, hipotensão'),
        _textoObs('Incomuns (0,1–1%): Reações paradoxais, bradicardia'),
        _textoObs('Raras (<0,1%): Reações alérgicas graves'),

        // Interações
        const SizedBox(height: 16),
        const Text('Interações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Potencializado por opioides'),
        _textoObs('• Potencializado por álcool'),
        _textoObs('• Antagonizado por flumazenil'),
        _textoObs('• Interações mínimas (metabolismo independente de CYP)'),

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