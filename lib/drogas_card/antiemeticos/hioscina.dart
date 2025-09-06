import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoHioscina {
  static const String nome = 'Hioscina';
  static const String idBulario = 'hioscina';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/hioscina.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário do hioscina: $e');
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
      conteudo: _buildConteudoHioscina(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoHioscina(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Buscopan®, Hioscina®'),
        _linhaInfo('Classificação', 'Antimuscarínico'),
        _linhaInfo('Mecanismo', 'Antagonista competitivo muscarínico'),
        _linhaInfo('Duração', '4-6 horas'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Ampola 20mg/mL', 'Escopolamina butilbrometo'),
        _linhaInfo('Ampola 0,4mg/mL', 'Escopolamina base'),
        _linhaInfo('Forma', 'Solução injetável'),
        _linhaInfo('Via', 'IV, IM, SC'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Bolus', 'Uso direto IV, IM ou SC'),
        _linhaInfo('Infusão', 'Diluir em SF para infusão lenta'),
        _linhaInfo('Velocidade IV', '20mg em 2-3 minutos'),
        _linhaInfo('Estabilidade', '24h após diluição'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        if (isAdulto) ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Espasmos gastrintestinais',
            descricaoDose: '20mg IV, IM ou SC a cada 6–8h',
            unidade: 'mg',
            doseMaxima: 20,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Espasmos biliares',
            descricaoDose: '20mg IV lenta a cada 6h',
            unidade: 'mg',
            doseMaxima: 20,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Espasmos urinários',
            descricaoDose: '20mg IM a cada 8h',
            unidade: 'mg',
            doseMaxima: 20,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Pré-medicação antissecretora',
            descricaoDose: '0,2–0,4 mg IV lenta (escopolamina base)',
            unidade: 'mg',
            dosePorKgMinima: 0.003,
            dosePorKgMaxima: 0.006,
            peso: peso,
          ),
        ] else ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Espasmos abdominais pediátricos',
            descricaoDose: '0,3 mg/kg/dia divididos em 3 doses',
            unidade: 'mg',
            dosePorKgMinima: 0.1,
            dosePorKgMaxima: 0.3,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Dose única pediátrica',
            descricaoDose: '0,1 mg/kg IM ou SC',
            unidade: 'mg',
            dosePorKg: 0.1,
            peso: peso,
          ),
        ],

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Antimuscarínico com ação antiespasmódica e antissecretora'),
        _textoObs('• Pode causar sonolência, boca seca e visão turva'),
        _textoObs('• Cuidado em idosos: risco de delirium e retenção urinária'),
        _textoObs('• Útil como adjuvante em náuseas refratárias'),
        _textoObs('• Doses elevadas podem causar efeitos centrais'),
        _textoObs('• Contraindicado em glaucoma de ângulo fechado'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Início de ação', '5–15 minutos (IV), 15–30 min (IM)'),
        _linhaInfo('Pico de efeito', '30–60 minutos'),
        _linhaInfo('Duração', '4–6 horas'),
        _linhaInfo('Metabolização', 'Hepática'),
        _linhaInfo('Meia-vida', '2–4 horas'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade ao hioscina'),
        _textoObs('• Glaucoma de ângulo fechado'),
        _textoObs('• Hiperplasia prostática benigna'),
        _textoObs('• Retenção urinária'),
        _textoObs('• Miastenia gravis'),
        _textoObs('• Megacólon tóxico'),

        // Reações Adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('Comuns (1–10%): Boca seca, visão turva, sonolência'),
        _textoObs('Incomuns (0,1–1%): Retenção urinária, taquicardia'),
        _textoObs('Raras (<0,1%): Delirium, alucinações, reações alérgicas'),

        // Interações
        const SizedBox(height: 16),
        const Text('Interações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Potencializado por outros anticolinérgicos'),
        _textoObs('• Potencializado por antidepressivos tricíclicos'),
        _textoObs('• Antagonizado por anticolinesterásicos'),
        _textoObs('• Pode reduzir absorção de outros fármacos'),

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