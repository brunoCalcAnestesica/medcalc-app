import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoGlicose50 {
  static const String nome = 'Glicose 50%';
  static const String idBulario = 'glicose50';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/glicose50.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário da glicose 50%: $e');
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
      conteudo: _buildConteudoGlicose50(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoGlicose50(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Glicose 50%, Dextrose 50%'),
        _linhaInfo('Classificação', 'Carboidrato / Energético'),
        _linhaInfo('Mecanismo', 'Fonte rápida de glicose para correção de hipoglicemia'),
        _linhaInfo('Uso', 'Emergência médica'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Ampola 10mL', '5g de glicose (50%)'),
        _linhaInfo('Concentração', '500mg/mL'),
        _linhaInfo('Forma', 'Solução hipertônica'),
        _linhaInfo('Via', 'Endovenosa exclusiva'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Uso direto', 'Sem diluição'),
        _linhaInfo('Ampola', 'Pronta para uso IV'),
        _linhaInfo('Acesso venoso', 'Calibroso (risco de flebite)'),
        _linhaInfo('Pediatria', 'Diluir preferencialmente para G10%'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        if (isAdulto) ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Hipoglicemia grave sintomática',
            descricaoDose: '25–50mL IV em bolus (1–2 ampolas)',
            unidade: 'mL',
            dosePorKgMinima: 0.5,
            dosePorKgMaxima: 1.0,
            doseMaxima: 50,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Hipoglicemia refratária',
            descricaoDose: '50–100mL IV em bolus (2–4 ampolas)',
            unidade: 'mL',
            doseMaxima: 100,
            peso: peso,
          ),
        ] else ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Hipoglicemia neonatal/pediátrica grave',
            descricaoDose: '0,5–1g/kg (1–2 mL/kg de G50%) diluído em SG 10%',
            unidade: 'mL',
            dosePorKgMinima: 1.0,
            dosePorKgMaxima: 2.0,
            doseMaxima: 10,
            peso: peso,
          ),
        ],

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Ação imediata nas hipoglicemias sintomáticas'),
        _textoObs('• Pode causar flebite — preferir acesso venoso calibroso'),
        _textoObs('• Monitorar glicemia capilar 10–15 minutos após uso'),
        _textoObs('• Em pediatria, diluir preferencialmente para G10%'),
        _textoObs('• Contraindicado em hiperglicemia ou intolerância à glicose'),
        _textoObs('• Risco de hiperosmolaridade e desidratação'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Início de ação', 'Imediato'),
        _linhaInfo('Pico de efeito', '5–10 minutos'),
        _linhaInfo('Duração', '30–60 minutos'),
        _linhaInfo('Metabolização', 'Glicólise e ciclo de Krebs'),
        _linhaInfo('Eliminação', 'Metabolizada completamente'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade à glicose'),
        _textoObs('• Hiperglicemia'),
        _textoObs('• Intolerância à glicose'),
        _textoObs('• Acidose metabólica grave'),

        // Reações Adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('Comuns (1–10%): Flebite, dor no local da injeção'),
        _textoObs('Incomuns (0,1–1%): Hiperglicemia, hiperosmolaridade'),
        _textoObs('Raras (<0,1%): Reações alérgicas, trombose venosa'),

        // Interações
        const SizedBox(height: 16),
        const Text('Interações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Potencializa insulina'),
        _textoObs('• Interfere com testes de glicemia'),
        _textoObs('• Cuidado com outros carboidratos'),

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