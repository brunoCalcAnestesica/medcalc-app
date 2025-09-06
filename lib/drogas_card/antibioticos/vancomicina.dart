import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoVancomicina {
  static const String nome = 'Vancomicina';
  static const String idBulario = 'vancomicina';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/vancomicina.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário da vancomicina: $e');
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
      conteudo: _buildConteudoVancomicina(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoVancomicina(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Vancomicina Genérico, Vancocin®'),
        _linhaInfo('Classificação', 'Glicopeptídeo'),
        _linhaInfo('Mecanismo', 'Inibe síntese da parede celular bacteriana'),
        _linhaInfo('Duração', '8–12 horas'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Frasco 500mg', 'Liofilizado'),
        _linhaInfo('Frasco 1g', 'Liofilizado'),
        _linhaInfo('Forma', 'Pó liofilizado'),
        _linhaInfo('Via', 'IV, VO'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Diluição', '1g em 20mL água estéril'),
        _linhaInfo('Infusão', '250mL SF ou SG 5% em ≥60 min'),
        _linhaInfo('Cuidado', 'Evitar infusão rápida (síndrome do pescoço vermelho)'),
        _linhaInfo('Estabilidade', '24h após preparo'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        if (isAdulto) ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Infecções graves por Gram-positivos',
            descricaoDose: '15–20mg/kg IV a cada 8–12h (ajustar por função renal e nível sérico)',
            unidade: 'mg',
            dosePorKgMinima: 15,
            dosePorKgMaxima: 20,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Colite pseudomembranosa (VO)',
            descricaoDose: '125–250mg VO 4x/dia por 10–14 dias',
            unidade: 'mg',
            dosePorKg: 125,
            doseMaxima: 250,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Profilaxia neurocirúrgica (off-label)',
            descricaoDose: '1g IV 60 min antes da incisão cirúrgica',
            unidade: 'mg',
            dosePorKg: 1000 / peso,
            peso: peso,
          ),
        ] else ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Pediatria (infecções graves)',
            descricaoDose: '10–15mg/kg IV a cada 6–12h (ajustar por função renal)',
            unidade: 'mg',
            dosePorKgMinima: 10,
            dosePorKgMaxima: 15,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Colite pseudomembranosa pediátrica',
            descricaoDose: '10mg/kg VO 4x/dia (máx 125mg/dose)',
            unidade: 'mg',
            dosePorKg: 10,
            doseMaxima: 125,
            peso: peso,
          ),
        ],

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Atividade contra Gram-positivos, incluindo MRSA e enterococos'),
        _textoObs('• Monitorar níveis séricos (alvo: 15–20 mcg/mL)'),
        _textoObs('• Ajustar dose pela função renal'),
        _textoObs('• Infundir lentamente (≥60 minutos) para evitar reação de liberação de histamina'),
        _textoObs('• Uso VO restrito a infecções intestinais — não tem absorção sistêmica'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Início de ação', 'Imediato'),
        _linhaInfo('Pico de efeito', '1–2 horas'),
        _linhaInfo('Duração', '8–12 horas'),
        _linhaInfo('Metabolização', 'Renal (90%)'),
        _linhaInfo('Meia-vida', '4–6 horas'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade à vancomicina ou glicopeptídeos'),
        _textoObs('• Uso cauteloso em insuficiência renal grave'),

        // Reações Adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('Comuns (1–10%): Reações no local da infusão, nefrotoxicidade'),
        _textoObs('Incomuns (0,1–1%): Ototoxicidade, neutropenia'),
        _textoObs('Raras (<0,1%): Anafilaxia, síndrome do pescoço vermelho'),

        // Interações
        const SizedBox(height: 16),
        const Text('Interações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Potencializa nefrotoxicidade de aminoglicosídeos'),
        _textoObs('• Cuidado com uso concomitante de diuréticos de alça'),
        _textoObs('• Reduz eficácia de contraceptivos orais'),

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