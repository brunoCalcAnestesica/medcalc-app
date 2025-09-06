import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoCetamina {
  static const String nome = 'Cetamina';
  static const String idBulario = 'cetamina';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/cetamina.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário da cetamina: $e');
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
      conteudo: _buildConteudoCetamina(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoCetamina(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Ketalar®, Cetamina®, Ketamine®'),
        _linhaInfo('Classificação', 'Anestésico dissociativo'),
        _linhaInfo('Mecanismo', 'Antagonista não competitivo do receptor NMDA'),
        _linhaInfo('Potência', 'Anestésico dissociativo de referência'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Ampolas', '500mg/10mL (50mg/mL)'),
        _linhaInfo('Concentração', '50mg/mL'),
        _linhaInfo('Forma', 'Solução aquosa incolor'),
        _linhaInfo('Estabilidade', '24h após diluição'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Diluição', '500mg em 100mL SG 5% = 5mg/mL'),
        _linhaInfo('Bolus', 'Pode ser usada sem diluir para bolus IM/IV'),
        _linhaInfo('Via IV', 'Infusão lenta (1–2min)'),
        _linhaInfo('Via IM', 'Administração direta'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        if (isAdulto) ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Indução anestésica IV',
            descricaoDose: '1–2 mg/kg IV lenta',
            unidade: 'mg',
            dosePorKgMinima: 1.0,
            dosePorKgMaxima: 2.0,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Sedação subanestésica (analgesia)',
            descricaoDose: '0,25–0,5 mg/kg em bolus ou infusão',
            unidade: 'mg',
            dosePorKgMinima: 0.25,
            dosePorKgMaxima: 0.5,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Broncoespasmo refratário / asma grave',
            descricaoDose: '0,5–1 mg/kg IV + 0,15–0,5 mg/kg/h',
            unidade: 'mg',
            dosePorKgMinima: 0.5,
            dosePorKgMaxima: 1.0,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Infusão contínua (sedação)',
            descricaoDose: '0,15–0,5 mg/kg/h IV',
            unidade: 'mg/kg/h',
            dosePorKgMinima: 0.15,
            dosePorKgMaxima: 0.5,
            peso: peso,
          ),
        ] else ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Indução anestésica pediátrica',
            descricaoDose: '1–2 mg/kg IV ou 4–10 mg/kg IM',
            unidade: 'mg',
            dosePorKgMinima: 1.0,
            dosePorKgMaxima: 2.0,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Sedação / analgesia pediátrica',
            descricaoDose: '0,25–1 mg/kg em bolus',
            unidade: 'mg',
            dosePorKgMinima: 0.25,
            dosePorKgMaxima: 1.0,
            peso: peso,
          ),
        ],

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Anestésico dissociativo com ação em receptores NMDA'),
        _textoObs('• Preserva drive respiratório e reflexos das vias aéreas'),
        _textoObs('• Efeitos psicodislépticos comuns — associar benzodiazepínico'),
        _textoObs('• Útil em pacientes com broncoespasmo ou instabilidade hemodinâmica'),
        _textoObs('• Pode causar aumento da pressão intracraniana'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Início de ação', '30–60 segundos (IV), 3–5 minutos (IM)'),
        _linhaInfo('Pico de efeito', '1–2 minutos (IV), 10–15 minutos (IM)'),
        _linhaInfo('Duração', '10–20 minutos (bolus IV), 20–30 minutos (IM)'),
        _linhaInfo('Metabolização', 'Hepática extensa (CYP3A4)'),
        _linhaInfo('Meia-vida', '2–3 horas (eliminação terminal)'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade à cetamina'),
        _textoObs('• Hipertensão intracraniana não controlada'),
        _textoObs('• Psicose ativa'),
        _textoObs('• Glaucoma de ângulo fechado'),

        // Reações Adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('Comuns (1–10%): Alucinações, agitação, náuseas, vômitos'),
        _textoObs('Incomuns (0,1–1%): Bradicardia, arritmias, laringoespasmo'),
        _textoObs('Raras (<0,1%): Reações alérgicas, aumento da PIC'),

        // Interações
        const SizedBox(height: 16),
        const Text('Interações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Potencialização com outros depressores do SNC'),
        _textoObs('• Interação com benzodiazepínicos (reduz efeitos psicodislépticos)'),
        _textoObs('• Potencialização com barbitúricos'),

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