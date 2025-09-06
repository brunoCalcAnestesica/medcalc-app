import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoManitol {
  static const String nome = 'Manitol';
  static const String idBulario = 'manitol';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/manitol.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário do manitol: $e');
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
      conteudo: _buildConteudoManitol(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoManitol(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Manitol®, Osmitrol®, Mannitol®'),
        _linhaInfo('Classificação', 'Diurético osmótico'),
        _linhaInfo('Mecanismo', 'Aumenta pressão osmótica plasmática'),
        _linhaInfo('Uso', 'Medicamento crítico'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Frasco 250mL', '20% (200mg/mL)'),
        _linhaInfo('Frasco 500mL', '20% (200mg/mL)'),
        _linhaInfo('Concentração', '200mg/mL'),
        _linhaInfo('Via', 'Endovenosa exclusiva'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Via EV', 'Bolus ou infusão lenta com filtro'),
        _linhaInfo('Aquecimento', 'Se houver precipitado'),
        _linhaInfo('Filtro', 'Obrigatório'),
        _linhaInfo('Temperatura', 'Não cristalizar abaixo de 15°C'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        _linhaIndicacaoDoseCalculada(
          titulo: 'Redução da PIC',
          descricaoDose: '0,25–1 g/kg (1,25–5 mL/kg da solução a 20%) EV bolus a cada 4–6h (máx 2g/kg)',
          unidade: 'g',
          dosePorKgMinima: 0.25,
          dosePorKgMaxima: 1.0,
          doseMaxima: 2.0 * peso,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Redução da PIO',
          descricaoDose: '0,5–2 g/kg (2,5–10 mL/kg da solução a 20%) EV em 30–60min',
          unidade: 'g',
          dosePorKgMinima: 0.5,
          dosePorKgMaxima: 2.0,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'IRA oligúrica / rabdomiólise',
          descricaoDose: '50–100g (250–500mL da solução a 20%) EV diluídos em 250–500mL de SF 0,9% ou SG 5%',
          unidade: 'g',
          dosePorKgMinima: 50 / peso,
          doseMaxima: 100,
          peso: peso,
        ),

        // Cálculo da Infusão
        const SizedBox(height: 16),
        const Text('Cálculo da Infusão', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        ConversaoInfusaoSlider(
          peso: peso,
          opcoesConcentracoes: {
            '500mL a 20% (200mg/mL)': 200,
            '250mL a 20% (200mg/mL)': 200,
          },
          unidade: 'mL/kg',
          doseMin: 1.25,
          doseMax: 5.0,
        ),

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Diurético osmótico potente, de uso crítico'),
        _textoObs('• Risco de hipervolemia, hiponatremia e insuficiência renal'),
        _textoObs('• Contraindicado em ICC, anúria e HIC ativa não controlada'),
        _textoObs('• Cristaliza abaixo de 15°C — usar filtro e aquecer'),
        _textoObs('• Monitorar osmolaridade sérica e gap osmolar'),
        _textoObs('• Suspender se osmolaridade > 320 mOsm/kg'),
        _textoObs('• Pode causar efeito rebote e aumento paradoxal da PIC'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Início de ação', '15–30 minutos'),
        _linhaInfo('Pico de efeito', '1–2 horas'),
        _linhaInfo('Duração', '4–6 horas'),
        _linhaInfo('Metabolização', 'Não metabolizado'),
        _linhaInfo('Eliminação', 'Renal (90%)'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade ao manitol'),
        _textoObs('• Anúria'),
        _textoObs('• Insuficiência cardíaca congestiva'),
        _textoObs('• Hemorragia intracraniana ativa'),
        _textoObs('• Desidratação grave'),

        // Reações Adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('Comuns (1–10%): Hipervolemia, hiponatremia, hipocalemia'),
        _textoObs('Incomuns (0,1–1%): Insuficiência renal aguda, acidose metabólica'),
        _textoObs('Raras (<0,1%): Reações alérgicas, flebite'),

        // Interações
        const SizedBox(height: 16),
        const Text('Interações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Potencializa outros diuréticos'),
        _textoObs('• Interfere com lítio'),
        _textoObs('• Cuidado com nefrotoxicos'),

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
    double? dosePorKgMinima,
    double? dosePorKgMaxima,
    double? doseMaxima,
    required double peso,
  }) {
    double? doseCalculadaMin;
    double? doseCalculadaMax;

    if (dosePorKgMinima != null) {
      doseCalculadaMin = dosePorKgMinima * peso;
      if (doseMaxima != null && doseCalculadaMin > doseMaxima) {
        doseCalculadaMin = doseMaxima;
      }
    }

    if (dosePorKgMaxima != null) {
      doseCalculadaMax = dosePorKgMaxima * peso;
      if (doseMaxima != null && doseCalculadaMax > doseMaxima) {
        doseCalculadaMax = doseMaxima;
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titulo, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(descricaoDose, style: const TextStyle(fontSize: 13)),
          if (doseCalculadaMin != null && doseCalculadaMax != null)
            Text('Dose calculada: ${doseCalculadaMin.toStringAsFixed(1)}–${doseCalculadaMax.toStringAsFixed(1)} $unidade', 
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