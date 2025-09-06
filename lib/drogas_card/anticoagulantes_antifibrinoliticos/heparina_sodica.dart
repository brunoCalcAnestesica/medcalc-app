import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoHeparinaSodica {
  static const String nome = 'Heparina Sódica';
  static const String idBulario = 'heparina_sodica';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/heparina_sodica.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário da heparina sódica: $e');
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
      conteudo: _buildConteudoHeparinaSodica(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoHeparinaSodica(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Liquemine®, Heparina Sódica®'),
        _linhaInfo('Classificação', 'Heparina não fracionada'),
        _linhaInfo('Mecanismo', 'Via antitrombina III (inibe trombina e fator Xa)'),
        _linhaInfo('Duração', '4-6 horas'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Ampola 5.000 UI/mL', '1mL'),
        _linhaInfo('Ampola 25.000 UI/5mL', '5mL'),
        _linhaInfo('Forma', 'Solução injetável'),
        _linhaInfo('Via', 'IV, SC'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('IV direta', 'Bolus direto'),
        _linhaInfo('Infusão', 'Diluir em 100–250mL SG 5% ou SF 0,9%'),
        _linhaInfo('SC', 'Aplicação subcutânea'),
        _linhaInfo('Estabilidade', '24h após diluição'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        if (isAdulto) ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'TEV (TVP/TEP) – tratamento',
            descricaoDose: 'Bolus 5.000 UI IV → infusão contínua 18 UI/kg/h com TTPa alvo',
            unidade: 'UI',
            dosePorKg: 18,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Síndrome coronariana aguda',
            descricaoDose: '60 UI/kg IV bolus (máx 5.000 UI) + 12–15 UI/kg/h IV contínuo',
            unidade: 'UI',
            dosePorKgMinima: 12,
            dosePorKgMaxima: 15,
            doseMaxima: 5000,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Profilaxia de TEV (SC)',
            descricaoDose: '5.000 UI SC a cada 8–12h (não monitorar TTPa)',
            unidade: 'UI',
            dosePorKg: 5000 / peso,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Circulação extracorpórea',
            descricaoDose: '300–400 UI/kg IV bolus + 100–150 UI/kg/h',
            unidade: 'UI',
            dosePorKgMinima: 300,
            dosePorKgMaxima: 400,
            peso: peso,
          ),
        ] else ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'TEV pediátrica – tratamento',
            descricaoDose: 'Bolus 75 UI/kg IV → infusão contínua 20 UI/kg/h',
            unidade: 'UI',
            dosePorKg: 20,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Profilaxia pediátrica (SC)',
            descricaoDose: '50 UI/kg SC a cada 8–12h',
            unidade: 'UI',
            dosePorKg: 50,
            peso: peso,
          ),
        ],

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Anticoagulante parenteral via antitrombina III'),
        _textoObs('• Necessário monitorar TTPa (alvo: 1,5 a 2,5x controle) nas infusões'),
        _textoObs('• Reversível com protamina (1 mg para cada 100 UI de heparina nas últimas 60 min)'),
        _textoObs('• Risco de TIH (trombocitopenia induzida por heparina) — monitorar plaquetas'),
        _textoObs('• Preferir enoxaparina quando possível em situações ambulatoriais'),
        _textoObs('• Monitorar plaquetas diariamente nos primeiros 5 dias'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Início de ação', 'Imediato (IV)'),
        _linhaInfo('Pico de efeito', '2–4 horas'),
        _linhaInfo('Duração', '4–6 horas'),
        _linhaInfo('Metabolização', 'Hepática (80%)'),
        _linhaInfo('Meia-vida', '1–2 horas'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade à heparina'),
        _textoObs('• Sangramento ativo ou recente'),
        _textoObs('• Trombocitopenia induzida por heparina (TIH)'),
        _textoObs('• Cirurgia recente (<24h)'),
        _textoObs('• Hemorragia intracraniana'),

        // Reações Adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('Comuns (1–10%): Sangramento, hematoma no local da injeção'),
        _textoObs('Incomuns (0,1–1%): Trombocitopenia, reações alérgicas'),
        _textoObs('Raras (<0,1%): Necrose cutânea, osteoporose'),

        // Interações
        const SizedBox(height: 16),
        const Text('Interações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Potencializado por outros anticoagulantes'),
        _textoObs('• Potencializado por antiagregantes plaquetários'),
        _textoObs('• Antagonizado por protamina'),
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