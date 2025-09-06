import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoAguaDestilada {
  static const String nome = 'Água Destilada';
  static const String idBulario = 'agua_destilada';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/agua_destilada.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário da água destilada: $e');
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
      conteudo: _buildConteudoAguaDestilada(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoAguaDestilada(BuildContext context, double peso, bool isAdulto) {
    // Cálculos para solução pediátrica de manutenção
    final double volumeTotal = peso <= 10
        ? 100 * peso
        : peso <= 20
        ? 1000 + (peso - 10) * 50
        : 1500 + (peso - 20) * 20;

    final double sodio = peso * 3;
    final double potassio = peso * 2;
    final double glicose = peso * 5 * 1440 / 1000;

    final double nacl20_ml = sodio / 3.4;
    final double kcl19_ml = potassio / 2.5;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        
        // Informações gerais
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Veículo e solvente farmacêutico estéril'),
        _textoObs('• Diluente universal'),
        _textoObs('• Solução hipotônica'),
        _textoObs('• Isenta de sais, íons e microorganismos'),
        _textoObs('• Compatível com a maioria dos princípios ativos'),
        
        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('Frascos-ampola: 2 mL, 5 mL, 10 mL, 20 mL, 50 mL', 'uso injetável'),
        _linhaPreparo('Bolsas de irrigação: 250 mL, 500 mL, 1000 mL, 2000 mL', 'uso estéril'),
        _linhaPreparo('Água Destilada Estéril®, Água PPI®, Aqua Bidest®', 'marcas comerciais'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('Pronta para uso - não diluir', ''),
        _linhaPreparo('Usar seringa e agulha estéreis', ''),
        _linhaPreparo('Utilizar imediatamente após abertura', ''),
        _linhaPreparo('Técnica asséptica obrigatória', ''),

        // Usos e orientações
        const SizedBox(height: 16),
        const Text('Usos e Orientações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('Reconstituição de medicamentos IV', ''),
        _linhaPreparo('Irrigação estéril de feridas e cavidades', ''),
        _linhaPreparo('Lavagem de cateteres e sondas', ''),
        _linhaPreparo('Enxágue de instrumentos cirúrgicos', ''),
        _linhaPreparo('Proibido como expansor ou diluente direto em infusão contínua', ''),

        // Cálculo pediátrico (se aplicável)
        if (!isAdulto) ...[
          const SizedBox(height: 16),
          const Text('Cálculo – Solução Pediátrica de Manutenção', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          _linhaPreparo('Volume total (24h): ${volumeTotal.toStringAsFixed(0)} mL', ''),
          _linhaPreparo('Sódio (Na⁺): ${sodio.toStringAsFixed(0)} mEq/dia', ''),
          _linhaPreparo('Potássio (K⁺): ${potassio.toStringAsFixed(0)} mEq/dia', ''),
          _linhaPreparo('Glicose: ${glicose.toStringAsFixed(0)} g/dia', ''),
          _linhaPreparo(
            'Adição necessária:',
            '${nacl20_ml.toStringAsFixed(1)} mL de NaCl 20% + ${kcl19_ml.toStringAsFixed(1)} mL de KCl 19,1%',
          ),
        ],

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Usada para preparo de soluções intravenosas.'),
        _textoObs('• Nunca administrar isoladamente — risco de hemólise.'),
        _textoObs('• Adição de eletrólitos deve ser feita de forma controlada.'),
        _textoObs('• Monitorar volume, eletrólitos e status clínico do paciente.'),
        _textoObs('• Ideal para fármacos sensíveis à presença de eletrólitos.'),
        _textoObs('• Evitar uso com soluções hiperosmolares sem orientação técnica.'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Distribuição: entra rapidamente nos compartimentos intra e extracelular.'),
        _textoObs('• Excreção: renal (filtração glomerular da água livre).'),
        _textoObs('• Absorção: não aplicável por via parenteral.'),
        _textoObs('• Meia-vida: depende do estado hídrico e função renal do paciente.'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Infusão venosa direta isolada.'),
        _textoObs('• Hipotonicidade grave e risco de hemólise.'),
        _textoObs('• Uso intraocular prolongado sem controle de osmolaridade.'),
        _textoObs('• Grandes volumes por via IV sem prescrição específica.'),

        // Reações adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Comuns: irritação local leve em uso tópico repetido.'),
        _textoObs('• Raras: hemólise (uso IV inadvertido).'),
        _textoObs('• Reações inflamatórias se contaminada ou mal armazenada.'),
        _textoObs('• Hiponatremia dilucional em uso excessivo inadvertido por via IV.'),
        _textoObs('• Edema celular e convulsões em infusão venosa rápida (acidental).'),

        // Interações medicamentosas
        const SizedBox(height: 16),
        const Text('Interações Medicamentosas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Compatível com a maioria dos antibióticos, sedativos, antieméticos, vacinas.'),
        _textoObs('• Incompatível com soluções hiperosmolares ou alcalinas sem prescrição específica.'),
        _textoObs('• Atenção à estabilidade e tempo de uso após reconstituição dos fármacos.'),
        _textoObs('• Ausência de íons previne precipitações com sais de cálcio, magnésio ou bicarbonato.'),

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