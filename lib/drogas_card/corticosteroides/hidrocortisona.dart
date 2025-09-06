import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoHidrocortisona {
  static const String nome = 'Hidrocortisona';
  static const String idBulario = 'hidrocortisona';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/hidrocortisona.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário da hidrocortisona: $e');
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
      conteudo: _buildConteudoHidrocortisona(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoHidrocortisona(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Solu-Cortef®, Hidrocortisona®'),
        _linhaInfo('Classificação', 'Glicocorticoide natural'),
        _linhaInfo('Mecanismo', 'Anti-inflamatório e imunossupressor'),
        _linhaInfo('Potência', 'Corticoide de referência (1x)'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Frasco-ampola 100mg', 'Pó liofilizado + diluente 2mL'),
        _linhaInfo('Ampola 50mg/mL', '1mL'),
        _linhaInfo('Forma', 'Pó para reconstituição'),
        _linhaInfo('Via', 'IV exclusiva'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Bolus', 'Reconstituir 100mg em 2–10mL SF 0,9%'),
        _linhaInfo('Infusão', '100mg em 100mL SF 0,9% (1mg/mL)'),
        _linhaInfo('Reconstituição', 'Agitar suavemente até dissolução'),
        _linhaInfo('Estabilidade', '24h em temperatura ambiente'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        _linhaIndicacaoDoseCalculada(
          titulo: 'Insuficiência adrenal aguda / crise suprarrenal',
          descricaoDose: '100mg IV bolus → 200mg/dia (50mg a cada 6h)',
          unidade: 'mg',
          doseMaxima: 200,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Choque séptico (adjuvante)',
          descricaoDose: '200mg/dia contínuos ou 50mg IV a cada 6h',
          unidade: 'mg',
          doseMaxima: 200,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Anafilaxia grave (pós-adrenalina)',
          descricaoDose: '100–200mg IV em bolus único',
          unidade: 'mg',
          doseMaxima: 200,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Crise asmática / DPOC grave',
          descricaoDose: '100–200mg IV única ou dividida em 2x/dia',
          unidade: 'mg',
          doseMaxima: 200,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Choque refratário',
          descricaoDose: '50mg IV a cada 6h por 5 dias',
          unidade: 'mg',
          doseMaxima: 200,
          peso: peso,
        ),

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Glicocorticoide com atividade mineralocorticoide relevante'),
        _textoObs('• Primeira escolha na insuficiência adrenal e choque refratário'),
        _textoObs('• Monitorar glicemia, infecções e retenção hídrica'),
        _textoObs('• Necessário desmame após uso prolongado'),
        _textoObs('• Monitorar eletrólitos (Na+, K+)'),
        _textoObs('• Risco de supressão adrenal em uso prolongado'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Início de ação', '30–60 minutos'),
        _linhaInfo('Pico de efeito', '2–4 horas'),
        _linhaInfo('Duração', '8–12 horas'),
        _linhaInfo('Metabolização', 'Hepática extensa'),
        _linhaInfo('Eliminação', 'Renal (90%)'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade à hidrocortisona'),
        _textoObs('• Infecções sistêmicas não controladas'),
        _textoObs('• Tuberculose ativa'),
        _textoObs('• Herpes simples ocular'),

        // Reações Adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('Comuns (1–10%): Hiperglicemia, retenção hídrica, hipocalemia'),
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