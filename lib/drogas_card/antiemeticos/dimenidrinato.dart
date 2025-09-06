import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoDimenidrinato {
  static const String nome = 'Dimenidrinato';
  static const String idBulario = 'dimenidrinato';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/dimenidrinato.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário do dimenidrinato: $e');
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
      conteudo: _buildConteudoDimenidrinato(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoDimenidrinato(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Dramin®, Dimenidrinato®'),
        _linhaInfo('Classificação', 'Anti-histamínico H1'),
        _linhaInfo('Mecanismo', 'Antagonista H1 + Anticolinérgico'),
        _linhaInfo('Duração', '4-6 horas'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Ampola 50mg/mL', '1mL = 50mg'),
        _linhaInfo('Comprimido 50mg', 'Via oral'),
        _linhaInfo('Forma', 'Solução injetável'),
        _linhaInfo('Via', 'IV, IM, VO'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Bolus', 'Uso direto IV lenta ou IM'),
        _linhaInfo('Infusão', 'Diluir em 20–50mL SF para infusão lenta'),
        _linhaInfo('Velocidade IV', '50mg em 2-3 minutos'),
        _linhaInfo('Estabilidade', '24h após diluição'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        if (isAdulto) ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Náuseas e vômitos',
            descricaoDose: '50–100mg IM ou IV lenta a cada 4–6h',
            unidade: 'mg',
            dosePorKgMinima: 0.5,
            dosePorKgMaxima: 1.5,
            doseMaxima: 100,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Vertigem e labirintite',
            descricaoDose: '50mg IM ou IV a cada 6h',
            unidade: 'mg',
            dosePorKg: 0.7,
            doseMaxima: 50,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Cinetose (enjoo de movimento)',
            descricaoDose: '50mg IM 30min antes da viagem',
            unidade: 'mg',
            dosePorKg: 0.7,
            doseMaxima: 50,
            peso: peso,
          ),
        ] else ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Antiemético pediátrico',
            descricaoDose: '1,25mg/kg/dose a cada 6h (máx 75mg/dia)',
            unidade: 'mg',
            dosePorKgMinima: 1.0,
            dosePorKgMaxima: 1.25,
            doseMaxima: 75,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Vertigem pediátrica',
            descricaoDose: '1mg/kg IM a cada 6h',
            unidade: 'mg',
            dosePorKg: 1.0,
            peso: peso,
          ),
        ],

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Anti-histamínico H1 com ação antiemética e antivertiginosa'),
        _textoObs('• Pode causar sedação intensa e boca seca'),
        _textoObs('• Evitar uso concomitante com outros depressores do SNC'),
        _textoObs('• Ideal para enjoo de movimento, labirintite e cinetose'),
        _textoObs('• Cautela em idosos: risco de delirium e retenção urinária'),
        _textoObs('• Efeito anticolinérgico pode piorar glaucoma'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Início de ação', '15–30 minutos (IM), 5–10 min (IV)'),
        _linhaInfo('Pico de efeito', '1–2 horas'),
        _linhaInfo('Duração', '4–6 horas'),
        _linhaInfo('Metabolização', 'Hepática'),
        _linhaInfo('Meia-vida', '3–6 horas'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade ao dimenidrinato'),
        _textoObs('• Glaucoma de ângulo fechado'),
        _textoObs('• Hiperplasia prostática benigna'),
        _textoObs('• Retenção urinária'),
        _textoObs('• Primeiro trimestre de gestação'),

        // Reações Adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('Comuns (1–10%): Sedação, boca seca, visão turva'),
        _textoObs('Incomuns (0,1–1%): Retenção urinária, taquicardia'),
        _textoObs('Raras (<0,1%): Reações alérgicas graves'),

        // Interações
        const SizedBox(height: 16),
        const Text('Interações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Potencializado por outros depressores do SNC'),
        _textoObs('• Potencializado por álcool'),
        _textoObs('• Potencializado por anticolinérgicos'),
        _textoObs('• Pode mascarar ototoxicidade de aminoglicosídeos'),

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