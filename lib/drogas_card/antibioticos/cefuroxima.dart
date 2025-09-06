import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoCefuroxima {
  static const String nome = 'Cefuroxima';
  static const String idBulario = 'cefuroxima';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/cefuroxima.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário da cefuroxima: $e');
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
      conteudo: _buildConteudoCefuroxima(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoCefuroxima(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Zinnat®, Cefurix®, genéricos'),
        _linhaInfo('Classificação', 'Cefalosporina de 2ª geração'),
        _linhaInfo('Mecanismo', 'Inibidor da síntese da parede celular bacteriana'),
        _linhaInfo('Duração', '8–12 horas'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Frasco 750mg', 'Pó para reconstituição'),
        _linhaInfo('Frasco 1,5g', 'Pó para reconstituição'),
        _linhaInfo('Comprimidos', '250mg, 500mg (axetil)'),
        _linhaInfo('Forma', 'Pó liofilizado ou comprimido'),
        _linhaInfo('Via', 'IV, VO'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('IV direta', '750mg em 7–10mL SF 0,9% (3–5 min)'),
        _linhaInfo('Infusão', '1,5g em 100mL SF em 30 min'),
        _linhaInfo('VO', 'Após alimentação (melhor absorção)'),
        _linhaInfo('Estabilidade', '24h após reconstituição'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        if (isAdulto) ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Infecções respiratórias altas e baixas',
            descricaoDose: '750mg IV a cada 8h ou 500mg VO 2x/dia (7–10 dias)',
            unidade: 'mg',
            dosePorKgMinima: 750 / peso,
            dosePorKgMaxima: 1500 / peso,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Profilaxia cirúrgica (alternativa à cefazolina)',
            descricaoDose: '1,5g IV 30 min antes da incisão | repetir após 4h se necessário',
            unidade: 'g',
            dosePorKg: 1.5 / peso,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'ITU complicada / pielonefrite leve',
            descricaoDose: '750mg IV 2–3x/dia ou 250–500mg VO 2x/dia',
            unidade: 'mg',
            dosePorKgMinima: 250 / peso,
            dosePorKgMaxima: 1000 / peso,
            peso: peso,
          ),
        ] else ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Pediatria (VO ou IV)',
            descricaoDose: '20–30mg/kg/dia divididos em 2 doses (máx 500mg/dose)',
            unidade: 'mg',
            dosePorKgMinima: 20,
            dosePorKgMaxima: 30,
            doseMaxima: 500,
            peso: peso,
          ),
        ],

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Cefalosporina de 2ª geração, maior espectro contra Gram-negativos'),
        _textoObs('• Eficaz para infecções respiratórias, urinárias e cutâneas'),
        _textoObs('• VO deve ser tomada após refeições (melhor absorção)'),
        _textoObs('• Ajuste em insuficiência renal'),
        _textoObs('• Pode causar diarreia, incluindo por Clostridioides difficile'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Início de ação', 'Imediato'),
        _linhaInfo('Pico de efeito', '1–2 horas'),
        _linhaInfo('Duração', '8–12 horas'),
        _linhaInfo('Metabolização', 'Renal (90%)'),
        _linhaInfo('Meia-vida', '1–2 horas'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade à cefuroxima ou cefalosporinas'),
        _textoObs('• Hipersensibilidade cruzada com penicilinas'),
        _textoObs('• Uso IM em crianças pequenas (preferir IV)'),

        // Reações Adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('Comuns (1–10%): Diarreia, náusea, reações no local da injeção'),
        _textoObs('Incomuns (0,1–1%): Neutropenia, elevação de transaminases'),
        _textoObs('Raras (<0,1%): Anafilaxia, convulsões'),

        // Interações
        const SizedBox(height: 16),
        const Text('Interações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Pode potencializar nefrotoxicidade de aminoglicosídeos'),
        _textoObs('• Reduz eficácia de contraceptivos orais'),
        _textoObs('• Cuidado com uso concomitante de anticoagulantes'),

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