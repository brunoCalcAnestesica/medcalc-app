import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoAlteplase {
  static const String nome = 'Alteplase';
  static const String idBulario = 'alteplase';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/alteplase.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário do alteplase: $e');
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
      conteudo: _buildConteudoAlteplase(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoAlteplase(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Activase®, Alteplase Genérico'),
        _linhaInfo('Classificação', 'Trombolítico'),
        _linhaInfo('Mecanismo', 'Ativador do plasminogênio tecidual (rTPA)'),
        _linhaInfo('Duração', '4-6 horas'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Frasco 50mg', 'Liofilizado + diluente 50mL'),
        _linhaInfo('Concentração', '1mg/mL após reconstituição'),
        _linhaInfo('Forma', 'Pó liofilizado'),
        _linhaInfo('Via', 'IV'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Reconstituição', 'Com diluente incluso'),
        _linhaInfo('Concentração', '50mg/50mL = 1mg/mL'),
        _linhaInfo('Infusão', 'Bomba de infusão obrigatória'),
        _linhaInfo('Estabilidade', '8h após reconstituição'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        if (isAdulto) ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'AVC isquêmico agudo',
            descricaoDose: '0,9 mg/kg (máx 90 mg): 10% bolus + 90% infusão em 60 min',
            unidade: 'mg',
            dosePorKg: 0.9,
            doseMaxima: 90,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'IAM com supra',
            descricaoDose: '15 mg bolus → 0,75 mg/kg (máx 50 mg) em 30 min → 0,5 mg/kg (máx 35 mg) em 60 min',
            unidade: 'mg',
            dosePorKgMinima: 0.5,
            dosePorKgMaxima: 0.75,
            doseMaxima: 100,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'TEP maciça',
            descricaoDose: '100 mg IV em 2h ou 0,6 mg/kg em 15 min (até 50 mg)',
            unidade: 'mg',
            dosePorKgMinima: 0.6,
            doseMaxima: 100,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Trombose arterial aguda',
            descricaoDose: '0,5–1 mg/kg IV em 1–2h',
            unidade: 'mg',
            dosePorKgMinima: 0.5,
            dosePorKgMaxima: 1.0,
            peso: peso,
          ),
        ] else ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'AVC pediátrico',
            descricaoDose: '0,9 mg/kg (máx 90 mg): 10% bolus + 90% infusão em 60 min',
            unidade: 'mg',
            dosePorKg: 0.9,
            doseMaxima: 90,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'TEP pediátrica',
            descricaoDose: '0,6 mg/kg IV em 15 min (até 50 mg)',
            unidade: 'mg',
            dosePorKg: 0.6,
            doseMaxima: 50,
            peso: peso,
          ),
        ],

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Ativador do plasminogênio tecidual (rTPA)'),
        _textoObs('• Alto risco de sangramento — avaliar contraindicações'),
        _textoObs('• Monitorar sinais vitais e neurológicos durante e após a infusão'),
        _textoObs('• Contraindicado em sangramento ativo, AVCh, aneurisma, cirurgia recente e plaquetopenia grave'),
        _textoObs('• Não usar anticoagulantes nas primeiras 24h salvo indicação formal'),
        _textoObs('• Janela terapêutica: AVC até 4,5h, IAM até 12h'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Início de ação', 'Imediato'),
        _linhaInfo('Pico de efeito', '30–60 minutos'),
        _linhaInfo('Duração', '4–6 horas'),
        _linhaInfo('Metabolização', 'Hepática'),
        _linhaInfo('Meia-vida', '4–6 minutos'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade ao alteplase'),
        _textoObs('• Sangramento ativo ou recente'),
        _textoObs('• AVC hemorrágico ou história de AVCh'),
        _textoObs('• Aneurisma intracraniano ou malformação vascular'),
        _textoObs('• Cirurgia recente (<14 dias)'),
        _textoObs('• Plaquetopenia grave (<100.000/mm³)'),

        // Reações Adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('Comuns (1–10%): Sangramento, hipotensão, arritmias'),
        _textoObs('Incomuns (0,1–1%): Hemorragia intracraniana, reações alérgicas'),
        _textoObs('Raras (<0,1%): Choque anafilático, morte'),

        // Interações
        const SizedBox(height: 16),
        const Text('Interações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Potencializado por anticoagulantes'),
        _textoObs('• Potencializado por antiagregantes plaquetários'),
        _textoObs('• Antagonizado por antifibrinolíticos'),
        _textoObs('• Cuidado com uso concomitante de AAS'),

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