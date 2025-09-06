import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoProtamina {
  static const String nome = 'Protamina';
  static const String idBulario = 'protamina';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/protamina.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário da protamina: $e');
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
      conteudo: _buildConteudoProtamina(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoProtamina(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        
        // Informações gerais
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Antagonista da heparina'),
        _textoObs('• Agente neutralizante de anticoagulante'),
        _textoObs('• Proteína básica de baixo peso molecular'),
        _textoObs('• Liga-se diretamente à heparina'),
        _textoObs('• Forma complexo estável inativo'),
        
        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('Ampola 10mg/mL (5mL = 50mg)', 'Protamina sulfato'),
        _linhaPreparo('Ampolas de 50 mg/5 mL', 'uso IV'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('Diluir em 50–100mL SF 0,9%', ''),
        _linhaPreparo('Administração IV lenta — máx 5mg/min', ''),
        _linhaPreparo('Pronto para uso', ''),
        _linhaPreparo('Mínimo 10 minutos de infusão', ''),

        // Indicações clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        _linhaIndicacaoDoseCalculada(
          titulo: 'Reversão de heparina não fracionada (HNF)',
          descricaoDose: '1mg neutraliza ~100 UI de HNF administrada nos últimos 30–60 min',
          unidade: 'mg',
          dosePorKgMinima: 0.5,
          dosePorKgMaxima: 1.0,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Reversão parcial de HBPM',
          descricaoDose: '1mg neutraliza ~1mg de enoxaparina (se <8h da dose)',
          unidade: 'mg',
          dosePorKgMinima: 0.5,
          dosePorKgMaxima: 1.0,
          peso: peso,
        ),

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Administrar lentamente (≤5mg/min) para evitar hipotensão e reações anafilactoides.'),
        _textoObs('• Risco de efeito anticoagulante paradoxal se usado em excesso.'),
        _textoObs('• Cautela em pacientes alérgicos a peixe, vasectomizados e usuários de NPH.'),
        _textoObs('• Monitorizar pressão arterial, frequência cardíaca e saturação.'),
        _textoObs('• Ter disponível suporte avançado de vida.'),
        _textoObs('• Observar rigorosamente a dose e o tempo desde a administração da heparina.'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Início de ação: imediato (≤5 minutos).'),
        _textoObs('• Pico de efeito: 5 minutos.'),
        _textoObs('• Duração clínica: 2 horas.'),
        _textoObs('• Meia-vida: 7 minutos (fase inicial); 23 minutos (eliminação terminal).'),
        _textoObs('• Volume de distribuição: 0,2–0,4 L/kg.'),
        _textoObs('• Ligação às proteínas plasmáticas: forma complexo com heparina.'),
        _textoObs('• Metabolização: hepática (parcial).'),
        _textoObs('• Excreção: renal (como complexos inativos ou protamina livre).'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade à protamina ou a peixes.'),
        _textoObs('• Histórico de reação anafilática à protamina.'),
        _textoObs('• Uso prévio de protamina ou NPH/insulina protamina.'),
        _textoObs('• Risco de reação alérgica cruzada.'),

        // Reações adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Comuns: hipotensão, bradicardia, sensação de calor, rubor facial, náusea, vômito, dor no local da injeção.'),
        _textoObs('• Incomuns: reações anafilactoides não imunológicas, broncoespasmo, dispneia.'),
        _textoObs('• Raras: anafilaxia verdadeira, colapso cardiovascular, hipertensão pulmonar aguda, choque e parada cardíaca.'),

        // Interações medicamentosas
        const SizedBox(height: 16),
        const Text('Interações Medicamentosas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Aumento do risco de hemorragia se administrado isoladamente em excesso.'),
        _textoObs('• Pode interagir com anticoagulantes orais e agentes antiplaquetários.'),
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