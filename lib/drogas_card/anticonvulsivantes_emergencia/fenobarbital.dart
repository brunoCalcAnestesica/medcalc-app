import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoFenobarbital {
  static const String nome = 'Fenobarbital';
  static const String idBulario = 'fenobarbital';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/fenobarbital.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário do fenobarbital: $e');
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
      conteudo: _buildConteudoFenobarbital(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoFenobarbital(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Fenobarbital®, Luminal®'),
        _linhaInfo('Classificação', 'Barbitúrico'),
        _linhaInfo('Mecanismo', 'Potencializador GABA + Anticonvulsivante'),
        _linhaInfo('Duração', '6-12 horas'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Ampola 100mg/mL', 'Solução injetável'),
        _linhaInfo('Ampola 200mg/mL', 'Solução injetável'),
        _linhaInfo('Forma', 'Solução injetável'),
        _linhaInfo('Via', 'EV'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Diluição', 'Diluir 1:10 em SF 0,9%'),
        _linhaInfo('Exemplo', '100mg em 10mL SF'),
        _linhaInfo('Velocidade máxima', '1mg/kg/min'),
        _linhaInfo('Tempo de infusão', '20–30 minutos'),
        _linhaInfo('Estabilidade', '24h após diluição'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        if (isAdulto) ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Estado de mal epiléptico',
            descricaoDose: '15–20 mg/kg EV dose única lenta',
            unidade: 'mg',
            dosePorKgMinima: 15,
            dosePorKgMaxima: 20,
            doseMaxima: 1000,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Crise convulsiva refratária',
            descricaoDose: '5–10 mg/kg EV',
            unidade: 'mg',
            dosePorKgMinima: 5,
            dosePorKgMaxima: 10,
            doseMaxima: 600,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Sedação prolongada',
            descricaoDose: '1–3 mg/kg EV a cada 8h',
            unidade: 'mg',
            dosePorKgMinima: 1,
            dosePorKgMaxima: 3,
            peso: peso,
          ),
        ] else ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Estado de mal epiléptico pediátrico',
            descricaoDose: '15–20 mg/kg EV dose única lenta',
            unidade: 'mg',
            dosePorKgMinima: 15,
            dosePorKgMaxima: 20,
            doseMaxima: 1000,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Profilaxia de convulsões neonatais',
            descricaoDose: '10–20 mg/kg dose de ataque + 3–5 mg/kg/dia manutenção',
            unidade: 'mg',
            dosePorKgMinima: 10,
            dosePorKgMaxima: 20,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Convulsões neonatais',
            descricaoDose: '15–20 mg/kg EV dose única',
            unidade: 'mg',
            dosePorKgMinima: 15,
            dosePorKgMaxima: 20,
            peso: peso,
          ),
        ],

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Barbitúrico de ação prolongada com efeito anticonvulsivante e sedativo'),
        _textoObs('• Administrar lentamente devido ao risco de hipotensão e depressão respiratória'),
        _textoObs('• Evitar infusão rápida: risco de apneia, hipotensão grave e parada cardíaca'),
        _textoObs('• Monitorar níveis séricos em uso prolongado ou múltiplas doses'),
        _textoObs('• Pode causar sonolência prolongada, especialmente em neonatos'),
        _textoObs('• Cuidado em pacientes com porfiria'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Início de ação', '5–15 minutos'),
        _linhaInfo('Pico de efeito', '30–60 minutos'),
        _linhaInfo('Duração', '6–12 horas'),
        _linhaInfo('Metabolização', 'Hepática'),
        _linhaInfo('Meia-vida', '50–120 horas'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade ao fenobarbital'),
        _textoObs('• Porfiria aguda intermitente'),
        _textoObs('• Depressão respiratória grave'),
        _textoObs('• Choque'),
        _textoObs('• Hipersensibilidade a barbitúricos'),

        // Reações Adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('Comuns (1–10%): Sedação, hipotensão, depressão respiratória'),
        _textoObs('Incomuns (0,1–1%): Rash cutâneo, agranulocitose'),
        _textoObs('Raras (<0,1%): Síndrome de Stevens-Johnson, necrólise epidérmica'),

        // Interações
        const SizedBox(height: 16),
        const Text('Interações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Potencializado por outros depressores do SNC'),
        _textoObs('• Potencializado por álcool'),
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