import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoFurosemida {
  static const String nome = 'Furosemida';
  static const String idBulario = 'furosemida';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/furosemida.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário da furosemida: $e');
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
      conteudo: _buildConteudoFurosemida(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoFurosemida(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Lasix®, Furosemida®, Furosemide®'),
        _linhaInfo('Classificação', 'Diurético de alça'),
        _linhaInfo('Mecanismo', 'Inibição da reabsorção de Na⁺/K⁺/Cl⁻ no ramo ascendente'),
        _linhaInfo('Potência', 'Diurético de alça de referência'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Ampola 20mg/2mL', '10mg/mL'),
        _linhaInfo('Comprimidos', '20mg, 40mg, 80mg'),
        _linhaInfo('Concentração', '10mg/mL (ampola)'),
        _linhaInfo('Forma', 'Solução aquosa incolor'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Via IV', 'Direto, IM ou infusão'),
        _linhaInfo('Diluição', '1mg/mL para infusão contínua'),
        _linhaInfo('Via oral', 'Uso direto'),
        _linhaInfo('Estabilidade', '24h após diluição'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        if (isAdulto) ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Edema agudo / ICC',
            descricaoDose: '20–80 mg IV (máx 200mg/dose)',
            unidade: 'mg',
            dosePorKgMinima: 20 / peso,
            dosePorKgMaxima: 80 / peso,
            doseMaxima: 200,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'IRC / Síndrome nefrótica',
            descricaoDose: '40–120 mg/dia',
            unidade: 'mg',
            dosePorKgMinima: 40 / peso,
            dosePorKgMaxima: 120 / peso,
            doseMaxima: 160,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Infusão contínua',
            descricaoDose: '0,1–0,4 mg/kg/h',
            unidade: 'mg/kg/h',
            dosePorKgMinima: 0.1,
            dosePorKgMaxima: 0.4,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Hipertensão arterial',
            descricaoDose: '20–80 mg/dia VO',
            unidade: 'mg',
            dosePorKgMinima: 20 / peso,
            dosePorKgMaxima: 80 / peso,
            peso: peso,
          ),
        ] else ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Edema pediátrico',
            descricaoDose: '0,5–2 mg/kg/dose IV/VO cada 12–24h',
            unidade: 'mg',
            dosePorKgMinima: 0.5,
            dosePorKgMaxima: 2.0,
            doseMaxima: 40,
            peso: peso,
          ),
        ],

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Diurético de alça de rápida ação'),
        _textoObs('• Pode exigir altas doses na IRC'),
        _textoObs('• Monitorar eletrólitos, volemia e função renal'),
        _textoObs('• Risco de ototoxicidade em altas doses'),
        _textoObs('• Efeito máximo em 1–2h (IV)'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Início de ação', '5–10 minutos (IV), 30–60 minutos (VO)'),
        _linhaInfo('Pico de efeito', '30–60 minutos (IV), 1–2 horas (VO)'),
        _linhaInfo('Duração', '2–4 horas'),
        _linhaInfo('Metabolização', 'Hepática (50%)'),
        _linhaInfo('Eliminação', 'Renal (50%) e hepática (50%)'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade à furosemida'),
        _textoObs('• Anúria'),
        _textoObs('• Hipovolemia grave'),
        _textoObs('• Alcalose metabólica'),

        // Reações Adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('Comuns (1–10%): Hipocalemia, hiponatremia, hipovolemia'),
        _textoObs('Incomuns (0,1–1%): Ototoxicidade, hiperuricemia'),
        _textoObs('Raras (<0,1%): Pancreatite, discrasias sanguíneas'),

        // Interações
        const SizedBox(height: 16),
        const Text('Interações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Potencializa digitálicos'),
        _textoObs('• Interfere com lítio'),
        _textoObs('• Potencializa outros diuréticos'),

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
