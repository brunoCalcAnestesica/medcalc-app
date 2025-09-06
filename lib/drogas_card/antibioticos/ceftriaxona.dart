import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoCeftriaxona {
  static const String nome = 'Ceftriaxona';
  static const String idBulario = 'ceftriaxona';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/ceftriaxona.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário da ceftriaxona: $e');
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
      conteudo: _buildConteudoCeftriaxona(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoCeftriaxona(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Rocefin®, Ceftriaxone Genérico'),
        _linhaInfo('Classificação', 'Cefalosporina de 3ª geração'),
        _linhaInfo('Mecanismo', 'Inibidor da síntese da parede celular bacteriana'),
        _linhaInfo('Duração', '24 horas'),

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
        _linhaInfo('Infusão', '1–2g em 100mL SG 5% ou SF 0,9% (30 min)'),
        _linhaInfo('IM', '1g em 3,5mL lidocaína 1%'),
        _linhaInfo('Estabilidade', '24h após reconstituição'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        if (isAdulto) ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Infecções respiratórias, urinárias, abdominais e osteoarticulares',
            descricaoDose: '1–2 g IV 1x/dia (ou 12/12h em casos graves)',
            unidade: 'g',
            dosePorKgMinima: 1.0 / peso,
            dosePorKgMaxima: 2.0 / peso,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Meningite / neuroinfecção',
            descricaoDose: '2 g IV a cada 12h (4 g/dia total)',
            unidade: 'g',
            dosePorKg: 2.0 / peso,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Profilaxia cirúrgica em neurocirurgia / trauma',
            descricaoDose: '2 g IV 30 min antes da incisão',
            unidade: 'g',
            dosePorKg: 2.0 / peso,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Gonorreia',
            descricaoDose: '250 mg IM dose única',
            unidade: 'mg',
            dosePorKg: 250 / peso,
            peso: peso,
          ),
        ] else ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Pediatria / neonatologia',
            descricaoDose: '50–100 mg/kg/dia 1x/dia (máx 2 g/dose)',
            unidade: 'mg',
            dosePorKgMinima: 50,
            dosePorKgMaxima: 100,
            doseMaxima: 2000,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Meningite pediátrica',
            descricaoDose: '100 mg/kg/dia 2x/dia',
            unidade: 'mg',
            dosePorKg: 100,
            peso: peso,
          ),
        ],

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Cefalosporina de 3ª geração com excelente penetração no SNC'),
        _textoObs('• Amplo espectro antibacteriano'),
        _textoObs('• Não cobre Pseudomonas aeruginosa'),
        _textoObs('• Eliminação mista renal e biliar — segura na IRC leve/moderada'),
        _textoObs('• Pode causar pseudolitíase biliar e colestase transitória'),
        _textoObs('• Contraindicado reconstituir com soluções que contenham cálcio'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Início de ação', 'Imediato'),
        _linhaInfo('Pico de efeito', '1–2 horas'),
        _linhaInfo('Duração', '24 horas'),
        _linhaInfo('Metabolização', 'Renal (60%) e biliar (40%)'),
        _linhaInfo('Meia-vida', '6–9 horas'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade à ceftriaxona ou cefalosporinas'),
        _textoObs('• Hipersensibilidade cruzada com penicilinas'),
        _textoObs('• Reconstituição com soluções contendo cálcio'),
        _textoObs('• Prematuros com hiperbilirrubinemia'),

        // Reações Adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('Comuns (1–10%): Diarreia, náusea, reações no local da injeção'),
        _textoObs('Incomuns (0,1–1%): Pseudolitíase biliar, colestase'),
        _textoObs('Raras (<0,1%): Anafilaxia, neutropenia, trombocitopenia'),

        // Interações
        const SizedBox(height: 16),
        const Text('Interações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Incompatível com soluções contendo cálcio'),
        _textoObs('• Pode potencializar anticoagulantes'),
        _textoObs('• Reduz eficácia de contraceptivos orais'),
        _textoObs('• Cuidado com uso concomitante de probenecida'),

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