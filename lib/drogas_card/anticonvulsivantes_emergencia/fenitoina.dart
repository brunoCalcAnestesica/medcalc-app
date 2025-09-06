import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoFenitoina {
  static const String nome = 'Fenitoína';
  static const String idBulario = 'fenitoina';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/fenitoina.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário do fenitoína: $e');
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
      conteudo: _buildConteudoFenitoina(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoFenitoina(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Fenitoína®, Dilantin®'),
        _linhaInfo('Classificação', 'Hidantoína'),
        _linhaInfo('Mecanismo', 'Bloqueador de canais de Na+'),
        _linhaInfo('Duração', '12-24 horas'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Ampola 250mg/5mL', '50mg/mL'),
        _linhaInfo('Ampola 100mg/2mL', '50mg/mL'),
        _linhaInfo('Forma', 'Solução injetável'),
        _linhaInfo('Via', 'EV'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Diluição', 'Diluir 1:1 com SF 0,9%'),
        _linhaInfo('Exemplo', '250mg em 5mL + 5mL SF'),
        _linhaInfo('Velocidade máxima', '50 mg/min (adultos)'),
        _linhaInfo('Velocidade pediátrica', '1–3 mg/kg/min'),
        _linhaInfo('Estabilidade', '24h após diluição'),
        _linhaInfo('Importante', 'NUNCA diluir em glicose'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        if (isAdulto) ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Estado de mal epiléptico',
            descricaoDose: '15–20 mg/kg EV lenta',
            unidade: 'mg',
            dosePorKgMinima: 15,
            dosePorKgMaxima: 20,
            doseMaxima: 1000,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Convulsões refratárias',
            descricaoDose: '10–15 mg/kg EV lenta',
            unidade: 'mg',
            dosePorKgMinima: 10,
            dosePorKgMaxima: 15,
            doseMaxima: 1000,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Manutenção após controle',
            descricaoDose: '5–7 mg/kg/dia divididos em 2–3 doses',
            unidade: 'mg/dia',
            dosePorKgMinima: 5,
            dosePorKgMaxima: 7,
            peso: peso,
          ),
        ] else ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Estado de mal epiléptico pediátrico',
            descricaoDose: '15–20 mg/kg EV lenta',
            unidade: 'mg',
            dosePorKgMinima: 15,
            dosePorKgMaxima: 20,
            doseMaxima: 1000,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Convulsões neonatais',
            descricaoDose: '15–20 mg/kg EV lenta',
            unidade: 'mg',
            dosePorKgMinima: 15,
            dosePorKgMaxima: 20,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Manutenção pediátrica',
            descricaoDose: '5–7 mg/kg/dia divididos em 2–3 doses',
            unidade: 'mg/dia',
            dosePorKgMinima: 5,
            dosePorKgMaxima: 7,
            peso: peso,
          ),
        ],

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Anticonvulsivante de ação prolongada; estabiliza canais de sódio'),
        _textoObs('• Evitar extravasamento venoso: risco de necrose (síndrome púrpura local)'),
        _textoObs('• NUNCA diluir em glicose: precipita. Sempre diluir em SF 0,9%'),
        _textoObs('• Monitorar níveis séricos em uso prolongado'),
        _textoObs('• Pode causar bradicardia e hipotensão se infundido rapidamente'),
        _textoObs('• Cuidado em pacientes com bloqueio cardíaco'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Início de ação', '15–30 minutos'),
        _linhaInfo('Pico de efeito', '1–2 horas'),
        _linhaInfo('Duração', '12–24 horas'),
        _linhaInfo('Metabolização', 'Hepática'),
        _linhaInfo('Meia-vida', '12–30 horas'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade ao fenitoína'),
        _textoObs('• Bloqueio cardíaco de 2º ou 3º grau'),
        _textoObs('• Bradicardia sinusal'),
        _textoObs('• Síndrome de Adams-Stokes'),
        _textoObs('• Porfiria'),

        // Reações Adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('Comuns (1–10%): Ataxia, nistagmo, sonolência'),
        _textoObs('Incomuns (0,1–1%): Rash cutâneo, bradicardia, hipotensão'),
        _textoObs('Raras (<0,1%): Síndrome de Stevens-Johnson, necrólise epidérmica'),

        // Interações
        const SizedBox(height: 16),
        const Text('Interações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Potencializado por outros anticonvulsivantes'),
        _textoObs('• Potencializado por antidepressivos tricíclicos'),
        _textoObs('• Pode reduzir eficácia de contraceptivos'),
        _textoObs('• Pode reduzir níveis de vitamina D'),
        _textoObs('• Indutor enzimático: acelera metabolismo de outros fármacos'),

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