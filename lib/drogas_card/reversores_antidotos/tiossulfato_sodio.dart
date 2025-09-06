import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoTiossulfatoSodio {
  static const String nome = 'Tiossulfato de Sódio';
  static const String idBulario = 'tiossulfato_sodio';

  static Future<Map<String, dynamic>> carregarBulario() async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/medicamentos/tiossulfato_sodio.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return jsonMap['PT']['bulario'];
    } catch (e) {
      print('Erro ao carregar bulário do tiossulfato de sódio: $e');
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
      conteudo: _buildConteudoTiossulfatoSodio(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoTiossulfatoSodio(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        
        // Informações gerais
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Antídoto para intoxicação por cianeto'),
        _textoObs('• Agente quelante'),
        _textoObs('• Doador de enxofre para enzima rodanase'),
        _textoObs('• Converte cianeto em tiocianato (menos tóxico)'),
        _textoObs('• Excretado pelos rins'),
        
        // Apresentações
        const SizedBox(height: 16),
        const Text('Apresentações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('Frasco 25%, 12,5g/50mL (250mg/mL)', 'Sodium Thiosulfate®'),
        _linhaPreparo('Ampolas de 10 mL (2,5 g) ou 50 mL (12,5 g)', 'uso IV'),

        // Preparo
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('IV lenta em 10–20 min', ''),
        _linhaPreparo('Não misturar com nitrito ou cianokit na mesma seringa', ''),
        _linhaPreparo('Pode ser diluído em SF 0,9% ou SG 5%', ''),
        _linhaPreparo('Pronto para uso', ''),

        // Indicações clínicas
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        _linhaIndicacaoDoseCalculada(
          titulo: 'Intoxicação por cianeto (adjuvante)',
          descricaoDose: '12,5g IV (50mL da solução 25%)',
          unidade: 'g',
          doseMaxima: 12.5,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Calcifilaxia',
          descricaoDose: '12,5–25g IV 3x/semana após hemodiálise',
          unidade: 'g',
          doseMaxima: 25,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Toxicidade por cisplatina',
          descricaoDose: '4g/m² IV antes + 12g/m² em 6h',
          unidade: 'g',
          doseMaxima: 12,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Intoxicações por metais pesados',
          descricaoDose: '10–15g IV lenta',
          unidade: 'g',
          doseMaxima: 15,
          peso: peso,
        ),

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Conversão de cianeto em tiocianato, excretado renalmente.'),
        _textoObs('• Usado como adjuvante ao lado da hidroxicobalamina.'),
        _textoObs('• Não misturar com nitrito na mesma via.'),
        _textoObs('• Monitorar pressão arterial durante infusão.'),
        _textoObs('• Observar sinais de sobrecarga volêmica.'),
        _textoObs('• Acompanhar níveis de tiocianato em uso prolongado.'),

        // Metabolismo
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Início de ação: imediato (antídoto).'),
        _textoObs('• Pico de efeito: minutos.'),
        _textoObs('• Meia-vida: 15–20 minutos (fase inicial), até 200 minutos (eliminação terminal).'),
        _textoObs('• Volume de distribuição: 0,15–0,2 L/kg.'),
        _textoObs('• Ligação às proteínas plasmáticas: desprezível.'),
        _textoObs('• Metabolização: mínima.'),
        _textoObs('• Excreção: predominantemente renal, como tiocianato.'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade conhecida ao tiossulfato de sódio.'),
        _textoObs('• Hipervolemia não controlada.'),
        _textoObs('• Insuficiência cardíaca congestiva descompensada.'),
        _textoObs('• Uso isolado sem outros antídotos para cianeto.'),

        // Reações adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Muito comuns: náusea, vômito, dor no local da infusão, sensação de calor, rubor.'),
        _textoObs('• Comuns: hipotensão transitória, cefaleia, tontura, alteração do paladar (gosto metálico).'),
        _textoObs('• Incomuns: edema facial, urticária, dispneia.'),
        _textoObs('• Raras: anafilaxia, hipotensão severa, hipervolemia e insuficiência cardíaca congestiva.'),

        // Interações medicamentosas
        const SizedBox(height: 16),
        const Text('Interações Medicamentosas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Potencialização da hipotensão quando associado a outros vasodilatadores.'),
        _textoObs('• Potencial interação teórica com agentes nefrotóxicos.'),
        _textoObs('• Pode interferir em alguns testes laboratoriais colorimétricos.'),
        _textoObs('• Incompatível com soluções ácidas e alguns agentes oxidantes.'),

        const SizedBox(height: 16),
      ],
    );
  }

  static Widget _linhaPreparo(String texto, String observacao) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(
              texto,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          if (observacao.isNotEmpty)
            Text(
              ' ($observacao)',
              style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
        ],
      ),
    );
  }

  static Widget _linhaIndicacaoDoseCalculada({
    required String titulo,
    required String descricaoDose,
    String unidade = '',
    double? dosePorKg,
    double? dosePorKgMinima,
    double? dosePorKgMaxima,
    double? doseMaxima,
    required double peso,
  }) {
    double? doseCalculada;
    double? doseCalculadaMin;
    double? doseCalculadaMax;

    if (dosePorKg != null) {
      doseCalculada = dosePorKg * peso;
      if (doseMaxima != null && doseCalculada > doseMaxima) {
        doseCalculada = doseMaxima;
      }
    }

    if (dosePorKgMinima != null) {
      doseCalculadaMin = dosePorKgMinima * peso;
      if (doseMaxima != null && doseCalculadaMin > doseMaxima) {
        doseCalculadaMin = doseMaxima;
      }
    }

    if (dosePorKgMaxima != null) {
      doseCalculadaMax = dosePorKgMaxima * peso;
      if (doseMaxima != null && doseCalculadaMax > doseMaxima) {
        doseCalculadaMax = doseMaxima;
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            descricaoDose,
            style: const TextStyle(fontSize: 13),
          ),
          if (doseCalculada != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                'Dose calculada: ${doseCalculada.toStringAsFixed(1)} $unidade',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
            ),
          if (doseCalculadaMin != null && doseCalculadaMax != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                'Dose calculada: ${doseCalculadaMin.toStringAsFixed(1)}–${doseCalculadaMax.toStringAsFixed(1)} $unidade',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
            ),
        ],
      ),
    );
  }

  static Widget _textoObs(String texto) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        texto,
        style: const TextStyle(fontSize: 13),
      ),
    );
  }
} 