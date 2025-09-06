import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoEmulsaoLipidica {
  static const String nome = 'Emulsão Lipídica';
  static const String idBulario = 'emulsao_lipidica';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/emulsao_lipidica.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário da emulsão lipídica: $e');
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
      conteudo: _buildConteudoEmulsaoLipidica(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoEmulsaoLipidica(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        
        // Informações gerais
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Suporte nutricional parenteral'),
        _textoObs('• Solução lipídica isotônica'),
        _textoObs('• Agente hepatoprotetor e energético'),
        _textoObs('• Fornece 9 kcal/g de gordura'),
        _textoObs('• Antídoto para toxicidade por anestésicos locais'),
        
        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('Frascos 100 mL, 250 mL, 500 mL, 1000 mL', ''),
        _linhaPreparo('Concentrações: 10%, 20%, 30%', ''),
        _linhaPreparo('Intralipid®, Lipofundin®, SMOFlipid®', 'marcas comerciais'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('Pronta para uso - misturar levemente', ''),
        _linhaPreparo('Via intravenosa exclusiva', ''),
        _linhaPreparo('Infusão contínua lenta por bomba', ''),
        _linhaPreparo('Usar filtro de 1,2 μm quando necessário', ''),

        // Indicações clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Toxicidade sistêmica por anestésico local (LAST)',
          descricaoDose: 'Bolus 1,5 mL/kg em 1 min → infusão 0,25–0,5 mL/kg/min por 30–60 min',
          unidade: 'mL',
          dosePorKgMinima: 1.5,
          dosePorKgMaxima: 1.5,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Nutrição parenteral (adulto)',
          descricaoDose: '1–2 g/kg/dia em infusão contínua (máximo 3 g/kg/dia)',
          unidade: 'g',
          dosePorKgMinima: 1.0,
          dosePorKgMaxima: 2.0,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Nutrição parenteral (pediátrica)',
          descricaoDose: '0,5–1 g/kg/dia inicial, titular até 3 g/kg/dia',
          unidade: 'g',
          dosePorKgMinima: 0.5,
          dosePorKgMaxima: 1.0,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Suporte calórico em pacientes críticos',
          descricaoDose: '1–2 g/kg/dia conforme tolerância metabólica',
          unidade: 'g',
          dosePorKgMinima: 1.0,
          dosePorKgMaxima: 2.0,
          peso: peso,
        ),

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Antídoto eficaz para intoxicação por anestésicos locais lipofílicos.'),
        _textoObs('• Atua sequestrando o anestésico na corrente sanguínea ("lipid sink").'),
        _textoObs('• Uso hospitalar, preferencialmente em UTI ou centro cirúrgico.'),
        _textoObs('• Na nutrição parenteral, fornece ácidos graxos essenciais e calorias.'),
        _textoObs('• Monitorar triglicérides, função hepática e sinais de sobrecarga lipídica.'),
        _textoObs('• Associado a menor incidência de lesão renal aguda em pacientes críticos.'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Início de ação: imediato como suporte calórico.'),
        _textoObs('• Metabolização: hepática (ácidos graxos) e periférica (músculo, tecido adiposo).'),
        _textoObs('• Meia-vida dos quilomícrons artificiais: 30–90 min.'),
        _textoObs('• Excreção: via respiratória (CO₂), renal (glicerol) e hepática (ácidos biliares).'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade a ovos, soja, peixe (dependendo da fórmula).'),
        _textoObs('• Dislipidemia grave não controlada (triglicérides >400 mg/dL).'),
        _textoObs('• Insuficiência hepática grave com colestase ativa não compensada.'),
        _textoObs('• Instabilidade hemodinâmica refratária (exceto uso em emergência anestésica).'),

        // Reações adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Comuns: hipertrigliceridemia, icterícia leve, náuseas.'),
        _textoObs('• Incomuns: hiperbilirrubinemia, coagulopatia transitória, elevação de transaminases.'),
        _textoObs('• Raras: síndrome de sobrecarga lipídica (febre, leucocitose, trombocitopenia).'),
        _textoObs('• Reações anafiláticas (excepcional), pancreatite (hipertrigliceridemia grave).'),

        // Interações medicamentosas
        const SizedBox(height: 16),
        const Text('Interações Medicamentosas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Pode interferir na absorção de medicamentos lipofílicos (propofol, amiodarona).'),
        _textoObs('• Reduz eficácia de drogas hidrossolúveis se usada em grande volume concomitante.'),
        _textoObs('• Incompatível com soluções contendo eletrólitos divalentes em alta concentração.'),
        _textoObs('• Interfere em exames laboratoriais se colhidos em até 6 h após infusão.'),

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