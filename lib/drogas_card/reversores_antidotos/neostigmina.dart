import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoNeostigmina {
  static const String nome = 'Neostigmina';
  static const String idBulario = 'neostigmina';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/neostigmina.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário da neostigmina: $e');
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
      conteudo: _buildConteudoNeostigmina(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoNeostigmina(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        
        // Informações gerais
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Anticolinesterásico'),
        _textoObs('• Inibidor da acetilcolinesterase'),
        _textoObs('• Agente reversor de bloqueadores neuromusculares não despolarizantes'),
        _textoObs('• Inibe competitivamente a acetilcolinesterase'),
        _textoObs('• Aumenta a concentração de acetilcolina'),
        
        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('Ampola 0,5mg/mL (1mL)', 'Prostigmina®, genéricos'),
        _linhaPreparo('Ampola 1mg/mL (1mL)', 'uso IV ou IM'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('Diluir em 10–20mL SF 0,9% se necessário', ''),
        _linhaPreparo('Sempre associar atropina (10–20 mcg/kg) ou glicopirrolato', ''),
        _linhaPreparo('Administração IV lenta (60 segundos)', ''),
        _linhaPreparo('Pronto para uso', ''),

        // Indicações clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        _linhaIndicacaoDoseCalculada(
          titulo: 'Reversão de bloqueio neuromuscular',
          descricaoDose: '0,04–0,07 mg/kg IV lenta (máx 5mg)',
          unidade: 'mg',
          dosePorKgMinima: 0.04,
          dosePorKgMaxima: 0.07,
          doseMaxima: 5.0,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Íleo paralítico / retenção urinária (off-label)',
          descricaoDose: '0,5–2,5mg IM ou SC a cada 4–6h',
          unidade: 'mg',
          doseMaxima: 2.5,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Miastenia gravis',
          descricaoDose: '0,5–2mg VO a cada 4–6h',
          unidade: 'mg',
          doseMaxima: 2.0,
          peso: peso,
        ),

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Sempre associar atropina ou glicopirrolato para evitar bradicardia.'),
        _textoObs('• Início em 1–3 min, pico em 7–10 min, duração 30–60 min.'),
        _textoObs('• Contraindicado em obstrução mecânica intestinal ou urinária.'),
        _textoObs('• Monitorizar TOF (Train-of-Four) antes da administração.'),
        _textoObs('• Administrar apenas com retorno de pelo menos 2 respostas no TOF.'),
        _textoObs('• Ter atropina disponível à cabeceira para emergências.'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Início de ação: 1–3 minutos (IV), 10–30 minutos (IM).'),
        _textoObs('• Pico de efeito: 7–10 minutos (IV).'),
        _textoObs('• Duração clínica: 20–30 minutos.'),
        _textoObs('• Meia-vida: 50–90 minutos.'),
        _textoObs('• Volume de distribuição: 0,3–0,6 L/kg.'),
        _textoObs('• Ligação às proteínas plasmáticas: baixa (<30%).'),
        _textoObs('• Metabolização: hepática parcial, por hidrólise enzimática.'),
        _textoObs('• Excreção: predominantemente renal (50–75% como fármaco inalterado).'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade à neostigmina.'),
        _textoObs('• Obstrução mecânica do trato gastrointestinal ou urinário.'),
        _textoObs('• Bradicardia severa ou bloqueio AV avançado não tratado.'),
        _textoObs('• Asma brônquica não controlada.'),
        _textoObs('• Risco de broncoespasmo grave.'),

        // Reações adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Comuns: bradicardia, hipersalivação, náusea, vômito, broncoespasmo, aumento do peristaltismo, rubor, sudorese.'),
        _textoObs('• Incomuns: hipotensão, arritmias cardíacas, fadiga muscular transitória, visão turva.'),
        _textoObs('• Raras: crise colinérgica, parada cardíaca, reações anafiláticas.'),

        // Interações medicamentosas
        const SizedBox(height: 16),
        const Text('Interações Medicamentosas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Potencialização dos efeitos colinérgicos com betabloqueadores e bloqueadores de canais de cálcio.'),
        _textoObs('• Antagoniza parcialmente os efeitos de agentes antimuscarínicos.'),
        _textoObs('• Pode interferir na eficácia de anestésicos inalatórios.'),
        _textoObs('• Sinergismo neuromuscular com antibióticos aminoglicosídeos.'),

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