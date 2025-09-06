import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoPetidina {
  static const String nome = 'Petidina';
  static const String idBulario = 'petidina';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/petidina.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário da petidina: $e');
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
      conteudo: _buildConteudoPetidina(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoPetidina(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        
        // Informações Gerais
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Classificação', 'Analgésico opioide; agonista dos receptores μ-opioides'),
        _linhaInfo('Mecanismo de Ação', 'Agonista μ-opioide com atividade anticolinérgica leve'),
        _linhaInfo('Meia-vida', '2,5-4 horas (petidina); 15-30 horas (normeperidina)'),
        _linhaInfo('Pico de ação', '30-60 minutos após IM/SC'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaApresentacao('Ampola 50mg/mL', '1mL, 2mL', 'Dolosal®, Demerol®'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('IV: diluir em 10-20mL SF, administrar lentamente', ''),
        _linhaPreparo('IM/SC: administrar diretamente', ''),
        _linhaPreparo('Não usar em infusão contínua', 'Risco de acúmulo de normeperidina'),

        // Indicações Clínicas com Cálculo de Dose
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Dor aguda moderada a intensa',
          descricaoDose: '50–100mg IM/IV a cada 4–6h',
          unidade: 'mg',
          dosePorKgMinima: 0.7,
          dosePorKgMaxima: 1.4,
          doseMaxima: 600,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Analgesia obstétrica',
          descricaoDose: '25–50mg IM a cada 3–4h',
          unidade: 'mg',
          dosePorKgMinima: 0.35,
          dosePorKgMaxima: 0.7,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Calafrios pós-anestésicos (off-label)',
          descricaoDose: '12,5–25mg IV lenta, dose única',
          unidade: 'mg',
          dosePorKgMinima: 0.18,
          dosePorKgMaxima: 0.35,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Pediatria',
          descricaoDose: '1–1,5 mg/kg/dose IM/SC/IV',
          unidade: 'mg',
          dosePorKgMinima: 1.0,
          dosePorKgMaxima: 1.5,
          peso: peso,
        ),

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Opioide de ação intermediária'),
        _textoObs('• Risco de neurotoxicidade (normeperidina)'),
        _textoObs('• Evitar em insuficiência renal e idosos'),
        _textoObs('• Útil em analgesia obstétrica'),
        _textoObs('• Pode causar náuseas, sedação, hipotensão e confusão'),
        _textoObs('• Não usar em infusão contínua ou dor crônica'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Absorção', 'IM/SC: 10-15 min; IV: 5 min'),
        _linhaInfo('Distribuição', 'Ligação: ~60%'),
        _linhaInfo('Metabolismo', 'Hepático (CYP3A4) para normeperidina'),
        _linhaInfo('Excreção', 'Renal (metabólitos conjugados)'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade à petidina'),
        _textoObs('• Uso concomitante com inibidores da MAO'),
        _textoObs('• Insuficiência renal ou hepática grave'),
        _textoObs('• Epilepsia não controlada'),
        _textoObs('• Uso crônico em dor crônica'),

        // Reações Adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Muito comuns: náusea, vômito, sedação, tontura, sudorese'),
        _textoObs('• Comuns: hipotensão, taquicardia, prurido, constipação'),
        _textoObs('• Incomuns: alucinações, agitação, tremores'),
        _textoObs('• Raras: convulsões (acúmulo de normeperidina)'),

        // Interações
        const SizedBox(height: 16),
        const Text('Interações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Inibidores da MAO: risco de crise serotoninérgica'),
        _textoObs('• Depressores do SNC: aumento da depressão respiratória'),
        _textoObs('• ISRS, tricíclicos: risco de síndrome serotoninérgica'),
        _textoObs('• Indutores hepáticos: reduzem eficácia'),

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

  static Widget _linhaApresentacao(String apresentacao, String concentracao, String observacao) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(child: Text(apresentacao)),
          const SizedBox(width: 8),
          Text(concentracao, style: const TextStyle(fontWeight: FontWeight.w500)),
          if (observacao.isNotEmpty) ...[
            const SizedBox(width: 8),
            Flexible(child: Text(observacao, style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 12))),
          ]
        ],
      ),
    );
  }

  static Widget _linhaPreparo(String texto, String obs) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
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
    String? unidade,
    double? dosePorKg,
    double? dosePorKgMinima,
    double? dosePorKgMaxima,
    double? doseMaxima,
    double? doseMinima,
    required double peso,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titulo, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(descricaoDose, style: const TextStyle(fontSize: 13)),
          if (dosePorKg != null && unidade != null) 
            Text('Dose: ${(dosePorKg * peso).toStringAsFixed(2)} $unidade', 
                 style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.blue)),
          if (dosePorKgMinima != null && dosePorKgMaxima != null && unidade != null)
            Text('Dose: ${(dosePorKgMinima * peso).toStringAsFixed(2)}–${(dosePorKgMaxima * peso).toStringAsFixed(2)} $unidade', 
                 style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.blue)),
          if (doseMinima != null && doseMaxima != null && unidade != null)
            Text('Dose: $doseMinima–$doseMaxima $unidade', 
                 style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.blue)),
          if (doseMaxima != null && unidade != null && doseMinima == null) 
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