import 'package:flutter/material.dart';
import 'shared_data.dart';

class CardMedicamentoDinamico extends StatefulWidget {
  final Map<String, dynamic> medicamento;

  const CardMedicamentoDinamico({super.key, required this.medicamento});

  @override
  State<CardMedicamentoDinamico> createState() => _CardMedicamentoDinamicoState();
}

class _CardMedicamentoDinamicoState extends State<CardMedicamentoDinamico> {
  String? diluicaoInfusaoSelecionada;
  double doseSelecionada = 0.1;

  @override
  void initState() {
    super.initState();
    final diluicoesInfusao = _todasDiluicoesInfusao();
    if (diluicoesInfusao.isNotEmpty) {
      diluicaoInfusaoSelecionada = diluicoesInfusao.keys.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    final peso = SharedData.peso ?? 70;
    final idade = SharedData.idade ?? 30;
    final isAdulto = idade >= 18;

    final grupo = isAdulto ? 'adulto' : 'pediatrico';
    final indicacoes = widget.medicamento['indicacoes'][grupo] ?? [];
    final preparo = widget.medicamento['preparo'] ?? {};
    final observacoes = widget.medicamento['observacoes'] ?? [];
    final apresentacao = widget.medicamento['apresentacao'] ?? '-';

    final diluicoesInfusao = _todasDiluicoesInfusao();
    final textoDiluicaoInfusao = diluicoesInfusao[diluicaoInfusaoSelecionada] ?? '';
    final concentracaoInfusao = _extrairConcentracao(textoDiluicaoInfusao);

    final unidadePadrao = indicacoes.isNotEmpty ? indicacoes[0]['unidade'] : 'mcg/kg/min';
    final resultadoMlH = _calcularMlH(doseSelecionada, peso, unidadePadrao, concentracaoInfusao);

    return Card(
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.medicamento['nome'],
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const Icon(Icons.info_outline, size: 20)
              ],
            ),

            const Divider(height: 24),
            const Text('Apresentação:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            Text('- $apresentacao', style: const TextStyle(fontSize: 14)),

            const SizedBox(height: 16),


            const Text('Preparo:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 8),

            Builder(
              builder: (_) {
                final Map<String, dynamic> preparo = (widget.medicamento['preparo'] ?? {}).cast<String, dynamic>();

                final bolusList = preparo.entries
                    .where((e) => e.key.toLowerCase().startsWith('bolus'))
                    .map((e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(e.value, style: const TextStyle(fontSize: 13)),
                ))
                    .toList();

                final infusaoList = preparo.entries
                    .where((e) => e.key.toLowerCase().startsWith('infusao'))
                    .map((e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(e.value, style: const TextStyle(fontSize: 13)),
                ))
                    .toList();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (bolusList.isNotEmpty) ...[
                      const Text('Bolus:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                      ...bolusList,
                      const SizedBox(height: 8),
                    ],
                    if (infusaoList.isNotEmpty) ...[
                      const Text('Infusão:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                      ...infusaoList,
                    ]
                  ],
                );
              },
            ),

            const SizedBox(height: 16),
            Text('Indicações e Doses (${isAdulto ? 'Adulto' : 'Pediátrico'}):',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            ...indicacoes.map<Widget>((e) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Text(
                        e['condicao'] ?? '-',
                        style: const TextStyle(fontSize: 13),
                      )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('${e['dose']} ${e['unidade']}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                      if (e['via'] != null) Text('Via: ${_formatarVia(e['via'])}', style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic))
                    ],
                  )
                ],
              ),
            )),

            const SizedBox(height: 16),
            const Text('Cálculo da Infusão:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            DropdownButton<String>(
              value: diluicaoInfusaoSelecionada,
              isExpanded: true,
              onChanged: (val) => setState(() => diluicaoInfusaoSelecionada = val),
              items: diluicoesInfusao.entries.map<DropdownMenuItem<String>>((e) {
                return DropdownMenuItem<String>(value: e.key, child: Text(e.value, style: const TextStyle(fontSize: 13)));
              }).toList(),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${doseSelecionada.toStringAsFixed(2)} $unidadePadrao', style: const TextStyle(fontSize: 13)),
                Text('${resultadoMlH.toStringAsFixed(2)} mL/h',
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.indigo))
              ],
            ),
            Slider(
              value: doseSelecionada,
              min: 0.01,
              max: 1.0,
              divisions: 99,
              label: doseSelecionada.toStringAsFixed(2),
              onChanged: (val) => setState(() => doseSelecionada = val),
            ),

            if (observacoes.isNotEmpty) ...[
              const SizedBox(height: 12),
              const Text('Observações:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              ...observacoes.map<Widget>((o) => Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('\u2022 ', style: TextStyle(fontSize: 13)),
                  Expanded(child: Text(o, style: const TextStyle(fontSize: 13)))
                ],
              ))
            ]
          ],
        ),
      ),
    );
  }

  Map<String, String> _todasDiluicoesInfusao() {
    final mapa = widget.medicamento['diluicoes']?['infusao'] ?? {};
    return Map<String, String>.from(mapa);
  }

  double? _extrairConcentracao(String texto) {
    final regex = RegExp(r'(\d+(\.\d+)?)\s*mcg\s*/?\s*mL', caseSensitive: false);
    final match = regex.firstMatch(texto);
    if (match != null) {
      return double.tryParse(match.group(1)!);
    }

    // fallback: tenta capturar número isolado se não houver 'mcg/mL'
    final fallback = RegExp(r'(\\d+(\\.\\d+)?)');
    final fallbackMatch = fallback.firstMatch(texto);
    if (fallbackMatch != null) {
      return double.tryParse(fallbackMatch.group(1)!);
    }

    return null;
  }
  double _calcularMlH(double dose, double peso, String unidade, double? concentracao) {
    if (concentracao == null || concentracao == 0) return 0.0;

    final unidadeNormalizada = unidade.toLowerCase().trim();

    switch (unidadeNormalizada) {
      case 'mcg/kg/min':
        return (dose * peso * 60) / concentracao;
      case 'mcg/kg/h':
        return (dose * peso) / concentracao;
      case 'mg/kg/min':
        return (dose * 1000 * peso * 60) / concentracao;
      case 'mg/kg/h':
        return (dose * 1000 * peso) / concentracao;
      default:
        return 0.0;
    }
  }

  String _formatarVia(String via) {
    final v = via.toLowerCase().trim();
    switch (v) {
      case 'ev':
      case 'endovenosa':
        return 'EV';
      case 'im':
      case 'intramuscular':
        return 'IM';
      case 'sc':
      case 'subcutanea':
        return 'SC';
      case 'io':
      case 'intraosseous':
        return 'IO';
      case 'tot':
      case 'tubo orotraqueal':
        return 'TOT';
      case 'nbz':
      case 'nebulização':
        return 'NBZ';
      default:
        return via.toUpperCase();
    }
  }

  String _capitalize(String texto) {
    if (texto.isEmpty) return texto;
    return texto[0].toUpperCase() + texto.substring(1);
  }
}