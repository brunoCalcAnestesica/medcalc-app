import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoClindamicina {
  static const String nome = 'Clindamicina';
  static const String idBulario = 'clindamicina';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/clindamicina.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário da clindamicina: $e');
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
      conteudo: _buildConteudoClindamicina(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoClindamicina(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Dalacin C®, Clindamin®, genéricos'),
        _linhaInfo('Classificação', 'Lincosamida'),
        _linhaInfo('Mecanismo', 'Inibe síntese proteica bacteriana (subunidade 50S)'),
        _linhaInfo('Duração', '6–8 horas'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Frasco 600mg/4mL', 'Injetável'),
        _linhaInfo('Cápsulas 300mg', 'VO'),
        _linhaInfo('Creme vaginal', '2%'),
        _linhaInfo('Solução tópica', '1%'),
        _linhaInfo('Forma', 'Solução, cápsula, creme, solução tópica'),
        _linhaInfo('Via', 'IV, VO, tópica, vaginal'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('IV lenta', '600mg em 100mL SF ou SG 5% (≥30 min)'),
        _linhaInfo('VO', 'Intervalo de 6/6h ou 8/8h'),
        _linhaInfo('Estabilidade', '24h após preparo'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        if (isAdulto) ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Infecções de pele, partes moles e odontogênicas',
            descricaoDose: '300–600mg VO ou IV a cada 6–8h',
            unidade: 'mg',
            dosePorKgMinima: 300 / peso,
            dosePorKgMaxima: 600 / peso,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Infecções intra-abdominais e pélvicas',
            descricaoDose: '600–900mg IV a cada 8h',
            unidade: 'mg',
            dosePorKgMinima: 600 / peso,
            dosePorKgMaxima: 900 / peso,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Toxina estreptocócica (Strep. pyogenes)',
            descricaoDose: '600–900mg IV a cada 8h associada à penicilina',
            unidade: 'mg',
            dosePorKgMinima: 600 / peso,
            dosePorKgMaxima: 900 / peso,
            peso: peso,
          ),
        ] else ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Pediatria (≥1 mês)',
            descricaoDose: '10–13 mg/kg/dose IV ou VO a cada 8h (máx 600mg/dose)',
            unidade: 'mg',
            dosePorKgMinima: 10,
            dosePorKgMaxima: 13,
            doseMaxima: 600,
            peso: peso,
          ),
        ],

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Excelente cobertura contra cocos Gram-positivos e anaeróbios'),
        _textoObs('• Opção para alérgicos à penicilina'),
        _textoObs('• Bloqueia toxinas de Streptococcus pyogenes e Staphylococcus aureus'),
        _textoObs('• Risco de colite associada ao uso (C. difficile)'),
        _textoObs('• Não requer ajuste para função renal — metabolismo hepático'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Início de ação', 'Imediato'),
        _linhaInfo('Pico de efeito', '1–2 horas'),
        _linhaInfo('Duração', '6–8 horas'),
        _linhaInfo('Metabolização', 'Hepática (90%)'),
        _linhaInfo('Meia-vida', '2–3 horas'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade à clindamicina ou lincosamidas'),
        _textoObs('• História de colite associada a antibióticos'),
        _textoObs('• Uso tópico em feridas abertas extensas'),

        // Reações Adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('Comuns (1–10%): Diarreia, náusea, dor abdominal'),
        _textoObs('Incomuns (0,1–1%): Colite pseudomembranosa, elevação de transaminases'),
        _textoObs('Raras (<0,1%): Anafilaxia, agranulocitose'),

        // Interações
        const SizedBox(height: 16),
        const Text('Interações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Potencializa efeito de bloqueadores neuromusculares'),
        _textoObs('• Reduz eficácia de contraceptivos orais'),
        _textoObs('• Cuidado com uso concomitante de eritromicina'),

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