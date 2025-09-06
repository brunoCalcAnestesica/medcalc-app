import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoPropofol {
  static const String nome = 'Propofol';
  static const String idBulario = 'propofol';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/propofol.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário do propofol: $e');
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
      conteudo: _buildConteudoPropofol(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoPropofol(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Diprivan®, Propofol®, Fresofol®'),
        _linhaInfo('Classificação', 'Sedativo-hipnótico de ação ultrarrápida'),
        _linhaInfo('Mecanismo', 'Potenciador do GABA; agonista GABA-A'),
        _linhaInfo('Potência', 'Sedativo-hipnótico de referência'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Ampolas', '200mg/20mL (1%), 500mg/50mL (1%)'),
        _linhaInfo('Frascos', '1000mg/100mL (1%), 2000mg/200mL (1%)'),
        _linhaInfo('Concentração', '10mg/mL (1%)'),
        _linhaInfo('Forma', 'Emulsão lipídica branca'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Administração', 'Uso direto, não diluir'),
        _linhaInfo('Agitação', 'Agitar antes de usar — emulsão oleosa'),
        _linhaInfo('Estabilidade', '6h após abertura — risco de contaminação'),
        _linhaInfo('Via', 'Exclusivamente intravenosa'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        if (isAdulto) ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Indução anestésica',
            descricaoDose: '1,5–2,5 mg/kg em bolus IV',
            unidade: 'mg',
            dosePorKgMinima: 1.5,
            dosePorKgMaxima: 2.5,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Sedação em UTI',
            descricaoDose: '0,3–4 mg/kg/h IV contínua',
            unidade: 'mg/kg/h',
            dosePorKgMinima: 0.3,
            dosePorKgMaxima: 4.0,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Procedimento diagnóstico curto',
            descricaoDose: '0,5–1,5 mg/kg em bolus IV + manutenção',
            unidade: 'mg',
            dosePorKgMinima: 0.5,
            dosePorKgMaxima: 1.5,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Manutenção anestésica',
            descricaoDose: '4–12 mg/kg/h IV contínua',
            unidade: 'mg/kg/h',
            dosePorKgMinima: 4.0,
            dosePorKgMaxima: 12.0,
            peso: peso,
          ),
        ] else ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Indução anestésica pediátrica',
            descricaoDose: '2,5–3,5 mg/kg IV',
            unidade: 'mg',
            dosePorKgMinima: 2.5,
            dosePorKgMaxima: 3.5,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Sedação pediátrica contínua',
            descricaoDose: '1–4 mg/kg/h IV contínua',
            unidade: 'mg/kg/h',
            dosePorKgMinima: 1.0,
            dosePorKgMaxima: 4.0,
            peso: peso,
          ),
        ],

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Sedativo-hipnótico de ação ultrarrápida'),
        _textoObs('• Pode causar hipotensão e depressão respiratória'),
        _textoObs('• Evitar infusão prolongada em altas doses — risco de Síndrome de Infusão de Propofol'),
        _textoObs('• Não possui efeito analgésico — associar opioide se necessário'),
        _textoObs('• Usar exclusivamente por via intravenosa'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Início de ação', '10–30 segundos (IV)'),
        _linhaInfo('Pico de efeito', '30–60 segundos (IV)'),
        _linhaInfo('Duração', '3–8 minutos (bolus)'),
        _linhaInfo('Metabolização', 'Hepática extensa (CYP2B6)'),
        _linhaInfo('Meia-vida', '30–60 minutos (eliminação terminal)'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade ao propofol ou componentes'),
        _textoObs('• Insuficiência respiratória grave'),
        _textoObs('• Choque ou hipovolemia'),
        _textoObs('• Alergia a ovo ou soja (emulsão lipídica)'),

        // Reações Adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('Comuns (1–10%): Sedação, hipotensão, depressão respiratória'),
        _textoObs('Incomuns (0,1–1%): Arritmias, dor no local da injeção'),
        _textoObs('Raras (<0,1%): Síndrome de infusão de propofol, reações alérgicas'),

        // Interações
        const SizedBox(height: 16),
        const Text('Interações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Potencialização com outros depressores do SNC'),
        _textoObs('• Interação com benzodiazepínicos e opioides'),
        _textoObs('• Redução da eficácia de anticoncepcionais'),

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