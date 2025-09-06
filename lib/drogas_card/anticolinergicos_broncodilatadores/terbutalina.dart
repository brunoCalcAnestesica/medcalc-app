import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoTerbutalina {
  static const String nome = 'Terbutalina';
  static const String idBulario = 'terbutalina';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/terbutalina.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário da terbutalina: $e');
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
      conteudo: _buildConteudoTerbutalina(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoTerbutalina(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Bricanyl®, Terbutalina®'),
        _linhaInfo('Classificação', 'Agonista β2-adrenérgico'),
        _linhaInfo('Mecanismo', 'Broncodilatador e relaxante uterino'),
        _linhaInfo('Duração', '4-6 horas'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Ampola 1mg/mL', '1mL = 1mg'),
        _linhaInfo('Forma', 'Solução injetável'),
        _linhaInfo('Via', 'SC, IM'),
        _linhaInfo('Aerossol', '250mcg/dose'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('SC', 'Uso direto ou diluído em 1-2mL SF'),
        _linhaInfo('IM', 'Uso direto'),
        _linhaInfo('Repetição', 'A cada 15-20 min até 3x'),
        _linhaInfo('Estabilidade', '24h após diluição'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        if (isAdulto) ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Crise asmática grave / broncoespasmo',
            descricaoDose: '0,25 mg SC a cada 20 min até 3 doses',
            unidade: 'mg',
            dosePorKg: 0.25 / peso,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Tocolítico (off-label obstetrícia)',
            descricaoDose: '250 mcg SC a cada 4–6h para inibir contrações uterinas',
            unidade: 'mcg',
            doseMaxima: 250,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Broncoespasmo agudo',
            descricaoDose: '0,25 mg SC a cada 20 min até 3 doses',
            unidade: 'mg',
            dosePorKg: 0.25 / peso,
            peso: peso,
          ),
        ] else ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Crise asmática pediátrica grave',
            descricaoDose: '0,005–0,01 mg/kg SC a cada 20–30 min',
            unidade: 'mg',
            dosePorKgMinima: 0.005,
            dosePorKgMaxima: 0.01,
            doseMaxima: 0.3,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Broncoespasmo pediátrico',
            descricaoDose: '0,005–0,01 mg/kg SC a cada 20–30 min',
            unidade: 'mg',
            dosePorKgMinima: 0.005,
            dosePorKgMaxima: 0.01,
            doseMaxima: 0.3,
            peso: peso,
          ),
        ],

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Agonista β2 potente com ação broncodilatadora e relaxante uterina'),
        _textoObs('• Via subcutânea ideal em crises graves quando nebulização não é possível'),
        _textoObs('• Pode causar taquicardia, agitação, tremores e hipocalemia'),
        _textoObs('• Uso obstétrico é off-label, com monitoramento fetal rigoroso'),
        _textoObs('• Contraindicado em cardiopatas, hipertensos e hipertireoidismo não controlado'),
        _textoObs('• Monitorar glicemia em diabéticos'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Início de ação', '5–15 minutos (SC)'),
        _linhaInfo('Pico de efeito', '30–60 minutos'),
        _linhaInfo('Duração', '4–6 horas'),
        _linhaInfo('Metabolização', 'Hepática'),
        _linhaInfo('Meia-vida', '3–4 horas'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade à terbutalina'),
        _textoObs('• Cardiomiopatia hipertrófica'),
        _textoObs('• Arritmias cardíacas graves'),
        _textoObs('• Hipertireoidismo não controlado'),
        _textoObs('• Diabetes mellitus descompensado'),

        // Reações Adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('Comuns (1–10%): Taquicardia, tremores, agitação'),
        _textoObs('Incomuns (0,1–1%): Hipocalemia, hiperglicemia'),
        _textoObs('Raras (<0,1%): Arritmias cardíacas, reações alérgicas'),

        // Interações
        const SizedBox(height: 16),
        const Text('Interações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Potencializado por outros β2-agonistas'),
        _textoObs('• Antagonizado por β-bloqueadores'),
        _textoObs('• Pode potencializar efeitos de corticosteroides'),
        _textoObs('• Diuréticos podem aumentar risco de hipocalemia'),

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