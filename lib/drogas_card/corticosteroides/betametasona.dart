import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoBetametasona {
  static const String nome = 'Betametasona';
  static const String idBulario = 'betametasona';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/betametasona.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário da betametasona: $e');
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
      conteudo: _buildConteudoBetametasona(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoBetametasona(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Celestone®, Diprospan®, Betametasona®'),
        _linhaInfo('Classificação', 'Glicocorticoide sintético'),
        _linhaInfo('Mecanismo', 'Anti-inflamatório e imunossupressor potente'),
        _linhaInfo('Potência', '25x mais potente que hidrocortisona'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Ampola 6mg/2mL', '3mg/mL'),
        _linhaInfo('Comprimidos', '0,5mg, 1mg'),
        _linhaInfo('Forma', 'Solução injetável e oral'),
        _linhaInfo('Via', 'IM, IV, VO'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Via IM', 'Uso direto'),
        _linhaInfo('Via IV', 'Infusão lenta'),
        _linhaInfo('Via VO', 'Uso direto'),
        _linhaInfo('Obstetrícia', '12mg IM a cada 24h por 2 dias'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        if (isAdulto) ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Reações inflamatórias e alérgicas agudas',
            descricaoDose: '4–8 mg IM ou IV, 1x/dia por 2–5 dias',
            unidade: 'mg',
            doseMaxima: 8,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Doenças autoimunes ou dermatológicas',
            descricaoDose: '0,05–0,1 mg/kg/dia IM ou VO (máx 8mg/dia)',
            unidade: 'mg',
            dosePorKgMinima: 0.05,
            dosePorKgMaxima: 0.1,
            doseMaxima: 8,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Maduração pulmonar fetal (obstetrícia)',
            descricaoDose: '12mg IM a cada 24h por 2 doses (total 24mg)',
            unidade: 'mg',
            doseMaxima: 24,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Choque anafilático (adjuvante)',
            descricaoDose: '4–8 mg IM ou IV, dose única',
            unidade: 'mg',
            doseMaxima: 8,
            peso: peso,
          ),
        ] else ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Laringite / estridor infantil',
            descricaoDose: '0,1–0,2 mg/kg IM ou VO, dose única (máx 6mg)',
            unidade: 'mg',
            dosePorKgMinima: 0.1,
            dosePorKgMaxima: 0.2,
            doseMaxima: 6,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Bronquiolite grave',
            descricaoDose: '0,1 mg/kg IM ou IV, dose única',
            unidade: 'mg',
            dosePorKg: 0.1,
            peso: peso,
          ),
        ],

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Glicocorticoide potente, meia-vida longa (~36–54h)'),
        _textoObs('• Potente anti-inflamatório e imunossupressor'),
        _textoObs('• Efeito mineralocorticoide mínimo'),
        _textoObs('• Cautela em diabetes e infecções'),
        _textoObs('• Monitorar glicemia em diabéticos'),
        _textoObs('• Risco de supressão adrenal em uso prolongado'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Início de ação', '1–2 horas'),
        _linhaInfo('Pico de efeito', '4–8 horas'),
        _linhaInfo('Duração', '36–54 horas'),
        _linhaInfo('Metabolização', 'Hepática extensa'),
        _linhaInfo('Eliminação', 'Renal (90%)'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade à betametasona'),
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