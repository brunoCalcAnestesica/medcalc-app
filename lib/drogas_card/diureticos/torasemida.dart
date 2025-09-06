import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoTorasemida {
  static const String nome = 'Torasemida';
  static const String idBulario = 'torasemida';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/torasemida.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário da torasemida: $e');
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
      conteudo: _buildConteudoTorasemida(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoTorasemida(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Torrex®, Demadex®, Torasemida®'),
        _linhaInfo('Classificação', 'Diurético de alça'),
        _linhaInfo('Mecanismo', 'Inibição da reabsorção de Na⁺/K⁺/Cl⁻ no ramo ascendente'),
        _linhaInfo('Potência', 'Mais potente e duradouro que furosemida'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Comprimidos', '5mg, 10mg, 20mg'),
        _linhaInfo('Forma', 'Comprimidos revestidos'),
        _linhaInfo('Biodisponibilidade', '~90% (alta)'),
        _linhaInfo('Via', 'Principalmente oral'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Via oral', 'Uso direto'),
        _linhaInfo('Via IV', 'Disponível em alguns países'),
        _linhaInfo('Início de ação', '1h VO'),
        _linhaInfo('Duração', '6–8h'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        if (isAdulto) ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Insuficiência cardíaca / Edema',
            descricaoDose: '10–40 mg VO/dia',
            unidade: 'mg',
            doseMaxima: 40,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Hipertensão arterial',
            descricaoDose: '5–10 mg VO/dia',
            unidade: 'mg',
            doseMaxima: 10,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'IRC / Síndrome nefrótica',
            descricaoDose: '20–40 mg VO/dia',
            unidade: 'mg',
            doseMaxima: 40,
            peso: peso,
          ),
        ] else ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Uso off-label pediátrico',
            descricaoDose: '0,1–0,2 mg/kg/dose VO 1–2x/dia (máx 5mg)',
            unidade: 'mg',
            dosePorKgMinima: 0.1,
            dosePorKgMaxima: 0.2,
            doseMaxima: 5,
            peso: peso,
          ),
        ],

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Diurético de alça mais potente e duradouro que a furosemida'),
        _textoObs('• Alta biodisponibilidade VO (~90%)'),
        _textoObs('• Monitorar eletrólitos e função renal'),
        _textoObs('• Menor ototoxicidade que furosemida'),
        _textoObs('• Metabolização hepática extensa'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Início de ação', '30–60 minutos (VO)'),
        _linhaInfo('Pico de efeito', '2–4 horas (VO)'),
        _linhaInfo('Duração', '6–8 horas'),
        _linhaInfo('Metabolização', 'Hepática extensa (CYP2C9)'),
        _linhaInfo('Eliminação', 'Renal (80%) e hepática (20%)'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade à torasemida'),
        _textoObs('• Anúria'),
        _textoObs('• Hipovolemia grave'),
        _textoObs('• Alcalose metabólica'),

        // Reações Adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('Comuns (1–10%): Hipocalemia, hiponatremia, hipovolemia'),
        _textoObs('Incomuns (0,1–1%): Ototoxicidade, hiperuricemia'),
        _textoObs('Raras (<0,1%): Pancreatite, discrasias sanguíneas'),

        // Interações
        const SizedBox(height: 16),
        const Text('Interações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Potencializa digitálicos'),
        _textoObs('• Interfere com lítio'),
        _textoObs('• Inibidores CYP2C9 aumentam concentração'),

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
