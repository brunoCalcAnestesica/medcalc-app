import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoSufentanil {
  static const String nome = 'Sufentanil';
  static const String idBulario = 'sufentanil';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/sufentanil.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário do sufentanil: $e');
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
      conteudo: _buildConteudoSufentanil(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoSufentanil(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        
        // Informações Gerais
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Classificação', 'Analgésico opioide; agonista μ-opioide ultrapotente'),
        _linhaInfo('Mecanismo de Ação', 'Agonista seletivo dos receptores μ-opioides no SNC'),
        _linhaInfo('Meia-vida', '2,5-3 horas'),
        _linhaInfo('Pico de ação', '3-5 minutos após IV'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaApresentacao('Ampola 50mcg/mL', '1mL, 2mL, 5mL', 'Sufenta®, Sufentanil Cristália'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('IV direto em bolus lento (≥60 segundos)', ''),
        _linhaPreparo('Infusão contínua com bomba', ''),
        _linhaPreparo('Diluir 100mcg em 50mL SF = 2mcg/mL', ''),
        _linhaPreparo('Diluir 250mcg em 50mL SF = 5mcg/mL', ''),

        // Indicações Clínicas com Cálculo de Dose
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Indução anestésica',
          descricaoDose: '0,3–1 mcg/kg IV lenta',
          unidade: 'mcg',
          dosePorKgMinima: 0.3,
          dosePorKgMaxima: 1.0,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Manutenção anestésica',
          descricaoDose: '0,1–0,5 mcg/kg/h em infusão contínua',
          unidade: 'mcg/kg/h',
          dosePorKgMinima: 0.1,
          dosePorKgMaxima: 0.5,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Sedação em UTI (off-label)',
          descricaoDose: '0,05–0,2 mcg/kg/h em bomba contínua',
          unidade: 'mcg/kg/h',
          dosePorKgMinima: 0.05,
          dosePorKgMaxima: 0.2,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Pediatria',
          descricaoDose: '0,1–0,3 mcg/kg IV lento',
          unidade: 'mcg',
          dosePorKgMinima: 0.1,
          dosePorKgMaxima: 0.3,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Intratecal (adjuvante)',
          descricaoDose: '2,5–10 mcg',
          unidade: 'mcg',
          doseMinima: 2.5,
          doseMaxima: 10,
          peso: peso,
        ),

        // Cálculo de Infusão
        const SizedBox(height: 16),
        const Text('Cálculo de Infusão', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        ConversaoInfusaoSlider(
          peso: peso,
          opcoesConcentracoes: {
            '100mcg/50mL (2mcg/mL)': 2,
            '250mcg/50mL (5mcg/mL)': 5,
          },
          unidade: 'mcg/kg/h',
          doseMin: 0.05,
          doseMax: 0.5,
        ),

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Opioide μ agonista — potência ~10x maior que o fentanil'),
        _textoObs('• Início rápido (1–3 min) e meia-vida curta (~30 min)'),
        _textoObs('• Controle hemodinâmico excelente em anestesia balanceada'),
        _textoObs('• Pode causar rigidez torácica — administrar lentamente'),
        _textoObs('• Monitorar sedação, FR e acúmulo em infusão prolongada'),
        _textoObs('• Efeito cumulativo significativo em infusões longas'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfo('Absorção', 'Rápida (IV: 100%)'),
        _linhaInfo('Distribuição', 'Volume: 2-4 L/kg; Ligação: >90%'),
        _linhaInfo('Metabolismo', 'Hepático (CYP3A4)'),
        _linhaInfo('Excreção', 'Renal (75% metabólitos, 10% inalterado)'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade a sufentanil ou outros opioides'),
        _textoObs('• Depressão respiratória sem suporte'),
        _textoObs('• Hipertensão intracraniana sem controle ventilatório'),
        _textoObs('• Uso isolado em pacientes não monitorizados'),

        // Reações Adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Muito comuns: bradipneia, sedação, náusea'),
        _textoObs('• Comuns: prurido, hipotensão, rigidez torácica'),
        _textoObs('• Incomuns: depressão respiratória prolongada, rigidez muscular'),
        _textoObs('• Raras: reações anafiláticas, delírio, alucinações'),

        // Interações
        const SizedBox(height: 16),
        const Text('Interações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Potencializa efeitos de benzodiazepínicos, propofol'),
        _textoObs('• Depressão respiratória aumentada com barbitúricos e álcool'),
        _textoObs('• Inibidores do CYP3A4 aumentam exposição sistêmica'),
        _textoObs('• Pode potencializar bloqueadores neuromusculares'),

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

  static Widget _linhaApresentacao(String apresentacao, String concentracao, String observacao) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(child: Text(apresentacao)),
          const SizedBox(width: 8),
          Text(concentracao, style: const TextStyle(fontWeight: FontWeight.w500)),
          if (observacao.isNotEmpty) ...[
            const SizedBox(width: 8),
            Flexible(child: Text(observacao, style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 12))),
          ]
        ],
      ),
    );
  }

  static Widget _linhaPreparo(String texto, String obs) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(child: Text(texto)),
          if (obs.isNotEmpty) ...[
            const SizedBox(width: 8),
            Flexible(child: Text(obs, style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 12))),
          ]
        ],
      ),
    );
  }

  static Widget _linhaIndicacaoDoseCalculada({
    required String titulo,
    required String descricaoDose,
    String? unidade,
    double? dosePorKg,
    double? dosePorKgMinima,
    double? dosePorKgMaxima,
    double? doseMaxima,
    double? doseMinima,
    required double peso,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titulo, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(descricaoDose, style: const TextStyle(fontSize: 13)),
          if (dosePorKg != null && unidade != null) 
            Text('Dose: ${(dosePorKg * peso).toStringAsFixed(2)} $unidade', 
                 style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.blue)),
          if (dosePorKgMinima != null && dosePorKgMaxima != null && unidade != null)
            Text('Dose: ${(dosePorKgMinima * peso).toStringAsFixed(2)}–${(dosePorKgMaxima * peso).toStringAsFixed(2)} $unidade', 
                 style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.blue)),
          if (doseMinima != null && doseMaxima != null && unidade != null)
            Text('Dose: $doseMinima–$doseMaxima $unidade', 
                 style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.blue)),
          if (doseMaxima != null && unidade != null && doseMinima == null) 
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