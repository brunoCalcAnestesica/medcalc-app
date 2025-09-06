import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoCefazolina {
  static const String nome = 'Cefazolina';
  static const String idBulario = 'cefazolina';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/cefazolina.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário da cefazolina: $e');
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
      conteudo: _buildConteudoCefazolina(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoCefazolina(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Cefazolin®, Kefazol®'),
        _linhaInfo('Classificação', 'Cefalosporina de 1ª geração'),
        _linhaInfo('Mecanismo', 'Inibidor da síntese da parede celular bacteriana'),
        _linhaInfo('Duração', '8 horas'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Frasco 1g', 'Pó para reconstituição'),
        _linhaInfo('Frasco 2g', 'Pó para reconstituição'),
        _linhaInfo('Forma', 'Pó liofilizado'),
        _linhaInfo('Via', 'IV, IM'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('EV direta', '1g em 10mL água estéril (3–5 min)'),
        _linhaInfo('Infusão', '1g em 100mL SF 0,9% (20–30 min)'),
        _linhaInfo('IM', '1g em 3,5mL lidocaína 1%'),
        _linhaInfo('Estabilidade', '24h após reconstituição'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        if (isAdulto) ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Profilaxia cirúrgica (adulto)',
            descricaoDose: '1–2g IV 30 min antes da incisão (repetir após 4h se necessário)',
            unidade: 'g',
            dosePorKgMinima: 1.0 / peso,
            dosePorKgMaxima: 2.0 / peso,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Infecções de pele, partes moles e osteoarticulares',
            descricaoDose: '1g IV a cada 8h (até 6g/dia)',
            unidade: 'g',
            dosePorKgMinima: 1.0 / peso,
            dosePorKgMaxima: 2.0 / peso,
            doseMaxima: 6,
            peso: peso,
          ),
        ] else ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Uso pediátrico (infecções gerais)',
            descricaoDose: '25–50 mg/kg/dose IV a cada 8h (máx 6g/dia)',
            unidade: 'mg',
            dosePorKgMinima: 25,
            dosePorKgMaxima: 50,
            doseMaxima: 6000,
            peso: peso,
          ),
        ],

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Cefalosporina de 1ª geração, ótima contra cocos Gram-positivos'),
        _textoObs('• Primeira escolha na profilaxia cirúrgica'),
        _textoObs('• Eliminação renal — ajustar dose em insuficiência renal'),
        _textoObs('• Não atravessa bem a barreira hematoencefálica'),
        _textoObs('• Segura em gestantes e pediatria'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Início de ação', 'Imediato'),
        _linhaInfo('Pico de efeito', '1–2 horas'),
        _linhaInfo('Duração', '8 horas'),
        _linhaInfo('Metabolização', 'Renal (90%)'),
        _linhaInfo('Meia-vida', '1,5–2 horas'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade à cefazolina ou cefalosporinas'),
        _textoObs('• Hipersensibilidade cruzada com penicilinas'),
        _textoObs('• Uso IM em crianças pequenas (preferir IV)'),

        // Reações Adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('Comuns (1–10%): Reações no local da injeção, diarreia, náusea'),
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