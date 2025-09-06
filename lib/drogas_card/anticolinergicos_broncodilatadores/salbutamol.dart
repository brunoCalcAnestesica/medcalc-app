import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoSalbutamol {
  static const String nome = 'Salbutamol';
  static const String idBulario = 'salbutamol';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/salbutamol.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário do salbutamol: $e');
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
      conteudo: _buildConteudoSalbutamol(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoSalbutamol(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Aerolin®, Sabumol®, Salbutamol®'),
        _linhaInfo('Classificação', 'Agonista β2-adrenérgico'),
        _linhaInfo('Mecanismo', 'Broncodilatador seletivo'),
        _linhaInfo('Duração', '4-6 horas'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Solução 5mg/mL', '2,5mg/0,5mL'),
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
        _linhaInfo('Frequência', 'A cada 20 min até resposta, depois 4-6h'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        if (isAdulto) ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Crise asmática / broncoespasmo em DPOC',
            descricaoDose: '2,5–5 mg por nebulização a cada 20 min até resposta; depois a cada 4–6h',
            unidade: 'mg',
            dosePorKgMinima: 2.5 / peso,
            dosePorKgMaxima: 5.0 / peso,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Broncoespasmo agudo',
            descricaoDose: '2,5–5 mg por nebulização a cada 20 min até resposta',
            unidade: 'mg',
            dosePorKgMinima: 2.5 / peso,
            dosePorKgMaxima: 5.0 / peso,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Asma agudizada',
            descricaoDose: '2,5–5 mg por nebulização a cada 20 min até resposta',
            unidade: 'mg',
            dosePorKgMinima: 2.5 / peso,
            dosePorKgMaxima: 5.0 / peso,
            peso: peso,
          ),
        ] else ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Broncoespasmo em crianças (asma / bronquiolite)',
            descricaoDose: '0,15 mg/kg por nebulização (mín 1,25 mg – máx 5 mg)',
            unidade: 'mg',
            dosePorKg: 0.15,
            doseMaxima: 5.0,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Asma pediátrica',
            descricaoDose: '0,15 mg/kg por nebulização (mín 1,25 mg – máx 5 mg)',
            unidade: 'mg',
            dosePorKg: 0.15,
            doseMaxima: 5.0,
            peso: peso,
          ),
        ],

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Agonista β2-adrenérgico seletivo, broncodilatador de ação rápida'),
        _textoObs('• Início em 5 minutos, pico em 30 minutos, duração até 4–6h'),
        _textoObs('• Pode causar taquicardia, tremores, hipocalemia e agitação'),
        _textoObs('• Uso seguro em pediatria e em nebulizações combinadas com ipatropio'),
        _textoObs('• Monitorar FC, SatO₂ e eletrólitos nas crises graves'),
        _textoObs('• Pode causar hiperglicemia em diabéticos'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Início de ação', '5 minutos'),
        _linhaInfo('Pico de efeito', '30 minutos'),
        _linhaInfo('Duração', '4–6 horas'),
        _linhaInfo('Metabolização', 'Hepática'),
        _linhaInfo('Meia-vida', '3–4 horas'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade ao salbutamol'),
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