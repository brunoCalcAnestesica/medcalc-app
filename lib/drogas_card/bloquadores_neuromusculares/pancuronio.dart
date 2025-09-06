import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoPancuronio {
  static const String nome = 'Pancurônio';
  static const String idBulario = 'pancuronio';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/pancuronio.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário do pancurônio: $e');
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
      conteudo: _buildConteudoPancuronio(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoPancuronio(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Pavulon®, Pancurônio®'),
        _linhaInfo('Classificação', 'Bloqueador neuromuscular não-despolarizante'),
        _linhaInfo('Mecanismo', 'Antagonista competitivo da acetilcolina'),
        _linhaInfo('Duração', 'Longa duração (60-90 min)'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Frasco 2mg/mL', '2mL = 4mg'),
        _linhaInfo('Frasco 2mg/mL', '5mL = 10mg'),
        _linhaInfo('Forma', 'Solução injetável'),
        _linhaInfo('Via', 'IV exclusiva'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Bolus', 'IV direta lenta'),
        _linhaInfo('Infusão contínua', '20mg em 100mL SF = 0,2mg/mL'),
        _linhaInfo('Concentração', '0,2mg/mL para bomba'),
        _linhaInfo('Estabilidade', '24h em temperatura ambiente'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        _linhaIndicacaoDoseCalculada(
          titulo: 'Intubação orotraqueal',
          descricaoDose: '0,08–0,12 mg/kg IV lenta',
          unidade: 'mg',
          dosePorKgMinima: 0.08,
          dosePorKgMaxima: 0.12,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Manutenção do bloqueio (infusão)',
          descricaoDose: '1–2 mcg/kg/min IV contínua',
          unidade: 'mcg/kg/min',
          dosePorKgMinima: 1,
          dosePorKgMaxima: 2,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Dose de manutenção (bolus)',
          descricaoDose: '0,02–0,04 mg/kg IV a cada 30–60 min',
          unidade: 'mg',
          dosePorKgMinima: 0.02,
          dosePorKgMaxima: 0.04,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Bloqueio neuromuscular prolongado',
          descricaoDose: '0,1 mg/kg IV inicial + manutenção',
          unidade: 'mg',
          dosePorKg: 0.1,
          peso: peso,
        ),

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Bloqueador neuromuscular não-despolarizante de longa duração'),
        _textoObs('• Efeito vagolítico (taquicardia)'),
        _textoObs('• Acúmulo significativo em insuficiência renal'),
        _textoObs('• Monitorar função renal e hepática'),
        _textoObs('• Reversível com neostigmina + atropina'),
        _textoObs('• Refrigerado (2–8°C)'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Início de ação', '2–3 minutos'),
        _linhaInfo('Pico de efeito', '3–5 minutos'),
        _linhaInfo('Duração', '60–90 minutos'),
        _linhaInfo('Metabolização', '40% hepático, 60% renal'),
        _linhaInfo('Meia-vida', '90–120 minutos'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Insuficiência renal grave'),
        _textoObs('• Insuficiência hepática grave'),
        _textoObs('• Hipertensão arterial grave'),
        _textoObs('• Taquicardia ou arritmias cardíacas'),
        _textoObs('• Alergia ao brometo'),

        // Reações Adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('Comuns (1–10%): Taquicardia, hipertensão arterial'),
        _textoObs('Incomuns (0,1–1%): Arritmias cardíacas, acúmulo renal'),
        _textoObs('Raras (<0,1%): Liberação de histamina, bloqueio residual'),

        // Interações
        const SizedBox(height: 16),
        const Text('Interações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Potencializado por aminoglicosídeos'),
        _textoObs('• Potencializado por anestésicos voláteis'),
        _textoObs('• Antagonizado por anticolinesterásicos'),
        _textoObs('• Cuidado com outros bloqueadores'),

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