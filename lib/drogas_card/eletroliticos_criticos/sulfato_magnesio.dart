import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoSulfatoMagnesio {
  static const String nome = 'Sulfato de Magnésio';
  static const String idBulario = 'sulfato_magnesio';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/sulfato_magnesio.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário do sulfato de magnésio: $e');
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
      conteudo: _buildConteudoSulfatoMagnesio(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoSulfatoMagnesio(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Sulfato de Magnésio®, Magnesium Sulfate®'),
        _linhaInfo('Classificação', 'Eletrolítico crítico / Anticonvulsivante'),
        _linhaInfo('Mecanismo', 'Estabilização de membranas celulares'),
        _linhaInfo('Concentração', '10% (1g/10mL = 8 mEq/10mL)'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Ampola 10%', '1g/10mL = 8 mEq/10mL'),
        _linhaInfo('Ampola 20%', '2g/10mL = 16 mEq/10mL'),
        _linhaInfo('Concentração', '100mg/mL (10%) ou 200mg/mL (20%)'),
        _linhaInfo('Osmolaridade', '800 mOsm/L (hipertônica)'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Via IV', 'Direta (10–20 min) ou diluído'),
        _linhaInfo('Diluição', '4g em 250mL SG5% (16mg/mL)'),
        _linhaInfo('Infusão contínua', 'Com bomba de infusão'),
        _linhaInfo('Acesso', 'Pode ser usado em periférico'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        _linhaIndicacaoDoseCalculada(
          titulo: 'Eclâmpsia / Pré-eclâmpsia grave',
          descricaoDose: 'Ataque: 4–6g IV lenta em 20 min → Manutenção: 1–2g/h',
          unidade: 'mg',
          doseMaxima: 6000,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Torsades de Pointes / TV polimórfica',
          descricaoDose: '2g IV lenta em 5–15 min',
          unidade: 'mg',
          doseMaxima: 2000,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Hipomagnesemia sintomática',
          descricaoDose: '1–2g IV em 30 min, repetir se necessário',
          unidade: 'mg',
          doseMaxima: 2000,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Asma grave refratária',
          descricaoDose: '2g IV em 20 min (off-label)',
          unidade: 'mg',
          doseMaxima: 2000,
          peso: peso,
        ),

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Corrige hipomagnesemia e estabiliza membranas celulares'),
        _textoObs('• Potente anticonvulsivante em eclâmpsia'),
        _textoObs('• Exclusivamente renal — monitorar função renal'),
        _textoObs('• Monitorar reflexos, diurese e FR em uso contínuo'),
        _textoObs('• Doses altas → risco de bloqueio neuromuscular e parada respiratória'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Início de ação', 'Imediato (bolus IV)'),
        _linhaInfo('Pico de efeito', '30–60 minutos'),
        _linhaInfo('Duração', '4–6 horas'),
        _linhaInfo('Distribuição', 'Principalmente intracelular'),
        _linhaInfo('Eliminação', 'Renal (100%)'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade ao sulfato de magnésio'),
        _textoObs('• Hipermagnesemia'),
        _textoObs('• Insuficiência renal grave'),
        _textoObs('• Bloqueio cardíaco'),

        // Reações Adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('Comuns (1–10%): Rubor, sensação de calor'),
        _textoObs('Incomuns (0,1–1%): Bradicardia, hipotensão'),
        _textoObs('Raras (<0,1%): Bloqueio neuromuscular, parada respiratória'),

        // Interações
        const SizedBox(height: 16),
        const Text('Interações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Potencializa bloqueadores neuromusculares'),
        _textoObs('• Interfere com absorção de tetraciclinas'),
        _textoObs('• Potencializa digitálicos'),

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