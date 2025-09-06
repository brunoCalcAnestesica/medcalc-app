import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoMorfina {
  static const String nome = 'Morfina';
  static const String idBulario = 'morfina';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/morfina.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário da morfina: $e');
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
      conteudo: _buildConteudoMorfina(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoMorfina(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Dimorf®, Sevredol®, MST Continus®'),
        _linhaInfo('Classificação', 'Agonista μ-opioide puro'),
        _linhaInfo('Mecanismo', 'Agonista seletivo dos receptores μ-opioides'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('Ampola 10mg/mL, 20mg/mL, 50mg/mL', 'Solução injetável'),
        _linhaPreparo('Comprimidos 10mg, 30mg', 'Liberação imediata e prolongada'),
        _linhaPreparo('Gotas orais 10mg/mL', '1 gota ≈ 0,2mg'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('IV lenta', 'Diluir 1mL em 9mL SF 0,9% (1mg/mL)'),
        _linhaPreparo('IM/SC', 'Administrar diretamente'),
        _linhaPreparo('Via oral', 'Comprimidos inteiros, não triturar'),
        _linhaPreparo('Infusão contínua', 'Diluir em SF 0,9% conforme protocolo'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        _linhaIndicacaoDoseCalculada(
          titulo: 'Dor aguda grave (hospitalar)',
          descricaoDose: '2,5–5mg IV ou 5–10mg IM/SC a cada 3–4h',
          unidade: 'mg',
          dosePorKgMinima: 2.5 / peso,
          dosePorKgMaxima: 10 / peso,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Dor crônica oncológica (via oral)',
          descricaoDose: '10–30mg VO a cada 4h (liberação imediata)',
          unidade: 'mg',
          dosePorKgMinima: 10 / peso,
          dosePorKgMaxima: 30 / peso,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Dispneia refratária / cuidados paliativos',
          descricaoDose: '2,5–5mg SC a cada 4–6h',
          unidade: 'mg',
          dosePorKgMinima: 2.5 / peso,
          dosePorKgMaxima: 5 / peso,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Síndrome coronariana aguda',
          descricaoDose: '2–4mg IV lenta (repetir conforme dor)',
          unidade: 'mg',
          dosePorKgMinima: 2 / peso,
          dosePorKgMaxima: 4 / peso,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Pediatria',
          descricaoDose: '0,05–0,1 mg/kg IV a cada 4h',
          unidade: 'mg',
          dosePorKgMinima: 0.05,
          dosePorKgMaxima: 0.1,
          peso: peso,
        ),

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Padrão ouro para dor intensa — agonista μ-opioide puro.'),
        _textoObs('• Não há efeito teto para analgesia (dose-dependente).'),
        _textoObs('• Depressão respiratória, constipação e hipotensão são comuns.'),
        _textoObs('• Dose deve ser individualizada com titulação cuidadosa.'),
        _textoObs('• Antagonizável com naloxona em caso de intoxicação.'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Início de ação: 5–10 min (IV), 20–30 min (IM), 30–60 min (oral).'),
        _textoObs('• Duração: 4–5 horas (imediata), até 12–24h (prolongada).'),
        _textoObs('• Meia-vida: 2–4 horas.'),
        _textoObs('• Metabolização hepática (M3G e M6G).'),
        _textoObs('• Excreção renal (90%), bile (10%).'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade à morfina.'),
        _textoObs('• Depressão respiratória sem suporte ventilatório.'),
        _textoObs('• Asma aguda ou obstrução de vias aéreas não tratada.'),
        _textoObs('• Uso concomitante com IMAOs.'),
        _textoObs('• TCE com hipertensão intracraniana não controlada.'),

        // Reações Adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Muito comuns: náusea, vômito, constipação, sonolência, prurido.'),
        _textoObs('• Comuns: hipotensão, retenção urinária, confusão, sudorese.'),
        _textoObs('• Incomuns: alucinações, delírio, mioclonia, bradicardia.'),
        _textoObs('• Raras: depressão respiratória grave, reações anafiláticas.'),

        // Interações
        const SizedBox(height: 16),
        const Text('Interações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Potencializa sedação com benzodiazepínicos, álcool, antipsicóticos.'),
        _textoObs('• Efeitos aumentados com inibidores da CYP3A4.'),
        _textoObs('• Antagonismo com agonistas-antagonistas (nalbuphina, buprenorfina).'),
        _textoObs('• Aumenta risco de retenção urinária com anticolinérgicos.'),

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