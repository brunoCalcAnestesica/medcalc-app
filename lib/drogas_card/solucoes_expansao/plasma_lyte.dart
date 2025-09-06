import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoPlasmaLyte {
  static const String nome = 'Plasma-Lyte';
  static const String idBulario = 'plasmalyte';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/plasmalyte.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário do Plasma-Lyte: $e');
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
      conteudo: _buildConteudoPlasmaLyte(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoPlasmaLyte(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        
        // Informações gerais
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Solução cristaloide balanceada isotônica'),
        _textoObs('• Repositor volêmico e eletrolítico'),
        _textoObs('• Tamponada com acetato e gluconato'),
        _textoObs('• pH ~7,4 | Osmolaridade: 294 mOsm/L'),
        _textoObs('• Mais fisiológica que SF 0,9%'),
        
        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('Bolsas 250 mL, 500 mL, 1000 mL', 'PVC e livres de DEHP'),
        _linhaPreparo('Plasma-Lyte 148®, Plasma-Lyte A®', 'marcas comerciais'),
        _linhaPreparo('Com e sem glicose 5%', 'Plasma-Lyte D disponível'),

        // Composição
        const SizedBox(height: 16),
        const Text('Composição por Litro', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('Na⁺: 140 mEq | K⁺: 5 mEq | Mg²⁺: 3 mEq', ''),
        _linhaPreparo('Cl⁻: 98 mEq | Acetato: 27 mEq | Gluconato: 23 mEq', ''),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('Pronta para uso - não diluir', ''),
        _linhaPreparo('Técnica asséptica na conexão', ''),
        _linhaPreparo('Via periférica ou central', ''),
        _linhaPreparo('Compatível com bombas de infusão', ''),

        // Indicações clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Reposição volêmica em desidratação',
          descricaoDose: '20–30 mL/kg em bolus rápido (500–1000 mL em adultos)',
          unidade: 'mL',
          dosePorKgMinima: 20,
          dosePorKgMaxima: 30,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Manutenção venosa em pacientes críticos',
          descricaoDose: '1–2 mL/kg/h em infusão contínua (ajustar conforme balanço)',
          unidade: 'mL/kg/h',
          dosePorKgMinima: 1,
          dosePorKgMaxima: 2,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Hidratação geral e reposição eletrolítica',
          descricaoDose: '25–40 mL/kg/dia (uso semelhante ao SF ou RL)',
          unidade: 'mL',
          dosePorKgMinima: 25,
          dosePorKgMaxima: 40,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Expansão volêmica em choque',
          descricaoDose: '500–1000 mL em bolus conforme status hemodinâmico',
          unidade: 'mL',
          doseMaxima: 1000,
          peso: peso,
        ),

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Solução isotônica balanceada — composição próxima ao plasma.'),
        _textoObs('• Menor risco de acidose hiperclorêmica comparado ao SF 0,9%.'),
        _textoObs('• Ideal para pacientes com distúrbios ácido-base ou necessidade de grande volume.'),
        _textoObs('• Pode ser utilizada em pediatria, cirurgia e UTI.'),
        _textoObs('• Contraindicado em hiperpotassemia ou hipermagnesemia graves.'),
        _textoObs('• Associado a menor incidência de lesão renal aguda em pacientes críticos.'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Distribuição: compartimento extracelular (plasma e interstício).'),
        _textoObs('• Metabolismo: acetato e gluconato convertidos em bicarbonato.'),
        _textoObs('• Excreção: renal (excesso de eletrólitos e volume).'),
        _textoObs('• Meia-vida efetiva: minutos a horas, dependente da volemia.'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipercalemia conhecida (>5,5 mEq/L).'),
        _textoObs('• Insuficiência renal grave sem terapia dialítica.'),
        _textoObs('• Alcalose metabólica ou hipermagnesemia significativa.'),
        _textoObs('• Hipervolêmicos sem controle (ICC, edema pulmonar).'),

        // Reações adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Comuns: edema periférico, irritação local.'),
        _textoObs('• Incomuns: hipernatremia leve, hipermagnesemia transitória.'),
        _textoObs('• Raras: reações alérgicas, extravasamento com dor local.'),
        _textoObs('• Hipercalemia em pacientes com disfunção renal.'),

        // Interações medicamentosas
        const SizedBox(height: 16),
        const Text('Interações Medicamentosas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Compatível com diversos antibióticos e sedativos.'),
        _textoObs('• Incompatível com fosfato, cálcio concentrado e bicarbonato.'),
        _textoObs('• Evitar associação com eletrólitos concentrados sem diluição.'),
        _textoObs('• Compatível com aminoglicosídeos, betalactâmicos e sedativos.'),

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