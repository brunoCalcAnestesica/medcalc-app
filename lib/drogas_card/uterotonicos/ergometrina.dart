import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoErgometrina {
  static const String nome = 'Ergometrina';
  static const String idBulario = 'ergometrina';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/ergometrina.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário da ergometrina: $e');
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
      conteudo: _buildConteudoErgometrina(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoErgometrina(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        
        // Informações gerais
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Agente uterotônico, alcaloide do ergot'),
        _textoObs('• Agonista parcial de receptores serotoninérgicos, dopaminérgicos e adrenérgicos'),
        _textoObs('• Segunda linha após falha da ocitocina'),
        
        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('Ampola 0,2 mg/mL (1 mL)', 'Ergotrate®, Methergin®'),
        _linhaPreparo('Comprimido 0,125 mg', 'uso oral'),
        _linhaPreparo('Comprimido 0,25 mg', 'uso oral'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('Usar IM direta ou IV lenta (≥1 min)', ''),
        _linhaPreparo('Repetir dose a cada 2–4h se necessário', ''),
        _linhaPreparo('Diluir em 10 mL SF se necessário para IV', ''),

        // Indicações clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Hemorragia pós-parto (HPP)',
          descricaoDose: '0,2 mg IM ou IV lenta, repetir a cada 2–4h (máx 1 mg/24h)',
          unidade: 'mg',
          doseMaxima: 1,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Atonia uterina refratária',
          descricaoDose: '0,2 mg IM ou IV lenta após falha da ocitocina',
          unidade: 'mg',
          doseMaxima: 0.2,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Prevenção da HPP',
          descricaoDose: '0,2 mg IM ou VO imediatamente após dequitação placentária',
          unidade: 'mg',
          doseMaxima: 0.2,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Subinvolução uterina',
          descricaoDose: '0,2 mg VO 2–3 vezes ao dia por até 5 dias',
          unidade: 'mg',
          doseMaxima: 0.2,
          peso: peso,
        ),

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Agonista direto de receptores musculares lisos uterinos.'),
        _textoObs('• Contraindicado em hipertensão, pré-eclâmpsia e cardiopatia isquêmica.'),
        _textoObs('• Pode causar náuseas, vômitos, vasoconstrição e elevação da pressão arterial.'),
        _textoObs('• Uso preferencial após a saída da placenta.'),
        _textoObs('• Manter sob refrigeração (entre 2–8 °C).'),
        _textoObs('• Monitorização rigorosa de PA durante administração IV.'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Início de ação: 1–2 minutos IV, 2–5 minutos IM, 5–10 minutos VO.'),
        _textoObs('• Duração do efeito: 2–4 horas.'),
        _textoObs('• Meia-vida plasmática: 30–120 minutos.'),
        _textoObs('• Metabolização hepática (CYP3A4).'),
        _textoObs('• Excreção predominantemente biliar, pequena fração renal (5–10%).'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipertensão arterial não controlada.'),
        _textoObs('• Doença cardíaca isquêmica.'),
        _textoObs('• Vasculopatias periféricas ou cerebrais.'),
        _textoObs('• Insuficiência hepática grave.'),
        _textoObs('• Sepse.'),
        _textoObs('• Hipersensibilidade conhecida aos alcaloides do ergot.'),
        _textoObs('• Gravidez (exceto no manejo da HPP).'),

        // Reações adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Muito comuns: náusea, vômito, diarreia, dor abdominal tipo cólica.'),
        _textoObs('• Comuns: hipertensão arterial transitória, cefaleia, rubor, parestesias.'),
        _textoObs('• Incomuns: bradicardia reflexa, elevação transitória da PA severa.'),
        _textoObs('• Raras: vasoespasmo coronariano, isquemia miocárdica, AVC isquêmico.'),

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
        descricaoDose.contains('bomba contínua');

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
                'Dose calculada: ${doseCalculada.toStringAsFixed(2)} $unidade',
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
                'Dose calculada: ${doseCalculadaMin.toStringAsFixed(2)}–${doseCalculadaMax.toStringAsFixed(2)} $unidade',
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