import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoFenoterol {
  static const String nome = 'Fenoterol';
  static const String idBulario = 'fenoterol';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/fenoterol.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário do fenoterol: $e');
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
      conteudo: _buildConteudoFenoterol(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoFenoterol(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Berotec®, Fenoterol®'),
        _linhaInfo('Classificação', 'Agonista β2-adrenérgico'),
        _linhaInfo('Mecanismo', 'Broncodilatador seletivo'),
        _linhaInfo('Duração', '4-6 horas'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Solução 0,5mg/mL', '10 gotas = 0,25mg'),
        _linhaInfo('Forma', 'Solução inalatória'),
        _linhaInfo('Via', 'Nebulização'),
        _linhaInfo('Aerossol', '100mcg/dose'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Diluição', '3-4mL SF 0,9%'),
        _linhaInfo('Nebulização', '5-10 minutos'),
        _linhaInfo('Associação', 'Pode ser usado com ipatropio'),
        _linhaInfo('Frequência', 'A cada 6-8 horas'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        if (isAdulto) ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Crise asmática / broncoespasmo em DPOC',
            descricaoDose: '0,25–0,5 mg (10–20 gotas) por nebulização a cada 6–8h',
            unidade: 'mg',
            dosePorKgMinima: 0.25 / peso,
            dosePorKgMaxima: 0.5 / peso,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Broncoespasmo agudo',
            descricaoDose: '0,25–0,5 mg (10–20 gotas) por nebulização a cada 6–8h',
            unidade: 'mg',
            dosePorKgMinima: 0.25 / peso,
            dosePorKgMaxima: 0.5 / peso,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Asma agudizada',
            descricaoDose: '0,25–0,5 mg (10–20 gotas) por nebulização a cada 6–8h',
            unidade: 'mg',
            dosePorKgMinima: 0.25 / peso,
            dosePorKgMaxima: 0.5 / peso,
            peso: peso,
          ),
        ] else ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Broncoespasmo em crianças',
            descricaoDose: '0,05–0,1 mg (2–4 gotas) por nebulização a cada 6h',
            unidade: 'mg',
            dosePorKgMinima: 0.05 / peso,
            dosePorKgMaxima: 0.1 / peso,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Asma pediátrica',
            descricaoDose: '0,05–0,1 mg (2–4 gotas) por nebulização a cada 6h',
            unidade: 'mg',
            dosePorKgMinima: 0.05 / peso,
            dosePorKgMaxima: 0.1 / peso,
            peso: peso,
          ),
        ],

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Agonista β2-adrenérgico → broncodilatação rápida e eficaz'),
        _textoObs('• Início em 5–10 min, duração até 4–6h'),
        _textoObs('• Efeitos adversos: tremor, taquicardia e hipocalemia'),
        _textoObs('• Frequentemente associado a ipatropio'),
        _textoObs('• Monitorar FC e resposta clínica, especialmente em crianças e cardiopatas'),
        _textoObs('• Pode causar hiperglicemia em diabéticos'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Início de ação', '5–10 minutos'),
        _linhaInfo('Pico de efeito', '15–30 minutos'),
        _linhaInfo('Duração', '4–6 horas'),
        _linhaInfo('Metabolização', 'Hepática'),
        _linhaInfo('Meia-vida', '2–3 horas'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade ao fenoterol'),
        _textoObs('• Cardiomiopatia hipertrófica'),
        _textoObs('• Arritmias cardíacas graves'),
        _textoObs('• Hipertireoidismo não controlado'),
        _textoObs('• Diabetes mellitus descompensado'),

        // Reações Adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('Comuns (1–10%): Tremores, taquicardia, agitação'),
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