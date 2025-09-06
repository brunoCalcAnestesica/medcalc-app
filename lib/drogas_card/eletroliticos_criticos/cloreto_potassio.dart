import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoCloretoPotassio {
  static const String nome = 'Cloreto de Potássio';
  static const String idBulario = 'cloreto_potassio';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/cloreto_potassio.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário do cloreto de potássio: $e');
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
      conteudo: _buildConteudoCloretoPotassio(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoCloretoPotassio(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Cloreto de Potássio®, Potassium Chloride®'),
        _linhaInfo('Classificação', 'Eletrolítico crítico'),
        _linhaInfo('Mecanismo', 'Reposição de potássio ionizado'),
        _linhaInfo('Concentração', '19,1% (2mEq/mL)'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Frasco-ampola 19,1%', '2mEq/mL – 10mL = 20mEq'),
        _linhaInfo('Concentração', '2mEq/mL'),
        _linhaInfo('Forma', 'Solução aquosa incolor'),
        _linhaInfo('Osmolaridade', '4000 mOsm/L (hipertônica)'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Diluição', '20–40mEq em 100–250mL SF ou SG 5%'),
        _linhaInfo('Concentração segura', 'Máx 40mEq/L em periférico'),
        _linhaInfo('Infusão', 'Com bomba controlada, monitorar ritmo cardíaco'),
        _linhaInfo('Via', 'Exclusivo EV, nunca IM ou SC'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        _linhaIndicacaoDoseCalculada(
          titulo: 'Reposição de hipocalemia leve a moderada',
          descricaoDose: '20–40 mEq em 4–6h IV',
          unidade: 'mEq',
          dosePorKgMinima: 0.3,
          dosePorKgMaxima: 0.6,
          doseMaxima: 40,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Hipocalemia grave ou com arritmia',
          descricaoDose: '0,5–1 mEq/kg/dose IV lenta (monitorizada)',
          unidade: 'mEq',
          dosePorKgMinima: 0.5,
          dosePorKgMaxima: 1.0,
          doseMaxima: 60,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Manutenção de potássio',
          descricaoDose: '20–40 mEq/dia IV em infusão contínua',
          unidade: 'mEq/dia',
          doseMaxima: 40,
          peso: peso,
        ),

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Corrigir hipomagnesemia antes da reposição se refratária'),
        _textoObs('• Infusão periférica: máx 10 mEq/h'),
        _textoObs('• Central: até 20 mEq/h com ECG contínuo'),
        _textoObs('• Risco de parada cardíaca se infundido rápido ou não diluído'),
        _textoObs('• Monitorar potássio e função renal durante a terapia'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Início de ação', 'Imediato (bolus IV)'),
        _linhaInfo('Pico de efeito', '30–60 minutos'),
        _linhaInfo('Duração', '4–6 horas'),
        _linhaInfo('Distribuição', 'Principalmente intracelular (98%)'),
        _linhaInfo('Eliminação', 'Renal (90%)'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade ao cloreto de potássio'),
        _textoObs('• Hipercalemia'),
        _textoObs('• Insuficiência renal grave'),
        _textoObs('• Bloqueio cardíaco'),

        // Reações Adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('Comuns (1–10%): Dor no local da infusão, flebite'),
        _textoObs('Incomuns (0,1–1%): Hipercalemia, arritmias'),
        _textoObs('Raras (<0,1%): Parada cardíaca, necrose tecidual'),

        // Interações
        const SizedBox(height: 16),
        const Text('Interações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Potencializa digitálicos'),
        _textoObs('• Interfere com absorção de tetraciclinas'),
        _textoObs('• Diuréticos poupadores de potássio'),

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