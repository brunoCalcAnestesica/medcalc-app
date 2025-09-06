import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoNalbuphina {
  static const String nome = 'Nalbuphina';
  static const String idBulario = 'nalbuphina';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/nalbuphina.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário da nalbuphina: $e');
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
      conteudo: _buildConteudoNalbuphina(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoNalbuphina(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Nubain®'),
        _linhaInfo('Classificação', 'Agonista-antagonista opioide'),
        _linhaInfo('Mecanismo', 'Agonista κ-opioide e antagonista μ-opioide'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('Ampola 10mg/mL (1mL ou 2mL)', 'Nubain®'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('IV lenta', '0,1–0,2 mg/kg em 2–3 min'),
        _linhaPreparo('IM/SC', '10mg a cada 3–6h'),
        _linhaPreparo('Infusão contínua', 'Diluir em SF 0,9% se necessário'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        _linhaIndicacaoDoseCalculada(
          titulo: 'Dor aguda moderada a intensa',
          descricaoDose: '10–20mg IV ou IM a cada 3–6h',
          unidade: 'mg',
          dosePorKgMinima: 10 / peso,
          dosePorKgMaxima: 20 / peso,
          doseMaxima: 160,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Dor obstétrica',
          descricaoDose: '10mg IM ou IV a cada 3h (evitar próximo do parto)',
          unidade: 'mg',
          dosePorKgMinima: 10 / peso,
          dosePorKgMaxima: 10 / peso,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Pediatria',
          descricaoDose: '0,1–0,2 mg/kg IV/IM/SC a cada 4–6h',
          unidade: 'mg',
          dosePorKgMinima: 0.1,
          dosePorKgMaxima: 0.2,
          peso: peso,
        ),

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Efeito teto para depressão respiratória (mais seguro que opioides μ-puros).'),
        _textoObs('• Excelente alternativa à morfina em pacientes com risco de apneia.'),
        _textoObs('• Menos náusea, vômito e prurido que morfina.'),
        _textoObs('• Evitar uso concomitante com opioides μ-puros (antagonismo).'),
        _textoObs('• Menor potencial de abuso e dependência.'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Início de ação: 2–3 min (IV), 15 min (IM).'),
        _textoObs('• Duração: 3–6 horas.'),
        _textoObs('• Meia-vida: 5 horas (adulto), até 10 horas (neonatal).'),
        _textoObs('• Metabolização hepática (conjugação com ácido glicurônico).'),
        _textoObs('• Excreção renal como metabólitos inativos.'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade à nalbuphina.'),
        _textoObs('• Depressão respiratória sem suporte ventilatório.'),
        _textoObs('• Uso concomitante com agonistas opioides μ crônicos.'),
        _textoObs('• Doença psiquiátrica descompensada com risco de disforia.'),

        // Reações Adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Comuns: náusea, tontura, sedação, sudorese, prurido.'),
        _textoObs('• Incomuns: disforia, alucinações leves, euforia, cefaleia.'),
        _textoObs('• Raras: reações anafiláticas, apneia (doses altas).'),
        _textoObs('• Síndrome de abstinência aguda se em uso de opioides μ.'),

        // Interações
        const SizedBox(height: 16),
        const Text('Interações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Potencializa sedação com álcool, benzodiazepínicos e barbitúricos.'),
        _textoObs('• Antagoniza parcialmente opioides μ (morfina, fentanil).'),
        _textoObs('• Pode precipitar abstinência em usuários crônicos de opioides μ.'),
        _textoObs('• Monitorar uso com outros depressores centrais.'),

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

  static Widget _linhaPreparo(String texto, String obs) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text(texto)),
          if (obs.isNotEmpty) ...[
            const SizedBox(width: 8),
            Flexible(child: Text(obs, style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 12))),
          ]
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
            Text('Dose máxima: $doseMaxima $unidade/dia', 
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