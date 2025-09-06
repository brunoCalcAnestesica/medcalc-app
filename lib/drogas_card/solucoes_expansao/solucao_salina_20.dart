import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoSolucaoSalina20 {
  static const String nome = 'Solução Salina Hipertônica 20%';
  static const String idBulario = 'salina_hipertonica_20';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/salina_hipertonica_20.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário da solução salina hipertônica 20%: $e');
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
      conteudo: _buildConteudoSolucaoSalina20(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoSolucaoSalina20(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        
        // Informações gerais
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Solução hipertônica concentrada'),
        _textoObs('• Agente hiperosmolar (6.840 mOsm/L)'),
        _textoObs('• Contém 3.420 mEq/L de Na⁺ e Cl⁻'),
        _textoObs('• Modulador osmótico intracraniano e intracelular'),
        _textoObs('• Uso exclusivo em neurointensivismo'),
        
        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('Ampolas 20 mL', 'uso emergencial'),
        _linhaPreparo('Frascos 100 mL e 250 mL', 'uso hospitalar'),
        _linhaPreparo('Concentração: 200 mg/mL NaCl', '3,4 mEq/mL de Na⁺'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('Pronta para uso - não diluir', ''),
        _linhaPreparo('Exclusivamente via central (CVC)', ''),
        _linhaPreparo('Bomba programada com filtro em linha', ''),
        _linhaPreparo('Monitorização contínua obrigatória', ''),

        // Indicações clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Hipertensão intracraniana refratária',
          descricaoDose: '1–2 mL/kg IV lento a cada 4–6h (máx 30–50 mL)',
          unidade: 'mL',
          dosePorKgMinima: 1,
          dosePorKgMaxima: 2,
          doseMaxima: 50,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Edema cerebral resistente',
          descricaoDose: '0,5–1 mL/kg/h IV contínuo (monitorar Na⁺)',
          unidade: 'mL/kg/h',
          dosePorKgMinima: 0.5,
          dosePorKgMaxima: 1.0,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Hiponatremia grave com risco de herniação',
          descricaoDose: '0,5–1 mL/kg IV lento (máx 30 mL)',
          unidade: 'mL',
          dosePorKgMinima: 0.5,
          dosePorKgMaxima: 1.0,
          doseMaxima: 30,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Reposição em cirurgia neurológica',
          descricaoDose: '30–50 mL IV lento conforme resposta clínica',
          unidade: 'mL',
          doseMaxima: 50,
          peso: peso,
        ),

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Cada 1 mL contém 200 mg de NaCl → 3,4 mEq de Na⁺.'),
        _textoObs('• Corrigir sódio máximo de 8–10 mEq/L em 24h (risco de mielinólise).'),
        _textoObs('• Exclusivamente via central - proibida via periférica.'),
        _textoObs('• Monitorar PIC, sódio sérico, osmolaridade e balanço hídrico.'),
        _textoObs('• Contraindicado em hipernatremia, ICC descompensada e edema pulmonar.'),
        _textoObs('• Uso sob protocolo neurointensivo com monitorização contínua.'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Distribuição: compartimento extracelular (predominantemente intravascular).'),
        _textoObs('• Metabolismo: não aplicável (substância inorgânica).'),
        _textoObs('• Excreção: renal (regulação hormonal – ADH, aldosterona).'),
        _textoObs('• Meia-vida efetiva: minutos a 2 horas.'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipernatremia (>150 mEq/L).'),
        _textoObs('• ICC descompensada.'),
        _textoObs('• Edema pulmonar.'),
        _textoObs('• Lesão renal aguda sem diurese efetiva.'),
        _textoObs('• Impossibilidade de monitorização intensiva de eletrólitos.'),
        _textoObs('• Via periférica, intramuscular ou subcutânea.'),

        // Reações adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Comuns: sede intensa, cefaleia, náuseas.'),
        _textoObs('• Incomuns: hipernatremia, hipervolemia, taquicardia, aumento da PA.'),
        _textoObs('• Raras: desmielinização osmótica, edema pulmonar agudo, tromboflebite.'),
        _textoObs('• Extravasamento pode causar necrose grave.'),

        // Interações medicamentosas
        const SizedBox(height: 16),
        const Text('Interações Medicamentosas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Incompatível com bicarbonato de sódio, cálcio concentrado e fosfatos.'),
        _textoObs('• Potencialização de toxicidade com lítio e digoxina.'),
        _textoObs('• Pode interagir com diuréticos de alça, IECA, antagonistas de aldosterona.'),
        _textoObs('• Cautela com corticosteroides e mineralocorticoides.'),

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