import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoIpatropio {
  static const String nome = 'Ipatropio';
  static const String idBulario = 'ipatropio';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/ipatropio.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário do ipatropio: $e');
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
      conteudo: _buildConteudoIpatropio(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoIpatropio(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Atrovent®, Aerolin® Duo'),
        _linhaInfo('Classificação', 'Anticolinérgico'),
        _linhaInfo('Mecanismo', 'Antagonista muscarínico M1/M3'),
        _linhaInfo('Duração', '4-6 horas'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Solução 0,25mg/mL', '20 gotas = 0,5mg'),
        _linhaInfo('Forma', 'Solução inalatória'),
        _linhaInfo('Via', 'Nebulização'),
        _linhaInfo('Aerossol', '20mcg/dose'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Diluição', '3-4mL SF 0,9%'),
        _linhaInfo('Nebulização', '5-10 minutos'),
        _linhaInfo('Associação', 'Pode ser usado com β2-agonistas'),
        _linhaInfo('Frequência', 'A cada 6-8 horas'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        if (isAdulto) ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Crise asmática / broncoespasmo em DPOC',
            descricaoDose: '0,5 mg (20 gotas) por nebulização a cada 6–8h',
            unidade: 'mg',
            dosePorKg: 0.5 / peso,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Broncoespasmo agudo',
            descricaoDose: '0,5 mg (20 gotas) por nebulização a cada 6–8h',
            unidade: 'mg',
            dosePorKg: 0.5 / peso,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'DPOC agudizada',
            descricaoDose: '0,5 mg (20 gotas) por nebulização a cada 6–8h',
            unidade: 'mg',
            dosePorKg: 0.5 / peso,
            peso: peso,
          ),
        ] else ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Bronquiolite / broncoespasmo pediátrico',
            descricaoDose: '0,25 mg (10 gotas) por nebulização a cada 6–8h',
            unidade: 'mg',
            dosePorKg: 0.25 / peso,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Asma pediátrica',
            descricaoDose: '0,25 mg (10 gotas) por nebulização a cada 6–8h',
            unidade: 'mg',
            dosePorKg: 0.25 / peso,
            peso: peso,
          ),
        ],

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Antagonista muscarínico M1/M3 → promove broncodilatação via inibição vagal'),
        _textoObs('• Efeito máximo em 30–60 min, duração de até 6h'),
        _textoObs('• Pode causar boca seca, tosse ou gosto metálico'),
        _textoObs('• Uso complementar a β2-agonistas e corticoides'),
        _textoObs('• Seguro em crianças, gestantes e idosos'),
        _textoObs('• Não causa taquicardia como atropina'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Início de ação', '15–30 minutos'),
        _linhaInfo('Pico de efeito', '30–60 minutos'),
        _linhaInfo('Duração', '4–6 horas'),
        _linhaInfo('Metabolização', 'Hepática'),
        _linhaInfo('Meia-vida', '1,6 horas'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade ao ipatropio'),
        _textoObs('• Hipersensibilidade à atropina'),
        _textoObs('• Glaucoma de ângulo fechado'),
        _textoObs('• Hiperplasia prostática benigna'),

        // Reações Adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('Comuns (1–10%): Boca seca, tosse, gosto metálico'),
        _textoObs('Incomuns (0,1–1%): Visão turva, retenção urinária'),
        _textoObs('Raras (<0,1%): Reações alérgicas, broncoespasmo paradoxal'),

        // Interações
        const SizedBox(height: 16),
        const Text('Interações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Potencializado por outros anticolinérgicos'),
        _textoObs('• Sinérgico com β2-agonistas'),
        _textoObs('• Pode reduzir absorção de outros fármacos'),
        _textoObs('• Sem interações significativas com outros medicamentos'),

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