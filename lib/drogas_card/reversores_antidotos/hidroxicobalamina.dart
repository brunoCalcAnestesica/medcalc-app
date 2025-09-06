import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoHidroxicobalamina {
  static const String nome = 'Hidroxicobalamina';
  static const String idBulario = 'hidroxicobalamina';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/hidroxicobalamina.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário da hidroxicobalamina: $e');
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
      conteudo: _buildConteudoHidroxicobalamina(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoHidroxicobalamina(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        
        // Informações gerais
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Antídoto para intoxicação por cianeto'),
        _textoObs('• Derivado da vitamina B12 (cobalamina)'),
        _textoObs('• Agente quelante do íon cianeto'),
        _textoObs('• Forma cianocobalamina não tóxica'),
        _textoObs('• Neutraliza efeitos letais do cianeto'),
        
        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('Frasco 1g/50mL (20mg/mL)', 'Cyanokit®, Hidrovit®'),
        _linhaPreparo('Frasco-ampola liofilizado 2,5g', 'com diluente próprio'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('Reconstituir 2,5g com 100mL de diluente próprio', ''),
        _linhaPreparo('Agitar vigorosamente por 60 segundos', ''),
        _linhaPreparo('Solução final: 25mg/mL', ''),
        _linhaPreparo('IV lenta em 15 min (antídoto)', ''),
        _linhaPreparo('Para infusão: 5g em 200mL SF 0,9%', ''),

        // Indicações clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        _linhaIndicacaoDoseCalculada(
          titulo: 'Intoxicação por cianeto',
          descricaoDose: '5g IV em 15 min, repetir se necessário (máx 10g)',
          unidade: 'g',
          doseMaxima: 10,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Anemia megaloblástica',
          descricaoDose: '1000 mcg IM semanal por 4–6 semanas → mensal',
          unidade: 'mcg',
          doseMaxima: 1000,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Prevenção (gastrectomia, alcoolismo, bariátrica)',
          descricaoDose: '1000 mcg IM ou VO mensal',
          unidade: 'mcg',
          doseMaxima: 1000,
          peso: peso,
        ),

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Antídoto de escolha para intoxicação por cianeto.'),
        _textoObs('• Causa coloração avermelhada na pele, urina e mucosas (benigno).'),
        _textoObs('• Reações: hipertensão transitória, náusea, cefaleia.'),
        _textoObs('• Monitorização contínua de parâmetros hemodinâmicos.'),
        _textoObs('• Ter suporte avançado de vida disponível.'),
        _textoObs('• Informar laboratório sobre interferência em exames.'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Início de ação: imediato.'),
        _textoObs('• Pico de efeito: minutos após o início da infusão.'),
        _textoObs('• Duração clínica: variável, de acordo com a gravidade da intoxicação.'),
        _textoObs('• Meia-vida: 26–31 horas.'),
        _textoObs('• Volume de distribuição: 0,9–5,1 L/kg.'),
        _textoObs('• Ligação às proteínas plasmáticas: moderada.'),
        _textoObs('• Metabolização: mínima.'),
        _textoObs('• Excreção: renal, predominantemente como cianocobalamina.'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade conhecida à hidroxicobalamina.'),
        _textoObs('• Usar com cautela na insuficiência renal moderada a grave.'),
        _textoObs('• Não contraindica o uso em emergências.'),

        // Reações adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Muito comuns: eritema cutâneo, coloração avermelhada da pele e mucosas, alteração na cor da urina, rash.'),
        _textoObs('• Comuns: náusea, vômito, cefaleia, hipertensão transitória, reações no local da infusão.'),
        _textoObs('• Incomuns: taquicardia, anafilaxia, prurido, dispneia, insuficiência renal transitória.'),
        _textoObs('• Raras: edema pulmonar, reações alérgicas graves, lesão renal aguda.'),

        // Interações medicamentosas
        const SizedBox(height: 16),
        const Text('Interações Medicamentosas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Pode interferir em exames laboratoriais: gases arteriais, creatinina, bilirrubina.'),
        _textoObs('• Cooximetria pode estar falsamente alterada.'),
        _textoObs('• Nenhuma interação farmacológica clinicamente relevante descrita.'),

        const SizedBox(height: 16),
      ],
    );
  }

  static Widget _linhaPreparo(String texto, String observacao) {
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
          if (observacao.isNotEmpty)
            Text(
              ' ($observacao)',
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
          if (doseCalculada != null)
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
          if (doseCalculadaMin != null && doseCalculadaMax != null)
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