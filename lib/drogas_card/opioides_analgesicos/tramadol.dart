import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoTramadol {
  static const String nome = 'Tramadol';
  static const String idBulario = 'tramadol';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/tramadol.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário do tramadol: $e');
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
      conteudo: _buildConteudoTramadol(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoTramadol(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        
        // Informações Gerais
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Classificação', 'Analgésico opioide sintético; agonista μ-opioide fraco'),
        _linhaInfo('Mecanismo de Ação', 'Agonista μ-opioide + inibidor da recaptação de serotonina e noradrenalina'),
        _linhaInfo('Meia-vida', '5-6 horas (tramadol); 6-8 horas (metabólito M1)'),
        _linhaInfo('Pico de ação', '1,5-2 horas (VO); 30 minutos (IV)'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaApresentacao('Ampola 50mg/mL', '1mL, 2mL', 'Solução injetável'),
        _linhaApresentacao('Comprimidos VO', '50mg, 100mg', 'Liberação imediata'),
        _linhaApresentacao('Comprimidos LP', '100mg, 150mg, 200mg', 'Liberação prolongada'),
        _linhaApresentacao('Gotas VO', '100mg/mL', '1 gota = 2,5mg'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('IV lento (2-3 minutos) ou diluir em 100mL SF', 'Infusão em 15-30 minutos'),
        _linhaPreparo('IM ou SC direto', 'Sem diluição necessária'),
        _linhaPreparo('VO com ou sem alimentos', 'Duração: 4-6 horas'),

        // Indicações Clínicas com Cálculo de Dose
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Dor moderada a intensa (parenteral)',
          descricaoDose: '50–100mg IV ou IM a cada 4-6h',
          unidade: 'mg',
          dosePorKgMinima: 50 / peso,
          dosePorKgMaxima: 100 / peso,
          doseMaxima: 400,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Dor crônica (via oral)',
          descricaoDose: '50–100mg VO a cada 6-8h',
          unidade: 'mg',
          dosePorKgMinima: 50 / peso,
          dosePorKgMaxima: 100 / peso,
          doseMaxima: 400,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Pediatria (>12 anos)',
          descricaoDose: '1–2 mg/kg VO ou IV a cada 6-8h',
          unidade: 'mg',
          dosePorKgMinima: 1.0,
          dosePorKgMaxima: 2.0,
          doseMaxima: 400,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Idosos (>75 anos)',
          descricaoDose: 'Dose máxima reduzida: 300mg/dia',
          unidade: 'mg',
          doseMaxima: 300,
          peso: peso,
        ),

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Opioide atípico: agonista μ fraco + inibidor da recaptação de serotonina e noradrenalina'),
        _textoObs('• Menor risco de depressão respiratória comparado à morfina'),
        _textoObs('• Pode causar náusea, tontura, sudorese, confusão e sonolência'),
        _textoObs('• Contraindicado em epilepsia não controlada e uso de IMAOs ou ISRS'),
        _textoObs('• Usar com cautela em insuficiência renal ou hepática'),
        _textoObs('• Risco de síndrome serotoninérgica em combinação com antidepressivos'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Absorção', 'Rápida (VO: 70-75%; IV: 100%)'),
        _linhaInfo('Distribuição', 'Ligação a proteínas: 20%'),
        _linhaInfo('Metabolismo', 'Hepático (CYP2D6 e CYP3A4)'),
        _linhaInfo('Excreção', 'Renal (30% tramadol, 60% metabólitos)'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade ao tramadol'),
        _textoObs('• Intoxicação aguda por álcool, hipnóticos, opioides'),
        _textoObs('• Uso concomitante com IMAO (14 dias após descontinuação)'),
        _textoObs('• Epilepsia não controlada'),
        _textoObs('• Idade <12 anos ou <18 anos pós cirurgia de adenoide/amigdalectomia'),

        // Reações Adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Muito comuns: náusea, tontura, sudorese'),
        _textoObs('• Comuns: vômito, constipação, cefaleia, sonolência'),
        _textoObs('• Incomuns: convulsões, síndrome serotoninérgica, confusão'),
        _textoObs('• Raras: reações alérgicas graves, alucinações, dependência'),

        // Interações
        const SizedBox(height: 16),
        const Text('Interações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Aumento do risco de convulsões com ISRS, tricíclicos, bupropiona'),
        _textoObs('• Risco de síndrome serotoninérgica com IMAO, ISRS, triptanos'),
        _textoObs('• Potencialização de sedação com álcool, benzodiazepínicos'),
        _textoObs('• Indutores do CYP3A4 (carbamazepina) reduzem eficácia'),

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
          if (doseMaxima != null && unidade != null) 
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