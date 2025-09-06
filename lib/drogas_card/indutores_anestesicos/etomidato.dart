import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoEtomidato {
  static const String nome = 'Etomidato';
  static const String idBulario = 'etomidato';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/etomidato.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário do etomidato: $e');
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
      conteudo: _buildConteudoEtomidato(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoEtomidato(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Hypnomidate®, Etomidato®, Amidate®'),
        _linhaInfo('Classificação', 'Hipnótico de ação ultrarrápida'),
        _linhaInfo('Mecanismo', 'Potenciador do GABA; agonista GABA-A'),
        _linhaInfo('Potência', 'Ideal para pacientes hemodinamicamente instáveis'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Ampolas', '20mg/10mL (2mg/mL)'),
        _linhaInfo('Concentração', '2mg/mL'),
        _linhaInfo('Forma', 'Solução aquosa incolor'),
        _linhaInfo('Estabilidade', '24h após abertura'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Administração', 'Uso direto, sem diluição'),
        _linhaInfo('Infusão', 'Lentamente em 30–60 segundos'),
        _linhaInfo('Via', 'Exclusivamente intravenosa'),
        _linhaInfo('Cuidado', 'Evitar extravasamento — dor local'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        _linhaIndicacaoDoseCalculada(
          titulo: 'Indução anestésica (paciente instável)',
          descricaoDose: '0,2–0,3 mg/kg IV lenta (único uso)',
          unidade: 'mg',
          dosePorKgMinima: 0.2,
          dosePorKgMaxima: 0.3,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Procedimentos breves (cardioversão, intubação)',
          descricaoDose: '0,15–0,3 mg/kg IV',
          unidade: 'mg',
          dosePorKgMinima: 0.15,
          dosePorKgMaxima: 0.3,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Sedação para procedimentos curtos',
          descricaoDose: '0,1–0,2 mg/kg IV',
          unidade: 'mg',
          dosePorKgMinima: 0.1,
          dosePorKgMaxima: 0.2,
          peso: peso,
        ),

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipnótico de ação ultrarrápida, ideal para pacientes instáveis'),
        _textoObs('• Não causa hipotensão significativa ou depressão miocárdica'),
        _textoObs('• Sem efeito analgésico — associar opioide se necessário'),
        _textoObs('• Pode causar mioclonias e dor na injeção'),
        _textoObs('• Evitar uso prolongado — supressão adrenocortical'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Início de ação', '10–20 segundos (IV)'),
        _linhaInfo('Pico de efeito', '30–60 segundos (IV)'),
        _linhaInfo('Duração', '3–5 minutos (bolus)'),
        _linhaInfo('Metabolização', 'Hepática extensa (esterases)'),
        _linhaInfo('Meia-vida', '2–5 horas (eliminação terminal)'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade ao etomidato'),
        _textoObs('• Insuficiência adrenal'),
        _textoObs('• Uso prolongado (supressão adrenocortical)'),
        _textoObs('• Choque séptico (controverso)'),

        // Reações Adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('Comuns (1–10%): Mioclonias, dor na injeção, náuseas'),
        _textoObs('Incomuns (0,1–1%): Supressão adrenocortical, apneia'),
        _textoObs('Raras (<0,1%): Reações alérgicas, arritmias'),

        // Interações
        const SizedBox(height: 16),
        const Text('Interações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Potencialização com outros depressores do SNC'),
        _textoObs('• Interação com benzodiazepínicos e opioides'),
        _textoObs('• Supressão adrenocortical com uso prolongado'),

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