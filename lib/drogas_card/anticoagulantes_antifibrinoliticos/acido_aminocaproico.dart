import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoAcidoAminocaproico {
  static const String nome = 'Ácido Aminocaproico';
  static const String idBulario = 'acido_aminocaproico';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/acido_aminocaproico.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário do ácido aminocaproico: $e');
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
      conteudo: _buildConteudoAcidoAminocaproico(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoAcidoAminocaproico(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informações Gerais
        const SizedBox(height: 16),
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Nome comercial', 'Amicar®, Ácido Aminocaproico®'),
        _linhaInfo('Classificação', 'Antifibrinolítico'),
        _linhaInfo('Mecanismo', 'Inibidor da conversão de plasminogênio em plasmina'),
        _linhaInfo('Duração', '6-8 horas'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Frasco 5g/100mL', '50mg/mL'),
        _linhaInfo('Forma', 'Solução injetável'),
        _linhaInfo('Via', 'IV, VO'),
        _linhaInfo('Comprimidos', '500mg, 1000mg'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('IV direta', 'Pode ser usado direto'),
        _linhaInfo('Infusão', 'Diluir em SF ou SG 5%'),
        _linhaInfo('Tempo', '10-30 minutos'),
        _linhaInfo('Estabilidade', '24h após diluição'),

        // Indicações Clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        if (isAdulto) ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Hiperfibrinólise em cirurgia',
            descricaoDose: 'Carga: 4–5 g IV em 1h → Manutenção: 1 g/h por até 8h',
            unidade: 'g',
            dosePorKgMinima: 4 / peso,
            dosePorKgMaxima: 5 / peso,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Hemorragias em coagulopatias',
            descricaoDose: '100–150 mg/kg IV cada 6h (máx 30 g/dia)',
            unidade: 'mg',
            dosePorKgMinima: 100,
            dosePorKgMaxima: 150,
            doseMaxima: 30000,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Uso oral profilático',
            descricaoDose: '1–2 g VO 3–4x/dia (máx 8 g/dia)',
            unidade: 'g',
            dosePorKg: 1,
            doseMaxima: 2,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Hemorragia aguda',
            descricaoDose: '4–5 g IV em 1h → Manutenção: 1 g/h por até 8h',
            unidade: 'g',
            dosePorKgMinima: 4 / peso,
            dosePorKgMaxima: 5 / peso,
            peso: peso,
          ),
        ] else ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Hiperfibrinólise pediátrica',
            descricaoDose: 'Carga: 100–150 mg/kg IV em 1h → Manutenção: 15–30 mg/kg/h',
            unidade: 'mg',
            dosePorKgMinima: 100,
            dosePorKgMaxima: 150,
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Hemorragias pediátricas',
            descricaoDose: '100–150 mg/kg IV cada 6h (máx 30 g/dia)',
            unidade: 'mg',
            dosePorKgMinima: 100,
            dosePorKgMaxima: 150,
            doseMaxima: 30000,
            peso: peso,
          ),
        ],

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Antifibrinolítico que bloqueia a conversão de plasminogênio em plasmina'),
        _textoObs('• Alternativa ao ácido tranexâmico'),
        _textoObs('• Cuidado em insuficiência renal e risco de trombose'),
        _textoObs('• Contraindicado em hematuria macroscópica de origem renal'),
        _textoObs('• Monitorar função renal em uso prolongado'),
        _textoObs('• Pode causar hipotensão se infundido rapidamente'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Início de ação', 'Imediato (IV)'),
        _linhaInfo('Pico de efeito', '1–2 horas'),
        _linhaInfo('Duração', '6–8 horas'),
        _linhaInfo('Metabolização', 'Renal (80%)'),
        _linhaInfo('Meia-vida', '1–2 horas'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade ao ácido aminocaproico'),
        _textoObs('• Hematuria macroscópica de origem renal'),
        _textoObs('• Trombose ativa ou história de trombose'),
        _textoObs('• Insuficiência renal grave (ClCr <30 mL/min)'),
        _textoObs('• Distúrbios da coagulação congênitos'),

        // Reações Adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('Comuns (1–10%): Náusea, vômitos, diarreia, hipotensão'),
        _textoObs('Incomuns (0,1–1%): Trombose, rabdomiólise'),
        _textoObs('Raras (<0,1%): Reações alérgicas, insuficiência renal'),

        // Interações
        const SizedBox(height: 16),
        const Text('Interações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Potencializado por outros antifibrinolíticos'),
        _textoObs('• Pode aumentar risco de trombose com anticoagulantes'),
        _textoObs('• Sem interações significativas com outros medicamentos'),
        _textoObs('• Cuidado com uso concomitante de estrogênios'),

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