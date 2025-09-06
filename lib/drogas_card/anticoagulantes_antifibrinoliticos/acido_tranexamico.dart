import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoAcidoTranexamico {
  static const String nome = 'Ácido Tranexâmico';
  static const String idBulario = 'acido_tranexamico';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/acido_tranexamico.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário do ácido tranexâmico: $e');
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
      conteudo: _buildConteudoAcidoTranexamico(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoAcidoTranexamico(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Transamin®, Exacyl®, Ácido Tranexâmico®'),
        _linhaInfo('Classificação', 'Antifibrinolítico'),
        _linhaInfo('Mecanismo', 'Inibidor da ativação da plasmina'),
        _linhaInfo('Duração', '6-8 horas'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Ampola 250mg/2,5mL', '100mg/mL'),
        _linhaInfo('Ampola 500mg/5mL', '100mg/mL'),
        _linhaInfo('Forma', 'Solução injetável'),
        _linhaInfo('Via', 'IV, VO'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Diluição', '100mL SF 0,9%'),
        _linhaInfo('Infusão', '10-20 minutos'),
        _linhaInfo('Cuidado', 'Não administrar em bolus rápido'),
        _linhaInfo('Estabilidade', '24h após diluição'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        if (isAdulto) ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Hemorragia aguda (trauma, HPP, epistaxe)',
            descricaoDose: '1 g IV em 10 min → repetir 1 g após 8h se necessário',
            unidade: 'g',
            dosePorKg: 1.0 / peso,
            doseMaxima: 2.0,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Cirurgia com risco de sangramento',
            descricaoDose: '10–15 mg/kg IV antes da incisão → repetir após 3–6h',
            unidade: 'mg',
            dosePorKgMinima: 10,
            dosePorKgMaxima: 15,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Menorragia (VO)',
            descricaoDose: '500–1000 mg VO 2–3x/dia por até 5 dias durante a menstruação',
            unidade: 'mg',
            dosePorKgMaxima: 500 / peso,
            doseMaxima: 1000,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Hemorragia pós-parto',
            descricaoDose: '1 g IV em 10 min → repetir 1 g após 8h se necessário',
            unidade: 'g',
            dosePorKg: 1.0 / peso,
            doseMaxima: 2.0,
            peso: peso,
          ),
        ] else ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Hemorragia pediátrica',
            descricaoDose: '10–15 mg/kg IV em 10 min → repetir após 8h se necessário',
            unidade: 'mg',
            dosePorKgMinima: 10,
            dosePorKgMaxima: 15,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Cirurgia pediátrica com risco de sangramento',
            descricaoDose: '10–15 mg/kg IV antes da incisão → repetir após 3–6h',
            unidade: 'mg',
            dosePorKgMinima: 10,
            dosePorKgMaxima: 15,
            peso: peso,
          ),
        ],

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Antifibrinolítico que inibe a ativação da plasmina'),
        _textoObs('• Reduz sangramento perioperatório e em traumas'),
        _textoObs('• Cuidado em pacientes com histórico de trombose ou convulsões'),
        _textoObs('• Ajustar dose na insuficiência renal grave'),
        _textoObs('• Contraindicado em hemorragia subaracnóidea'),
        _textoObs('• Monitorar função renal em uso prolongado'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Início de ação', 'Imediato (IV)'),
        _linhaInfo('Pico de efeito', '1–2 horas'),
        _linhaInfo('Duração', '6–8 horas'),
        _linhaInfo('Metabolização', 'Renal (90%)'),
        _linhaInfo('Meia-vida', '2–3 horas'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade ao ácido tranexâmico'),
        _textoObs('• Hemorragia subaracnóidea'),
        _textoObs('• Trombose ativa ou história de trombose'),
        _textoObs('• Insuficiência renal grave (ClCr <30 mL/min)'),
        _textoObs('• Distúrbios da coagulação congênitos'),

        // Reações Adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('Comuns (1–10%): Náusea, vômitos, diarreia'),
        _textoObs('Incomuns (0,1–1%): Trombose, convulsões'),
        _textoObs('Raras (<0,1%): Reações alérgicas, insuficiência renal'),

        // Interações
        const SizedBox(height: 16),
        const Text('Interações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Potencializado por outros antifibrinolíticos'),
        _textoObs('• Pode aumentar risco de trombose com anticoagulantes'),
        _textoObs('• Sem interações significativas com outros medicamentos'),
        _textoObs('• Cuidado com uso concomitante de estrogênios'),

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