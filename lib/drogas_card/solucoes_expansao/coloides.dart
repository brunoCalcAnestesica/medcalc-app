import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoColoides {
  static const String nome = 'Coloides';
  static const String idBulario = 'coloides';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/coloides.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário dos coloides: $e');
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
      conteudo: _buildConteudoColoides(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoColoides(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        
        // Informações gerais
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Expansores plasmáticos'),
        _textoObs('• Soluções coloidais intravenosas'),
        _textoObs('• Agentes oncóticos artificiais ou naturais'),
        _textoObs('• Permanência intravascular prolongada'),
        _textoObs('• Efeito expansor superior aos cristaloides'),
        
        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('Albumina 5% e 20%', 'Albumina Humana®'),
        _linhaPreparo('Gelatinas modificadas', 'Gelafundin®, Geloplasma®'),
        _linhaPreparo('Hidroxietilamido (HES) 6%', 'Voluven®, Haes-steril®'),
        _linhaPreparo('Dextranos', 'Plasmion®'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('Prontos para uso - não diluir', ''),
        _linhaPreparo('Via intravenosa exclusiva', ''),
        _linhaPreparo('Infusão lenta ou contínua', ''),
        _linhaPreparo('Acesso central para soluções hiperosmolares', ''),

        // Indicações clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Expansão volêmica em choque ou grandes perdas',
          descricaoDose: '10–20 mL/kg IV conforme resposta hemodinâmica',
          unidade: 'mL',
          dosePorKgMinima: 10,
          dosePorKgMaxima: 20,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Hipoalbuminemia grave (<2 g/dL)',
          descricaoDose: '1g/kg de albumina 20% por dia (equivale a 5mL/kg)',
          unidade: 'mL',
          dosePorKgMinima: 5,
          dosePorKgMaxima: 5,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Paracentese maciça (ascite em cirrose)',
          descricaoDose: '6–8g de albumina 20% por litro de ascite retirado',
          unidade: 'g',
          dosePorKg: 6,
          doseMaxima: 8,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Choque hipovolêmico refratário',
          descricaoDose: '500–1000 mL em bolus conforme resposta hemodinâmica',
          unidade: 'mL',
          doseMaxima: 1000,
          peso: peso,
        ),

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Coloides permanecem mais tempo no intravascular que cristaloides.'),
        _textoObs('• Albumina é o coloide natural mais seguro — preferida em cirrose, sepse e hipoalbuminemia.'),
        _textoObs('• HES e gelatinas → risco de sangramento, nefrotoxicidade e anafilaxia.'),
        _textoObs('• Uso deve ser criterioso — avaliar benefício x risco x custo.'),
        _textoObs('• Monitorar PA, diurese e sinais de sobrecarga.'),
        _textoObs('• HES de alto peso molecular contraindicados em sepse e TCE.'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Início de ação: imediato.'),
        _textoObs('• Meia-vida: Albumina 20%: 16–24 h; Gelatina: 2–6 h; HES: 4–12 h.'),
        _textoObs('• Distribuição: volume intravascular primário (colóides não extravasam facilmente).'),
        _textoObs('• Excreção: renal (gelatinas, HES, dextranos); catabolismo hepático (albumina).'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipervolemia, insuficiência cardíaca descompensada.'),
        _textoObs('• Hipersensibilidade a componentes (gelatina, amido, dextrano).'),
        _textoObs('• Coagulopatia grave não corrigida (em HES e dextranos).'),
        _textoObs('• ICC descompensada (albumina hiperoncótica 20%).'),

        // Reações adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Comuns: hipervolemia, cefaleia, rubor facial, aumento de PA.'),
        _textoObs('• Incomuns: reações alérgicas, rash, urticária.'),
        _textoObs('• Raras: anafilaxia (gelatinas), coagulopatia (HES), lesão renal aguda (HES).'),
        _textoObs('• Prurido persistente (HES), síndrome de disfunção orgânica múltiple.'),

        // Interações medicamentosas
        const SizedBox(height: 16),
        const Text('Interações Medicamentosas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Albumina pode aumentar ligação e meia-vida de fármacos lipofílicos.'),
        _textoObs('• HES e dextranos podem interferir na coagulação e potencializar anticoagulantes.'),
        _textoObs('• Incompatível com concentrados de eletrólitos hiperosmolares (precipitação).'),
        _textoObs('• Monitorar interações com anticoagulantes em infusões prolongadas.'),

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