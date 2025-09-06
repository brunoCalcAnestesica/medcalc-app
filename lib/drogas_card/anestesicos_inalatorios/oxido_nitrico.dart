import 'package:flutter/material.dart';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoOxidoNitrico {
  static const String nome = 'Óxido Nítrico';
  static const String idBulario = 'oxido_nitrico';

  static Widget buildCard(BuildContext context, Set<String> favoritos, void Function(String) onToggleFavorito) {
    final peso = SharedData.peso ?? 70;
    final faixaEtaria = SharedData.faixaEtaria ?? '';
    final isAdulto = faixaEtaria == 'Adulto' || faixaEtaria == 'Idoso';
    final isFavorito = favoritos.contains(nome);

    return buildMedicamentoExpansivel(
      context: context,
      nome: nome,
      idBulario: idBulario,
      isFavorito: isFavorito,
      onToggleFavorito: () => onToggleFavorito(nome),
      conteudo: _buildCardOxidoNitrico(context, peso, isAdulto, faixaEtaria),
    );
  }

  static Widget _buildCardOxidoNitrico(BuildContext context, double peso, bool isAdulto, String faixaEtaria) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const Text('Óxido Nítrico', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        if (faixaEtaria.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 8),
            child: Text(
              'Faixa etária: $faixaEtaria',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.indigo),
            ),
          ),
        const Text('Apresentação', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('Gás medicinal pressurizado (800-1000 ppm)', 'INOmax®, INOvent®, genéricos'),
        const SizedBox(height: 16),
        const Text('Administração', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('Via inalatória através de ventilador mecânico', ''),
        _linhaPreparo('Sistema de entrega dedicado com monitoramento contínuo', ''),
        _linhaPreparo('Diluição em O₂ ou ar para concentração final', ''),
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Hipertensão pulmonar neonatal',
          descricaoDose: 'Início: 20 ppm → titulação 5-10 ppm (máx 80 ppm)',
          unidade: 'ppm',
          dosePorKgMinima: 20,
          dosePorKgMaxima: 80,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Hipertensão pulmonar pediátrica',
          descricaoDose: 'Início: 20 ppm → titulação conforme resposta (máx 80 ppm)',
          unidade: 'ppm',
          dosePorKgMinima: 20,
          dosePorKgMaxima: 80,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'SDRA (Síndrome do Desconforto Respiratório Agudo)',
          descricaoDose: '5-20 ppm para melhora da oxigenação',
          unidade: 'ppm',
          dosePorKgMinima: 5,
          dosePorKgMaxima: 20,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Hipertensão pulmonar pós-cirúrgica',
          descricaoDose: '10-40 ppm para redução da pressão arterial pulmonar',
          unidade: 'ppm',
          dosePorKgMinima: 10,
          dosePorKgMaxima: 40,
          peso: peso,
        ),
        _linhaIndicacaoDoseCalculada(
          titulo: 'Crise de hipertensão pulmonar',
          descricaoDose: '20-80 ppm para emergência (máx 24-48h)',
          unidade: 'ppm',
          dosePorKgMinima: 20,
          dosePorKgMaxima: 80,
          peso: peso,
        ),
        const SizedBox(height: 16),
        const Text('Titulação e Desmame', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('Reduzir gradualmente: 5-10 ppm a cada 30-60 min', ''),
        _linhaPreparo('Monitorar SpO₂, pressão arterial e função cardíaca', ''),
        _linhaPreparo('Descontinuar se não houver resposta em 4-6h', ''),
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Vasodilatador pulmonar seletivo - não afeta pressão sistêmica.'),
        _textoObs('• Monitorar metemoglobinemia (máx 5%) e NO₂ (< 2 ppm).'),
        _textoObs('• Efeito rebote pode ocorrer com descontinuação abrupta.'),
        _textoObs('• Contraindicado em metemoglobinemia > 3% ou NO₂ > 2 ppm.'),
        _textoObs('• Custo elevado - reservar para casos selecionados.'),
        _textoObs('• Duração máxima: 14 dias (neonatos) ou 28 dias (pediátricos).'),
      ],
    );
  }

  static Widget _linhaPreparo(String texto, String marca) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black87),
                children: [
                  TextSpan(text: texto),
                  if (marca.isNotEmpty) ...[
                    const TextSpan(text: ' | ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: marca, style: const TextStyle(fontStyle: FontStyle.italic)),
                  ],
                ],
              ),
            ),
          ),
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
    required double peso,
  }) {
    double? doseCalculada;
    String? textoDose;

    if (dosePorKg != null) {
      doseCalculada = dosePorKg * peso;
      textoDose = '${doseCalculada.toStringAsFixed(1)} $unidade';
    } else if (dosePorKgMinima != null && dosePorKgMaxima != null) {
      double doseMin = dosePorKgMinima * peso;
      double doseMax = dosePorKgMaxima * peso;
      if (doseMaxima != null) {
        doseMax = doseMax > doseMaxima ? doseMaxima : doseMax;
      }
      textoDose = '${doseMin.toStringAsFixed(1)}–${doseMax.toStringAsFixed(1)} $unidade';
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
          if (textoDose != null) ...[
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Text(
                'Dose calculada: $textoDose',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade700,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  static Widget _textoObs(String texto) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(texto)),
        ],
      ),
    );
  }
} 