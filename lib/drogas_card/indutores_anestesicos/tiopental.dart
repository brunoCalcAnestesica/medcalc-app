import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoTiopental {
  static const String nome = 'Tiopental';
  static const String idBulario = 'tiopental';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/tiopental.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário do tiopental: $e');
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
      conteudo: _buildConteudoTiopental(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoTiopental(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Pentothal®, Thiopental®, Tiopental®'),
        _linhaInfo('Classificação', 'Barbitúrico de ação ultracurta; indutor anestésico'),
        _linhaInfo('Mecanismo', 'Potenciador do GABA; depressor do SNC'),
        _linhaInfo('Potência', 'Padrão ouro para indução anestésica'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Frasco', '1g (pó liofilizado)'),
        _linhaInfo('Reconstituição', '20mL SF 0,9% = 50mg/mL'),
        _linhaInfo('Estabilidade', '24h após reconstituição'),
        _linhaInfo('pH', '10,5–11,0 (altamente alcalino)'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Reconstituição', '1g em 20mL SF = 50mg/mL'),
        _linhaInfo('Diluição bolus', 'Diluir mais se necessário para 25mg/mL'),
        _linhaInfo('Infusão contínua', '1g em 250mL SF = 4mg/mL'),
        _linhaInfo('Cuidado', 'Evitar extravasamento — risco de necrose'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        if (isAdulto) ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Indução anestésica',
            descricaoDose: '3–5 mg/kg IV lenta',
            unidade: 'mg',
            dosePorKgMinima: 3.0,
            dosePorKgMaxima: 5.0,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Status epilepticus refratário',
            descricaoDose: 'Carga: 5–10 mg/kg IV + infusão 1–5 mg/kg/h',
            unidade: 'mg',
            dosePorKgMinima: 5.0,
            dosePorKgMaxima: 10.0,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Controle de hipertensão intracraniana',
            descricaoDose: '0,5–3 mg/kg/h IV contínua',
            unidade: 'mg/kg/h',
            dosePorKgMinima: 0.5,
            dosePorKgMaxima: 3.0,
            peso: peso,
          ),
        ] else ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Indução pediátrica',
            descricaoDose: '5–7 mg/kg IV lenta',
            unidade: 'mg',
            dosePorKgMinima: 5.0,
            dosePorKgMaxima: 7.0,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Status epilepticus pediátrico',
            descricaoDose: 'Carga: 5–10 mg/kg + infusão 0,5–3 mg/kg/h',
            unidade: 'mg',
            dosePorKgMinima: 5.0,
            dosePorKgMaxima: 10.0,
            peso: peso,
          ),
        ],

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Barbitúrico de ação ultracurta, potente depressor do SNC'),
        _textoObs('• Pode causar hipotensão e depressão respiratória'),
        _textoObs('• Evitar extravasamento: risco de necrose tecidual'),
        _textoObs('• Monitorização contínua necessária em infusões prolongadas'),
        _textoObs('• Contraindicado em porfiria aguda intermitente'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Início de ação', '10–30 segundos (IV)'),
        _linhaInfo('Pico de efeito', '30–60 segundos (IV)'),
        _linhaInfo('Duração', '5–10 minutos (bolus)'),
        _linhaInfo('Metabolização', 'Hepática extensa'),
        _linhaInfo('Meia-vida', '3–8 horas (eliminação terminal)'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade ao tiopental'),
        _textoObs('• Porfiria aguda intermitente'),
        _textoObs('• Insuficiência respiratória grave'),
        _textoObs('• Choque ou hipovolemia'),

        // Reações Adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('Comuns (1–10%): Sedação, hipotensão, depressão respiratória'),
        _textoObs('Incomuns (0,1–1%): Arritmias, necrose tecidual (extravasamento)'),
        _textoObs('Raras (<0,1%): Reações alérgicas, porfiria aguda'),

        // Interações
        const SizedBox(height: 16),
        const Text('Interações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Potencialização com outros depressores do SNC'),
        _textoObs('• Interação com anticoagulantes'),
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