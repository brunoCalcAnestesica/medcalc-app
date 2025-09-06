import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoSugamadex {
  static const String nome = 'Sugamadex';
  static const String idBulario = 'sugamadex';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/sugamadex.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário do sugamadex: $e');
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
      conteudo: _buildConteudoSugamadex(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoSugamadex(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        
        // Informações gerais
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Agente de reversão de bloqueador neuromuscular'),
        _textoObs('• Antagonista seletivo de relaxantes musculares esteroidais'),
        _textoObs('• Ciclodextrina modificada'),
        _textoObs('• Específico para rocurônio e vecurônio'),
        _textoObs('• Ação muito rápida (1–3 min)'),
        
        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('Frasco 100mg/mL (2mL ou 5mL)', 'Bridion®'),
        _linhaPreparo('Frascos-ampola de 200 mg/2 mL e 500 mg/5 mL', 'uso IV'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('IV direta, sem diluição', ''),
        _linhaPreparo('Bolus rápido em no máximo 10 segundos', ''),
        _linhaPreparo('Pronto para uso', ''),
        _linhaPreparo('Pode ser diluído em SF 0,9% ou SG 5%', ''),

        // Indicações clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        _linhaIndicacaoDoseCalculada(
          titulo: 'Reversão de bloqueio moderado (TOF 2)',
          descricaoDose: '2 mg/kg IV bolus único',
          unidade: 'mg',
          dosePorKg: 2.0,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Reversão profunda (TOF 0 + PTC 1–2)',
          descricaoDose: '4 mg/kg IV bolus único',
          unidade: 'mg',
          dosePorKg: 4.0,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Reversão imediata após intubação com rocurônio (1,2 mg/kg)',
          descricaoDose: '16 mg/kg IV bolus único',
          unidade: 'mg',
          dosePorKg: 16.0,
          peso: peso,
        ),

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Específico para rocurônio e vecurônio.'),
        _textoObs('• Ação muito rápida (1–3 min).'),
        _textoObs('• Não atua sobre bloqueadores benzilisoquinolínicos.'),
        _textoObs('• Pode causar bradicardia, broncoespasmo e reações anafiláticas.'),
        _textoObs('• Monitorização rigorosa da função neuromuscular (TOF).'),
        _textoObs('• Pode reduzir eficácia de contraceptivos hormonais por 7 dias.'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Início de ação: 1–3 minutos.'),
        _textoObs('• Pico de efeito: imediato após administração.'),
        _textoObs('• Duração do efeito: reversão completa e rápida.'),
        _textoObs('• Meia-vida: 2 horas.'),
        _textoObs('• Volume de distribuição: 11–14 L.'),
        _textoObs('• Ligação às proteínas plasmáticas: não significativa.'),
        _textoObs('• Metabolização: não é metabolizado.'),
        _textoObs('• Excreção: renal (>95% como fármaco inalterado em 24 horas).'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade conhecida ao sugamadex.'),
        _textoObs('• Insuficiência renal grave (ClCr <30 mL/min).'),
        _textoObs('• Neonatos e lactentes (<2 anos).'),
        _textoObs('• Pacientes em diálise.'),

        // Reações adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Comuns: alterações no paladar, náusea, vômito, hipotensão transitória, tosse, dor no local da injeção.'),
        _textoObs('• Incomuns: bradicardia, prolongamento do TTPa e TP.'),
        _textoObs('• Raras: reações anafiláticas, hipersensibilidade severa, bloqueio neuromuscular recorrente, edema facial, broncoespasmo, arritmias cardíacas.'),

        // Interações medicamentosas
        const SizedBox(height: 16),
        const Text('Interações Medicamentosas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Pode reduzir a eficácia de contraceptivos hormonais por 7 dias.'),
        _textoObs('• Potencial interação teórica com toremifeno e ácido fusídico.'),
        _textoObs('• Não interage com bloqueadores benzilisoquinolínicos.'),
        _textoObs('• Incompatível com soluções alcalinas e bicarbonato de sódio.'),

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