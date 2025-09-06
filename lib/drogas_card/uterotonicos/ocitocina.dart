import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoOcitocina {
  static const String nome = 'Ocitocina';
  static const String idBulario = 'ocitocina';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/ocitocina.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário da ocitocina: $e');
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
      conteudo: _buildConteudoOcitocina(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoOcitocina(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        
        // Informações gerais
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hormônio uterotônico natural'),
        _textoObs('• Agonista seletivo dos receptores de ocitocina'),
        _textoObs('• Primeira escolha na profilaxia e tratamento da HPP'),
        
        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('Ampola 5 UI/mL', 'Syntocinon®, Ocitoplus®'),
        _linhaPreparo('Ampola 10 UI/mL', 'Ocitovyl®, Ocilon®'),
        _linhaPreparo('Frasco 50 UI/10 mL', 'uso hospitalar para infusão'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('10 UI em 500 mL SF → 20 mUI/mL', ''),
        _linhaPreparo('20 UI em 1000 mL SF → 20 mUI/mL', ''),
        _linhaPreparo('Iniciar com 2–4 mUI/min, aumentar conforme resposta', ''),
        _linhaPreparo('5 UI diluídos em 10 mL SF para bolus IV lento', ''),

        // Indicações clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Indução/condução do trabalho de parto',
          descricaoDose: 'Iniciar com 2–4 mUI/min EV, aumentar até máx 20–40 mUI/min',
          unidade: 'mUI/min',
          dosePorKgMinima: 2,
          dosePorKgMaxima: 40,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Prevenção de hemorragia pós-parto (profilaxia)',
          descricaoDose: '5–10 UI IM ou IV lenta após saída da placenta',
          unidade: 'UI',
          doseMaxima: 10,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Tratamento de atonia uterina / HPP',
          descricaoDose: '10–40 UI em 500–1000mL SF em bomba contínua',
          unidade: 'UI',
          doseMaxima: 40,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Facilitação da dequitação placentária',
          descricaoDose: '5 UI IV lenta após parto',
          unidade: 'UI',
          doseMaxima: 5,
          peso: peso,
        ),

        // Cálculo de Infusão
        const SizedBox(height: 16),
        const Text('Cálculo de Infusão', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        ConversaoInfusaoSlider(
          peso: peso,
          opcoesConcentracoes: {
            '10 UI/500mL (20 mUI/mL)': 20,
            '20 UI/1000mL (20 mUI/mL)': 20,
          },
          unidade: 'mUI/min',
          doseMin: 2,
          doseMax: 40,
        ),

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hormônio natural com potente ação uterotônica.'),
        _textoObs('• Primeira escolha na profilaxia e tratamento da hemorragia pós-parto.'),
        _textoObs('• Pode causar hipotensão, náuseas, vômitos e taquicardia.'),
        _textoObs('• Requer monitoramento uterino e fetal contínuo durante infusão.'),
        _textoObs('• Risco de intoxicação hídrica em infusões prolongadas ou altas doses.'),
        _textoObs('• Nunca administrar IV em bolus rápido (risco de hipotensão severa).'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Início de ação: 1–2 minutos IV, 3–5 minutos IM.'),
        _textoObs('• Duração do efeito: 20 minutos IV, 30–60 minutos IM.'),
        _textoObs('• Meia-vida plasmática: 1–6 minutos.'),
        _textoObs('• Metabolização hepática e renal por oxitocinases.'),
        _textoObs('• Excreção urinária na forma de metabólitos inativos.'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Desproporção céfalo-pélvica.'),
        _textoObs('• Apresentações anômalas incompatíveis com parto vaginal.'),
        _textoObs('• Prolapso de cordão umbilical.'),
        _textoObs('• Placenta prévia.'),
        _textoObs('• Descolamento prematuro de placenta.'),
        _textoObs('• Ruptura uterina iminente ou prévia.'),
        _textoObs('• Hipersensibilidade à ocitocina.'),

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
        descricaoDose.contains('mUI/min') ||
        descricaoDose.contains('infusão') ||
        descricaoDose.contains('bomba contínua');

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
                'Dose calculada: ${doseCalculada.toStringAsFixed(2)} $unidade',
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
                'Dose calculada: ${doseCalculadaMin.toStringAsFixed(2)}–${doseCalculadaMax.toStringAsFixed(2)} $unidade',
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