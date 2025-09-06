import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoInsulinaRegular {
  static const String nome = 'Insulina Regular';
  static const String idBulario = 'insulina_regular';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/insulina_regular.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário da insulina regular: $e');
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
      conteudo: _buildConteudoInsulinaRegular(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoInsulinaRegular(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Insulina Regular, Humulin R®, Novolin R®'),
        _linhaInfo('Classificação', 'Hormônio hipoglicemiante'),
        _linhaInfo('Mecanismo', 'Insulina de ação rápida, única indicada para uso IV'),
        _linhaInfo('Uso', 'Emergência médica'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Frasco-ampola', '100 UI/mL (10 mL)'),
        _linhaInfo('Concentração', '100 UI/mL'),
        _linhaInfo('Forma', 'Solução límpida'),
        _linhaInfo('Via', 'IV exclusiva'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Infusão contínua', '50 UI em 50mL SF 0,9% (1 UI/mL)'),
        _linhaInfo('Bolus IV', 'Direto sem diluição (1–10 UI)'),
        _linhaInfo('Diluição', 'Apenas em SF 0,9%, preparo recente'),
        _linhaInfo('Bomba de infusão', 'Obrigatória'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        _linhaIndicacaoDoseCalculada(
          titulo: 'Cetoacidose diabética',
          descricaoDose: '0,1 UI/kg IV bolus + 0,1 UI/kg/h em infusão contínua',
          unidade: 'UI',
          dosePorKg: 0.1,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Estado hiperglicêmico hiperosmolar',
          descricaoDose: '0,1 UI/kg/h EV contínua (sem bolus)',
          unidade: 'UI/h',
          dosePorKg: 0.1,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Hipercalemia (adjuvante com glicose)',
          descricaoDose: '10 UI IV bolus com 50mL de G50%',
          unidade: 'UI',
          doseMaxima: 10,
          peso: peso,
        ),

        // Cálculo da Infusão
        const SizedBox(height: 16),
        const Text('Cálculo da Infusão', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        ConversaoInfusaoSlider(
          peso: peso,
          opcoesConcentracoes: {
            '50 UI/50mL (1 UI/mL)': 1,
          },
          unidade: 'UI/kg/h',
          doseMin: 0.05,
          doseMax: 0.2,
        ),

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Insulina de ação rápida, única indicada para uso IV'),
        _textoObs('• Controle rigoroso da glicemia capilar a cada 1 hora'),
        _textoObs('• Monitorar potássio sérico — risco de hipocalemia grave'),
        _textoObs('• Diluir apenas em SF 0,9%, preparo recente'),
        _textoObs('• Na hipercalemia, sempre associar à glicose IV para evitar hipoglicemia'),
        _textoObs('• Suspender se glicemia < 250mg/dL'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Início de ação', 'Imediato (IV)'),
        _linhaInfo('Pico de efeito', '30–60 minutos'),
        _linhaInfo('Duração', '2–4 horas'),
        _linhaInfo('Metabolização', 'Hepática e renal'),
        _linhaInfo('Eliminação', 'Renal (80%)'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade à insulina'),
        _textoObs('• Hipoglicemia'),
        _textoObs('• Hipocalemia grave'),
        _textoObs('• Acidose metabólica não diabética'),

        // Reações Adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('Comuns (1–10%): Hipoglicemia, hipocalemia'),
        _textoObs('Incomuns (0,1–1%): Reações alérgicas, lipodistrofia'),
        _textoObs('Raras (<0,1%): Resistência à insulina'),

        // Interações
        const SizedBox(height: 16),
        const Text('Interações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Potencializa glicose'),
        _textoObs('• Interfere com corticoides'),
        _textoObs('• Cuidado com betabloqueadores'),

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