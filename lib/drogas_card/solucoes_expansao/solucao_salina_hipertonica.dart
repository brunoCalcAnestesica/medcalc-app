import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoSolucaoSalinaHipertonica {
  static const String nome = 'Solução Salina Hipertônica 3%';
  static const String idBulario = 'salina_hipertonica_3';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/salina_hipertonica_3.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário da solução salina hipertônica 3%: $e');
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
      conteudo: _buildConteudoSolucaoSalinaHipertonica(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoSolucaoSalinaHipertonica(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        
        // Informações gerais
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Solução hipertônica cristaloide'),
        _textoObs('• Agente hiperosmolar (1.026 mOsm/L)'),
        _textoObs('• Contém 513 mEq/L de Na⁺ e Cl⁻'),
        _textoObs('• Antiedema cerebral e repositor eletrolítico'),
        
        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('Frascos 100 mL, 250 mL, 500 mL, 1000 mL', 'pronto para uso'),
        _linhaPreparo('Ampolas 20 mL e 50 mL', 'uso emergencial'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('Pronta para uso - não diluir', ''),
        _linhaPreparo('Conectar sob técnica asséptica', ''),
        _linhaPreparo('Preferencialmente acesso central', 'periférico com veia calibrosa'),

        // Indicações clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Hiponatremia sintomática grave',
          descricaoDose: '2–4 mL/kg IV em bolus (até 100 mL), repetir até melhora neurológica',
          unidade: 'mL',
          dosePorKgMinima: 2,
          dosePorKgMaxima: 4,
          doseMaxima: 100,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Hiponatremia crônica',
          descricaoDose: '0,5–1 mL/kg/h IV contínuo (monitorar Na⁺ sérico a cada 4h)',
          unidade: 'mL/kg/h',
          dosePorKgMinima: 0.5,
          dosePorKgMaxima: 1.0,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Hipertensão intracraniana (TCE, HIC)',
          descricaoDose: '2–5 mL/kg IV em bolus a cada 4–6h ou infusão contínua',
          unidade: 'mL',
          dosePorKgMinima: 2,
          dosePorKgMaxima: 5,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Edema cerebral agudo',
          descricaoDose: '100 mL IV em 10 minutos (repetir até 3x se necessário)',
          unidade: 'mL',
          doseMaxima: 100,
          peso: peso,
        ),

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Cada 1 mL contém 0,513 mEq de Na⁺.'),
        _textoObs('• Corrigir sódio máximo de 8–10 mEq/L em 24h (risco de mielinólise).'),
        _textoObs('• Idealmente acesso central, mas pode ser periférico com cautela.'),
        _textoObs('• Monitorar eletrólitos, osmolaridade e diurese frequentemente.'),
        _textoObs('• Contraindicado em hipernatremia, ICC descompensada e edema agudo de pulmão.'),
        _textoObs('• Compatível com bomba de infusão e sistemas de microgotas.'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Distribuição: predominantemente no espaço extracelular.'),
        _textoObs('• Metabolismo: não se aplica (substância inorgânica).'),
        _textoObs('• Excreção: renal, regulada por mecanismos hormonais.'),
        _textoObs('• Meia-vida efetiva: minutos a horas dependendo da perfusão.'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipernatremia pré-existente (>150 mEq/L).'),
        _textoObs('• Hipervolemia não tratada.'),
        _textoObs('• ICC descompensada.'),
        _textoObs('• Insuficiência renal sem diurese adequada.'),
        _textoObs('• Edema agudo de pulmão.'),

        // Reações adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Comuns: sede, irritação venosa, calafrios, náusea.'),
        _textoObs('• Incomuns: hipernatremia, hipervolemia, taquicardia.'),
        _textoObs('• Raras: desmielinização osmótica, ICC aguda, acidose hiperclorêmica.'),
        _textoObs('• Extravasamento pode causar necrose local.'),

        const SizedBox(height: 16),
      ],
    );
  }

  static Widget _linhaPreparo(String texto, String marca) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(
              texto,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          if (marca.isNotEmpty)
            Text(
              ' ($marca)',
              style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
        ],
      ),
    );
  }

  static Widget _linhaIndicacaoDoseCalculada({
    required String titulo,
    required String descricaoDose,
    String unidade = '',
    double? dosePorKg,
    double? dosePorKgMinima,
    double? dosePorKgMaxima,
    double? doseMaxima,
    required double peso,
  }) {
    double? doseCalculada;
    double? doseCalculadaMin;
    double? doseCalculadaMax;

    // Identificar se é dose de infusão
    final isInfusao = descricaoDose.contains('/min') ||
        descricaoDose.contains('infusão') ||
        descricaoDose.contains('bomba contínua') ||
        descricaoDose.contains('/h');

    if (dosePorKg != null) {
      doseCalculada = dosePorKg * peso;
      if (doseMaxima != null && doseCalculada > doseMaxima) {
        doseCalculada = doseMaxima;
      }
    }

    if (dosePorKgMinima != null) {
      doseCalculadaMin = dosePorKgMinima * peso;
      if (doseMaxima != null && doseCalculadaMin > doseMaxima) {
        doseCalculadaMin = doseMaxima;
      }
    }

    if (dosePorKgMaxima != null) {
      doseCalculadaMax = dosePorKgMaxima * peso;
      if (doseMaxima != null && doseCalculadaMax > doseMaxima) {
        doseCalculadaMax = doseMaxima;
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            descricaoDose,
            style: const TextStyle(fontSize: 13),
          ),
          if (!isInfusao && doseCalculada != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                'Dose calculada: ${doseCalculada.toStringAsFixed(1)} $unidade',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
            ),
          if (!isInfusao && doseCalculadaMin != null && doseCalculadaMax != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                'Dose calculada: ${doseCalculadaMin.toStringAsFixed(1)}–${doseCalculadaMax.toStringAsFixed(1)} $unidade',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
            ),
        ],
      ),
    );
  }

  static Widget _textoObs(String texto) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        texto,
        style: const TextStyle(fontSize: 13),
      ),
    );
  }
} 