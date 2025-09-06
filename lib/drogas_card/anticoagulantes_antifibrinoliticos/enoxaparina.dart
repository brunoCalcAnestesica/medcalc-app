import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoEnoxaparina {
  static const String nome = 'Enoxaparina';
  static const String idBulario = 'enoxaparina';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/enoxaparina.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário da enoxaparina: $e');
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
      conteudo: _buildConteudoEnoxaparina(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoEnoxaparina(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Clexane®, Versa®, Enoxaparina®'),
        _linhaInfo('Classificação', 'Heparina de baixo peso molecular'),
        _linhaInfo('Mecanismo', 'Inibidor do fator Xa'),
        _linhaInfo('Duração', '12-24 horas'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Seringa 20mg', '0,2mL'),
        _linhaInfo('Seringa 40mg', '0,4mL'),
        _linhaInfo('Seringa 60mg', '0,6mL'),
        _linhaInfo('Seringa 80mg', '0,8mL'),
        _linhaInfo('Seringa 100mg', '1,0mL'),
        _linhaInfo('Seringa 120mg', '1,2mL'),
        _linhaInfo('Forma', 'Solução injetável'),
        _linhaInfo('Via', 'SC'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Aplicação', 'SC profunda na parede abdominal'),
        _linhaInfo('Local alternativo', 'Face externa da coxa'),
        _linhaInfo('Cuidado', 'Não massagear após aplicação'),
        _linhaInfo('Estabilidade', 'Pré-preenchida, pronta para uso'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        if (isAdulto) ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Profilaxia de trombose (clínico ou pós-operatório)',
            descricaoDose: '40 mg SC 1x/dia (ou 20 mg 1x/dia se IR grave)',
            unidade: 'mg',
            dosePorKg: 40 / peso,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Tratamento de TEV (TVP/TEP)',
            descricaoDose: '1 mg/kg SC a cada 12h ou 1,5 mg/kg 1x/dia',
            unidade: 'mg',
            dosePorKgMinima: 1.0,
            dosePorKgMaxima: 1.5,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Síndrome coronariana aguda (SCA)',
            descricaoDose: '1 mg/kg SC a cada 12h por 2–8 dias (máx 100 mg/dose)',
            unidade: 'mg',
            dosePorKg: 1.0,
            doseMaxima: 100,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Profilaxia em cirurgia ortopédica',
            descricaoDose: '40 mg SC 1x/dia (ou 30 mg 2x/dia)',
            unidade: 'mg',
            dosePorKg: 40 / peso,
            peso: peso,
          ),
        ] else ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Trombose venosa pediátrica (off-label)',
            descricaoDose: '1,5 mg/kg SC 1x/dia ou 1 mg/kg a cada 12h (ajustar conforme anti-Xa)',
            unidade: 'mg',
            dosePorKgMinima: 1.0,
            dosePorKgMaxima: 1.5,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Profilaxia pediátrica',
            descricaoDose: '0,5 mg/kg SC 1x/dia',
            unidade: 'mg',
            dosePorKg: 0.5,
            peso: peso,
          ),
        ],

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Heparina de baixo peso molecular com ação anti-Xa predominante'),
        _textoObs('• Não requer monitoramento de rotina se função renal normal'),
        _textoObs('• Ajustar dose se ClCr < 30 mL/min'),
        _textoObs('• Contraindicada em sangramento ativo, TIH e neurocirurgias recentes'),
        _textoObs('• Antídoto parcial: protamina (1 mg para cada 1 mg de enoxaparina se <8h da dose)'),
        _textoObs('• Monitorar anti-Xa em gestantes e insuficiência renal'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Início de ação', '2–4 horas'),
        _linhaInfo('Pico de efeito', '3–5 horas'),
        _linhaInfo('Duração', '12–24 horas'),
        _linhaInfo('Metabolização', 'Renal (40%)'),
        _linhaInfo('Meia-vida', '4–7 horas'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade à enoxaparina'),
        _textoObs('• Sangramento ativo ou recente'),
        _textoObs('• Trombocitopenia induzida por heparina (TIH)'),
        _textoObs('• Neurocirurgia recente (<24h)'),
        _textoObs('• Insuficiência renal grave (ClCr <15 mL/min)'),

        // Reações Adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('Comuns (1–10%): Hematoma no local da injeção, sangramento'),
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