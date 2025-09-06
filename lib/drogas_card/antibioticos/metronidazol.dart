import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoMetronidazol {
  static const String nome = 'Metronidazol';
  static const String idBulario = 'metronidazol';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/metronidazol.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário do metronidazol: $e');
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
      conteudo: _buildConteudoMetronidazol(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoMetronidazol(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Flagyl®, Metronidazol Genérico'),
        _linhaInfo('Classificação', 'Nitroimidazólico'),
        _linhaInfo('Mecanismo', 'Inibe síntese de DNA bacteriano e protozoário'),
        _linhaInfo('Duração', '8–12 horas'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Frasco 500mg/100mL', 'IV'),
        _linhaInfo('Comprimidos', '250mg, 400mg'),
        _linhaInfo('Suspensão oral', '125mg/5mL'),
        _linhaInfo('Forma', 'Solução, comprimido, suspensão'),
        _linhaInfo('Via', 'IV, VO'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Infusão IV', '500mg/100mL em 60 min'),
        _linhaInfo('VO', 'Após refeições'),
        _linhaInfo('Álcool', 'Evitar durante e até 48h após uso'),
        _linhaInfo('Estabilidade', '24h após preparo'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        if (isAdulto) ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Infecções abdominais e ginecológicas',
            descricaoDose: '500mg IV ou VO a cada 8h (7–14 dias)',
            unidade: 'mg',
            dosePorKg: 500 / peso,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Colite por Clostridioides difficile',
            descricaoDose: '500mg VO a cada 8h por 10 dias',
            unidade: 'mg',
            dosePorKg: 500 / peso,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Amebíase, giardíase e tricomoníase',
            descricaoDose: '250–750mg VO 3x/dia por 5–10 dias',
            unidade: 'mg',
            dosePorKgMinima: 250 / peso,
            dosePorKgMaxima: 750 / peso,
            peso: peso,
          ),
        ] else ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Pediatria (≥1 ano)',
            descricaoDose: '20–30 mg/kg/dia divididos em 2–3 doses (máx 2g/dia)',
            unidade: 'mg',
            dosePorKgMinima: 20,
            dosePorKgMaxima: 30,
            doseMaxima: 2000,
            peso: peso,
          ),
        ],

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Ativo contra anaeróbios e protozoários — medicamento essencial da OMS'),
        _textoObs('• Excelente penetração tecidual (incluindo abscessos cerebrais)'),
        _textoObs('• Pode causar gosto metálico, náuseas, tontura e neuropatia periférica'),
        _textoObs('• Contraindicado no primeiro trimestre e na amamentação'),
        _textoObs('• Interage com álcool (efeito dissulfiram) e varfarina'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Início de ação', '1–2 horas'),
        _linhaInfo('Pico de efeito', '1–2 horas'),
        _linhaInfo('Duração', '8–12 horas'),
        _linhaInfo('Metabolização', 'Hepática (60–80%)'),
        _linhaInfo('Meia-vida', '8 horas'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade ao metronidazol ou nitroimidazólicos'),
        _textoObs('• Gravidez (1º trimestre) e amamentação'),
        _textoObs('• Doença hepática grave'),

        // Reações Adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('Comuns (1–10%): Náusea, gosto metálico, dor abdominal'),
        _textoObs('Incomuns (0,1–1%): Neuropatia periférica, convulsões'),
        _textoObs('Raras (<0,1%): Anafilaxia, hepatite, leucopenia'),

        // Interações
        const SizedBox(height: 16),
        const Text('Interações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Potencializa efeito da varfarina'),
        _textoObs('• Efeito dissulfiram com álcool'),
        _textoObs('• Cuidado com uso concomitante de fenitoína e fenobarbital'),

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