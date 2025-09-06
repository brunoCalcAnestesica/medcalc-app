import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoBumetanida {
  static const String nome = 'Bumetanida';
  static const String idBulario = 'bumetadina';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/bumetadina.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário da bumetanida: $e');
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
      conteudo: _buildConteudoBumetanida(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoBumetanida(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Burinax®, Bumex®, Bumetanida®'),
        _linhaInfo('Classificação', 'Diurético de alça'),
        _linhaInfo('Mecanismo', 'Inibição da reabsorção de Na⁺/K⁺/Cl⁻ no ramo ascendente'),
        _linhaInfo('Potência', '40x mais potente que furosemida'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Ampola 1mg/4mL', '0,25mg/mL'),
        _linhaInfo('Comprimidos', '0,5mg, 1mg, 2mg'),
        _linhaInfo('Concentração', '0,25mg/mL (ampola)'),
        _linhaInfo('Forma', 'Solução aquosa incolor'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Via IV', 'Lenta ou IM direta'),
        _linhaInfo('Diluição', '10–20mL SF 0,9% se necessário'),
        _linhaInfo('Via oral', 'Uso direto'),
        _linhaInfo('Biodisponibilidade', '~90% (alta)'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        if (isAdulto) ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'ICC / Edema / IRC',
            descricaoDose: '0,5–10 mg/dia divididos',
            unidade: 'mg',
            dosePorKgMinima: 0.5 / peso,
            dosePorKgMaxima: 10 / peso,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Resistência à furosemida',
            descricaoDose: '1–2 mg IV/VO a cada 12h',
            unidade: 'mg',
            doseMaxima: 2,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Hipertensão arterial',
            descricaoDose: '0,5–2 mg/dia VO',
            unidade: 'mg',
            dosePorKgMinima: 0.5 / peso,
            dosePorKgMaxima: 2 / peso,
            peso: peso,
          ),
        ] else ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Pediatria (off-label)',
            descricaoDose: '0,005–0,1 mg/kg/dose IV/VO cada 6–12h (máx 1mg)',
            unidade: 'mg',
            dosePorKgMinima: 0.005,
            dosePorKgMaxima: 0.1,
            doseMaxima: 1,
            peso: peso,
          ),
        ],

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• 40x mais potente que furosemida'),
        _textoObs('• Alta biodisponibilidade VO (~90%)'),
        _textoObs('• Útil em resistência à furosemida'),
        _textoObs('• Monitorar eletrólitos e função renal'),
        _textoObs('• Menor ototoxicidade que furosemida'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Início de ação', '2–5 minutos (IV), 30–60 minutos (VO)'),
        _linhaInfo('Pico de efeito', '15–30 minutos (IV), 1–2 horas (VO)'),
        _linhaInfo('Duração', '2–4 horas'),
        _linhaInfo('Metabolização', 'Hepática extensa'),
        _linhaInfo('Eliminação', 'Renal (80%) e hepática (20%)'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade à bumetanida'),
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
