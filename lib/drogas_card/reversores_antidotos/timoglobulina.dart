import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoTimoglobulina {
  static const String nome = 'Timoglobulina';
  static const String idBulario = 'timoglobulina';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/timoglobulina.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário da timoglobulina: $e');
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
      conteudo: _buildConteudoTimoglobulina(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoTimoglobulina(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        
        // Informações gerais
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Imunossupressor, imunoglobulina policlonal anti-linfócito'),
        _textoObs('• Anticorpo policlonal de coelho'),
        _textoObs('• Liga-se a múltiplos antígenos de superfície de linfócitos T'),
        _textoObs('• Depleção de linfócitos T por lise mediada por complemento'),
        _textoObs('• Imunossupressão profunda com inibição da resposta imune celular'),
        
        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('Frasco 25mg em pó liofilizado', 'Thymoglobuline®'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('Reconstituir cada frasco de 25mg com 5mL de água para injeção', ''),
        _linhaPreparo('Diluir em 50 a 500mL de SF 0,9% ou SG 5%', ''),
        _linhaPreparo('Utilizar filtro de 0,2 micra durante a infusão', ''),
        _linhaPreparo('Solução límpida, incolor a levemente opalescente', ''),
        _linhaPreparo('Proteger da luz', ''),

        // Indicações clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        _linhaIndicacaoDoseCalculada(
          titulo: 'Transplante de órgãos sólidos',
          descricaoDose: '1,5 mg/kg/dia IV por 3–5 dias',
          unidade: 'mg',
          dosePorKg: 1.5,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Aplasia medular severa',
          descricaoDose: '2,5–3,5 mg/kg/dia IV por 5 dias',
          unidade: 'mg',
          dosePorKgMinima: 2.5,
          dosePorKgMaxima: 3.5,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Profilaxia de rejeição aguda',
          descricaoDose: '1,5 mg/kg/dia IV por 3–5 dias',
          unidade: 'mg',
          dosePorKg: 1.5,
          peso: peso,
        ),

        // Administração
        const SizedBox(height: 16),
        const Text('Administração', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Infusão intravenosa lenta'),
        _textoObs('• Diluir em SF 0,9% ou SG 5%'),
        _textoObs('• Administrar por bomba de infusão em 4–6 horas'),
        _textoObs('• Usar filtro de 0,2 micra durante a administração'),
        _textoObs('• Pré-medicação obrigatória: corticosteroides, anti-histamínicos e antipiréticos'),

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Monitorização contínua de sinais vitais durante e após a infusão.'),
        _textoObs('• Suspender imediatamente em caso de reações anafiláticas.'),
        _textoObs('• Monitorar hemograma, função renal e hepática.'),
        _textoObs('• Vigilância rigorosa para sinais de infecção.'),
        _textoObs('• Conservar entre 2°C e 8°C (refrigerado).'),
        _textoObs('• Após reconstituição, usar em até 24 horas sob refrigeração.'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Início de ação imediato na infusão IV.'),
        _textoObs('• Meia-vida média de 2–3 dias, podendo variar até 30 dias.'),
        _textoObs('• Distribuição rápida no espaço intravascular.'),
        _textoObs('• Metabolização por proteólise em aminoácidos e pequenos peptídeos.'),
        _textoObs('• Excreção renal e pelo sistema reticuloendotelial.'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade a proteínas de coelho.'),
        _textoObs('• Hipersensibilidade a qualquer componente da fórmula.'),
        _textoObs('• Infecções ativas não controladas (bacterianas, virais, fúngicas).'),
        _textoObs('• Leucopenia grave (<2000/mm³).'),
        _textoObs('• Linfopenia grave.'),
        _textoObs('• Trombocitopenia severa (<50.000/mm³).'),

        // Reações adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Síndrome de liberação de citocinas (febre, calafrios, hipotensão, taquicardia).'),
        _textoObs('• Reações infusionais (rash, prurido, urticária, dispneia, broncoespasmo).'),
        _textoObs('• Leucopenia, linfopenia, trombocitopenia, anemia.'),
        _textoObs('• Infecções oportunistas (CMV, EBV, herpes, fungos).'),
        _textoObs('• Reativação viral (CMV, EBV, hepatites).'),
        _textoObs('• Septicemia, doença linfoproliferativa pós-transplante (PTLD).'),
        _textoObs('• Elevação transitória de enzimas hepáticas.'),

        // Interações medicamentosas
        const SizedBox(height: 16),
        const Text('Interações Medicamentosas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Efeito imunossupressor aditivo com outros imunossupressores.'),
        _textoObs('• Aumenta risco de infecção com agentes biológicos.'),
        _textoObs('• Potencializa mielossupressão com agentes citotóxicos.'),
        _textoObs('• Monitorar risco aumentado de linfoma e PTLD.'),

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