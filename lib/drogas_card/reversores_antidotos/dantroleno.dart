import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoDantroleno {
  static const String nome = 'Dantroleno';
  static const String idBulario = 'dantroleno';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/dantroleno.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário do dantroleno: $e');
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
      conteudo: _buildConteudoDantroleno(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoDantroleno(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        
        // Informações gerais
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Relaxante muscular de ação periférica'),
        _textoObs('• Antídoto para hipertermia maligna'),
        _textoObs('• Inibe liberação de cálcio do retículo sarcoplasmático'),
        _textoObs('• Bloqueia interação actina-miosina'),
        _textoObs('• Ação seletiva no músculo esquelético'),
        
        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('Frasco 20mg + 60mL água estéril', 'Dantrium®, Revonto®'),
        _linhaPreparo('Frasco 250mg (Ryanodex®)', 'concentrado de reconstituição rápida'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('Reconstituir cada frasco com 60mL de água estéril', ''),
        _linhaPreparo('Agitar vigorosamente até dissolução total', ''),
        _linhaPreparo('Usar imediatamente após reconstituição', ''),
        _linhaPreparo('Concentração final: 0,33 mg/mL', ''),
        _linhaPreparo('Ryanodex®: reconstituir com 5mL para 50mg/mL', ''),

        // Indicações clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        _linhaIndicacaoDoseCalculada(
          titulo: 'Hipertermia maligna (ataque)',
          descricaoDose: '2,5 mg/kg IV bolus a cada 5 min até máx 10mg/kg',
          unidade: 'mg',
          dosePorKg: 2.5,
          doseMaxima: 10.0 * peso,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Hipertermia maligna (manutenção)',
          descricaoDose: '1 mg/kg IV a cada 6h ou infusão 0,25 mg/kg/h',
          unidade: 'mg',
          dosePorKgMinima: 0.25,
          dosePorKgMaxima: 1.0,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Síndrome neuroléptica maligna',
          descricaoDose: '1–2,5 mg/kg IV a cada 6h ou infusão titulada',
          unidade: 'mg',
          dosePorKgMinima: 1.0,
          dosePorKgMaxima: 2.5,
          peso: peso,
        ),

        // Cálculo da infusão
        const SizedBox(height: 16),
        const Text('Cálculo da Infusão', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Infusão contínua: 0,25 mg/kg/h'),
        _textoObs('• Concentração: 60mg/60mL água estéril (1mg/mL)'),
        _textoObs('• Infundir em bolus lento (1 mg/kg/min)'),

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Tratamento de hipertermia maligna.'),
        _textoObs('• Reduz liberação de cálcio do retículo sarcoplasmático.'),
        _textoObs('• Reconstituir apenas com água estéril (não usar SF).'),
        _textoObs('• Manter suporte ventilatório e monitoração intensiva.'),
        _textoObs('• Ter reserva de 36 frascos por paciente adulto.'),
        _textoObs('• Monitorar temperatura, sinais vitais e gasometria.'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Início de ação: 1–2 minutos (IV).'),
        _textoObs('• Pico de efeito: 5–10 minutos.'),
        _textoObs('• Duração clínica: 4–8 horas.'),
        _textoObs('• Meia-vida: 8,7 ± 1,7 horas (em adultos).'),
        _textoObs('• Volume de distribuição: 0,57 L/kg.'),
        _textoObs('• Ligação às proteínas plasmáticas: 74–88%.'),
        _textoObs('• Metabolização: hepática (CYP).'),
        _textoObs('• Excreção: renal (como metabólitos hidroxilados e oxidados).'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hepatopatia ativa ou história de hepatotoxicidade relacionada.'),
        _textoObs('• Hipersensibilidade conhecida ao fármaco.'),
        _textoObs('• Bloqueio cardíaco avançado (com cautela em uso prolongado).'),
        _textoObs('• Evitar uso crônico em pacientes com hepatopatia preexistente.'),

        // Reações adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Muito comuns: fraqueza muscular, sonolência, náusea, vômito.'),
        _textoObs('• Comuns: tontura, cefaleia, visão turva, diplopia, diarreia, dor no local da infusão.'),
        _textoObs('• Incomuns: hepatotoxicidade, reações alérgicas cutâneas, hipotensão, taquicardia.'),
        _textoObs('• Raras: insuficiência hepática fulminante, convulsões.'),

        // Interações medicamentosas
        const SizedBox(height: 16),
        const Text('Interações Medicamentosas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Bloqueadores neuromusculares (potencializa efeito).'),
        _textoObs('• Bloqueadores de canais de cálcio (verapamil) — risco de hipercalemia.'),
        _textoObs('• Depressores do SNC (sedação excessiva).'),
        _textoObs('• Estrogênios: aumento do risco de hepatotoxicidade.'),

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