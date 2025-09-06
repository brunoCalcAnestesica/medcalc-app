import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoRemifentanil {
  static const String nome = 'Remifentanil';
  static const String idBulario = 'remifentanil';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/remifentanil.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário do remifentanil: $e');
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
      conteudo: _buildConteudoRemifentanil(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoRemifentanil(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        
        // Informações Gerais
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfoEmpilhada('Classificação', 'Analgésico opioide; agonista μ-opioide ultrapotente'),
        _linhaInfoEmpilhada('Mecanismo de Ação', 'Agonista seletivo dos receptores μ-opioides no SNC'),
        _linhaInfoEmpilhada('Meia-vida', '3-10 minutos (contexto-independente)'),
        _linhaInfoEmpilhada('Pico de ação', '1-2 minutos após IV'),

        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaApresentacaoEmpilhada('Frasco liofilizado', '1mg, 2mg, 5mg', 'Ultiva®'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparoEmpilhada('Diluir 2mg em 40mL SF = 50mcg/mL', ''),
        _linhaPreparoEmpilhada('Diluir 5mg em 100mL SF = 50mcg/mL', ''),
        _linhaPreparoEmpilhada('Uso exclusivo em infusão contínua', 'Não administrar em bolus'),

        // Indicações Clínicas com Cálculo de Dose
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaIndicacaoDoseCalculadaEmpilhada(
          titulo: 'Indução e manutenção anestésica',
          descricaoDose: '0,5–1 mcg/kg/min IV contínua',
          unidade: 'mcg/kg/min',
          dosePorKgMinima: 0.5,
          dosePorKgMaxima: 1.0,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculadaEmpilhada(
          titulo: 'Sedação em UTI / procedimentos',
          descricaoDose: '0,05–0,2 mcg/kg/min IV contínua',
          unidade: 'mcg/kg/min',
          dosePorKgMinima: 0.05,
          dosePorKgMaxima: 0.2,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculadaEmpilhada(
          titulo: 'Analgesia pós-operatória (PCA)',
          descricaoDose: '0,025–0,1 mcg/kg/min IV contínua',
          unidade: 'mcg/kg/min',
          dosePorKgMinima: 0.025,
          dosePorKgMaxima: 0.1,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculadaEmpilhada(
          titulo: 'Pediatria',
          descricaoDose: '0,05–0,3 mcg/kg/min IV contínua',
          unidade: 'mcg/kg/min',
          dosePorKgMinima: 0.05,
          dosePorKgMaxima: 0.3,
          peso: peso,
        ),

        // Cálculo de Infusão
        const SizedBox(height: 16),
        const Text('Cálculo de Infusão', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        ConversaoInfusaoSlider(
          peso: peso,
          opcoesConcentracoes: {
            '2mg/40mL (50mcg/mL)': 50,
            '5mg/100mL (50mcg/mL)': 50,
          },
          unidade: 'mcg/kg/min',
          doseMin: 0.025,
          doseMax: 1.0,
        ),

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Opioide μ agonista com meia-vida ultrarrápida (3–10 min)'),
        _textoObs('• Metabolizado por esterases plasmáticas — não depende de função hepática/renal'),
        _textoObs('• Controle preciso da analgesia — sem acúmulo'),
        _textoObs('• Pode causar rigidez torácica, bradicardia e depressão respiratória'),
        _textoObs('• Monitorização contínua obrigatória de FR, SpO₂ e sedação'),
        _textoObs('• Risco de hiperalgesia de rebote se suspenso abruptamente'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaInfoEmpilhada('Absorção', 'Rápida (IV: 100%)'),
        _linhaInfoEmpilhada('Distribuição', 'Volume: 0,3-0,4 L/kg; Ligação: 70%'),
        _linhaInfoEmpilhada('Metabolismo', 'Esterases plasmáticas e teciduais'),
        _linhaInfoEmpilhada('Excreção', 'Urinária (ácido carboxílico inativo)'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade conhecida ao remifentanil'),
        _textoObs('• Uso fora de ambiente monitorado'),
        _textoObs('• Administração epidural ou intratecal'),
        _textoObs('• Infusão prolongada sem analgesia complementar'),

        // Reações Adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Muito comuns: hipotensão, bradicardia, rigidez muscular'),
        _textoObs('• Comuns: bradipneia, náusea, tremores, apneia'),
        _textoObs('• Incomuns: hiperalgesia de rebote, disforia, agitação pós-operatória'),
        _textoObs('• Raras: arritmias, depressão respiratória prolongada, laringoespasmo'),

        // Interações
        const SizedBox(height: 16),
        const Text('Interações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Potencializa sedação e apneia com benzodiazepínicos, propofol'),
        _textoObs('• Potencialização de bloqueadores neuromusculares'),
        _textoObs('• Risco de bradicardia com betabloqueadores'),
        _textoObs('• Sinergia analgésica com dexmedetomidina e sevoflurano'),

        const SizedBox(height: 16),
      ],
    );
  }

  static Widget _linhaInfoEmpilhada(String titulo, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titulo, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(valor, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }

  static Widget _linhaApresentacaoEmpilhada(String apresentacao, String concentracao, String observacao) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(apresentacao, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(concentracao, style: const TextStyle(fontSize: 13)),
          if (observacao.isNotEmpty)
            Text(observacao, style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 12)),
        ],
      ),
    );
  }

  static Widget _linhaPreparoEmpilhada(String texto, String obs) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(texto, style: const TextStyle(fontWeight: FontWeight.w500)),
          if (obs.isNotEmpty)
            Text(obs, style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 12)),
        ],
      ),
    );
  }

  static Widget _linhaIndicacaoDoseCalculadaEmpilhada({
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
      padding: const EdgeInsets.symmetric(vertical: 6),
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