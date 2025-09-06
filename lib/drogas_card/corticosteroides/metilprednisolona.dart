import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoMetilprednisolona {
  static const String nome = 'Metilprednisolona';
  static const String idBulario = 'metilprednisolona';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/metilprednisolona.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário da metilprednisolona: $e');
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
      conteudo: _buildConteudoMetilprednisolona(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoMetilprednisolona(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Solu-Medrol®, Metilprednisolona®'),
        _linhaInfo('Classificação', 'Glicocorticoide sintético'),
        _linhaInfo('Mecanismo', 'Anti-inflamatório e imunossupressor potente'),
        _linhaInfo('Potência', '5x mais potente que hidrocortisona'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Frasco-ampola 500mg', 'Pó liofilizado'),
        _linhaInfo('Frasco-ampola 1g', 'Pó liofilizado'),
        _linhaInfo('Forma', 'Pó para reconstituição'),
        _linhaInfo('Via', 'IV exclusiva'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Bolus', 'Diluir com 8–16mL SF 0,9%'),
        _linhaInfo('Infusão', 'Diluir em 100–250mL SG 5% ou SF 0,9%'),
        _linhaInfo('Reconstituição', 'Agitar suavemente até dissolução'),
        _linhaInfo('Estabilidade', '24h em temperatura ambiente'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        if (isAdulto) ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Crise asmática / DPOC',
            descricaoDose: '125–250mg IV em bolus ou 2x/dia por 3–5 dias',
            unidade: 'mg',
            doseMaxima: 250,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Anafilaxia (pós-adrenalina)',
            descricaoDose: '125–250mg IV lenta',
            unidade: 'mg',
            doseMaxima: 250,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Pulsoterapia imunossupressora',
            descricaoDose: '1g/dia IV por 3–5 dias',
            unidade: 'mg',
            doseMaxima: 1000,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Trauma medular agudo (esquema antigo)',
            descricaoDose: '30mg/kg IV bolus, seguido de 5,4mg/kg/h por 23h',
            unidade: 'mg',
            dosePorKg: 30,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Doenças autoimunes graves',
            descricaoDose: '500mg–1g IV por 3–5 dias',
            unidade: 'mg',
            doseMaxima: 1000,
            peso: peso,
          ),
        ] else ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Crise asmática ou alérgica pediátrica',
            descricaoDose: '1–2 mg/kg/dose IV ou IM a cada 12–24h (máx 60mg)',
            unidade: 'mg',
            dosePorKgMinima: 1,
            dosePorKgMaxima: 2,
            doseMaxima: 60,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Laringite grave',
            descricaoDose: '1 mg/kg IV, dose única',
            unidade: 'mg',
            dosePorKg: 1,
            peso: peso,
          ),
        ],

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Corticoide potente, boa penetração no SNC'),
        _textoObs('• Usado em bolus ou infusão'),
        _textoObs('• Pulsoterapia exige monitorização rigorosa'),
        _textoObs('• Desmame gradual em uso prolongado'),
        _textoObs('• Monitorar glicemia e eletrólitos'),
        _textoObs('• Risco de supressão adrenal'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Início de ação', '30–60 minutos'),
        _linhaInfo('Pico de efeito', '2–4 horas'),
        _linhaInfo('Duração', '18–36 horas'),
        _linhaInfo('Metabolização', 'Hepática extensa'),
        _linhaInfo('Eliminação', 'Renal (90%)'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade à metilprednisolona'),
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