import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoDexametasona {
  static const String nome = 'Dexametasona';
  static const String idBulario = 'dexametasona';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/dexametasona.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário da dexametasona: $e');
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
      conteudo: _buildConteudoDexametasona(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoDexametasona(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Decadron®, Dexason®, Maxidex®, Dexametasona®'),
        _linhaInfo('Classificação', 'Glicocorticoide sintético'),
        _linhaInfo('Mecanismo', 'Anti-inflamatório e imunossupressor potente'),
        _linhaInfo('Potência', '25x mais potente que hidrocortisona'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Ampola 4mg/mL', '2mL = 8mg'),
        _linhaInfo('Comprimidos', '0,5mg, 1mg, 4mg'),
        _linhaInfo('Forma', 'Solução injetável e oral'),
        _linhaInfo('Via', 'IV, IM, VO'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Via IV', 'Uso direto ou diluir em SG 5%'),
        _linhaInfo('Via IM', 'Uso direto'),
        _linhaInfo('Via VO', 'Em solução'),
        _linhaInfo('Infusão', 'Lenta se diluído'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        if (isAdulto) ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Crise asmática grave / DPOC',
            descricaoDose: '4–10 mg IV ou IM, dose única ou 1x/dia por 3–5 dias',
            unidade: 'mg',
            doseMaxima: 10,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Edema cerebral',
            descricaoDose: '10 mg IV bolus, seguido de 4 mg IV a cada 6h',
            unidade: 'mg',
            doseMaxima: 10,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Náuseas/vômitos induzidos por quimioterapia',
            descricaoDose: '8–16 mg IV 30 min antes da quimioterapia',
            unidade: 'mg',
            doseMaxima: 16,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Choque anafilático (adjuvante)',
            descricaoDose: '4–8 mg IV, dose única',
            unidade: 'mg',
            doseMaxima: 8,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Doenças autoimunes',
            descricaoDose: '0,5–2 mg VO 1–4x/dia',
            unidade: 'mg',
            doseMaxima: 8,
            peso: peso,
          ),
        ] else ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Laringite viral / estridor infantil',
            descricaoDose: '0,15–0,6 mg/kg IM ou VO, dose única (máx 10mg)',
            unidade: 'mg',
            dosePorKgMinima: 0.15,
            dosePorKgMaxima: 0.6,
            doseMaxima: 10,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Crise asmática ou alérgica pediátrica',
            descricaoDose: '0,15–0,3 mg/kg IM ou IV, 1x/dia por 2–3 dias',
            unidade: 'mg',
            dosePorKgMinima: 0.15,
            dosePorKgMaxima: 0.3,
            doseMaxima: 10,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Bronquiolite grave',
            descricaoDose: '0,15 mg/kg IM ou IV, dose única',
            unidade: 'mg',
            dosePorKg: 0.15,
            peso: peso,
          ),
        ],

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Glicocorticoide de alta potência e longa duração (>36h)'),
        _textoObs('• Excelente penetração no SNC'),
        _textoObs('• Ideal para edema cerebral e crises respiratórias'),
        _textoObs('• Risco de hiperglicemia e imunossupressão em uso prolongado'),
        _textoObs('• Monitorar glicemia em diabéticos'),
        _textoObs('• Efeito mineralocorticoide mínimo'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Início de ação', '1–2 horas'),
        _linhaInfo('Pico de efeito', '4–8 horas'),
        _linhaInfo('Duração', '36–72 horas'),
        _linhaInfo('Metabolização', 'Hepática extensa'),
        _linhaInfo('Eliminação', 'Renal (90%)'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade à dexametasona'),
        _textoObs('• Infecções sistêmicas não controladas'),
        _textoObs('• Tuberculose ativa'),
        _textoObs('• Herpes simples ocular'),

        // Reações Adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('Comuns (1–10%): Hiperglicemia, retenção hídrica, insônia'),
        _textoObs('Incomuns (0,1–1%): Supressão adrenal, osteoporose'),
        _textoObs('Raras (<0,1%): Psicose, catarata, glaucoma'),

        // Interações
        const SizedBox(height: 16),
        const Text('Interações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Potencializa anticoagulantes'),
        _textoObs('• Interfere com antidiabéticos'),
        _textoObs('• Reduz eficácia de vacinas'),
        _textoObs('• Cuidado com AINEs'),

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