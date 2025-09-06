import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoEsmolol {
  static const String nome = 'Esmolol';
  static const String idBulario = 'esmolol';

  static Future<Map<String, dynamic>> carregarBulario() async {
    final String jsonStr = await rootBundle.loadString('assets/medicamentos/esmolol.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonStr);
    return jsonMap['PT']['bulario'];
  }

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
      conteudo: _buildCardEsmolol(context, peso, isAdulto, faixaEtaria),
    );
  }

  static Widget _buildCardEsmolol(BuildContext context, double peso, bool isAdulto, String faixaEtaria) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const Text('Esmolol', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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
        _linhaPreparo('Frasco 100mg/10mL ou 2500mg/250mL (10mg/mL)', 'Brevibloc®'),
        _linhaPreparo('Ampola 100mg/10mL (10mg/mL)', ''),
        const SizedBox(height: 16),
        const Text('Preparo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('100mg em 10mL = bolus (10mg/mL)', ''),
        _linhaPreparo('2500mg em 250mL SF = 10mg/mL para infusão', ''),
        _linhaPreparo('100mg em 100mL SG 5%', '1 mg/mL'),
        _linhaPreparo('200mg em 100mL SG 5%', '2 mg/mL'),
        const SizedBox(height: 16),
        const Text('Indicações Clínicas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        if (faixaEtaria == 'Recém-nascido') ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Taquicardia neonatal',
            descricaoDose: 'Bolus: 500 mcg/kg IV em 1 min, seguido de 50 mcg/kg/min',
            dosePorKg: 0.5,
            doseMaxima: 0.5,
            unidade: 'mg',
            peso: peso,
          ),
        ] else if (faixaEtaria == 'Lactente' || faixaEtaria == 'Criança') ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'Parada cardíaca pediátrica (FV/TV sem pulso)',
            descricaoDose: 'Bolus 0,5 mg/kg IV + infusão 50–300 mcg/kg/min',
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Taquicardia pediátrica',
            descricaoDose: 'Bolus: 500 mcg/kg IV, seguido de 50–200 mcg/kg/min',
            dosePorKg: 0.5,
            doseMaxima: 0.5,
            unidade: 'mg',
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Controle da frequência cardíaca',
            descricaoDose: '50–200 mcg/kg/min IV contínua',
            peso: peso,
          ),
        ] else if (faixaEtaria == 'Adolescente' || faixaEtaria == 'Adulto') ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'FA/Flutter',
            descricaoDose: 'Bolus 0,5 mg/kg IV + infusão 50–300 mcg/kg/min',
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Controle PA/FC em cirurgias',
            descricaoDose: 'Bolus 0,5–1 mg/kg + infusão 50–200 mcg/kg/min',
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Taquicardia supraventricular',
            descricaoDose: 'Bolus: 500 mcg/kg IV em 1 min, seguido de 50 mcg/kg/min',
            dosePorKg: 0.5,
            doseMaxima: 0.5,
            unidade: 'mg',
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Controle da frequência cardíaca',
            descricaoDose: '50–200 mcg/kg/min IV contínua',
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Crise hipertensiva com taquicardia',
            descricaoDose: '80 mcg/kg/min IV contínua',
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Fibrilação atrial',
            descricaoDose: '50–200 mcg/kg/min IV contínua',
            peso: peso,
          ),
        ] else if (faixaEtaria == 'Idoso') ...[
          _linhaIndicacaoDoseCalculada(
            titulo: 'FA/Flutter',
            descricaoDose: 'Bolus 0,5 mg/kg IV + infusão 50–300 mcg/kg/min',
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Taquicardia supraventricular',
            descricaoDose: 'Bolus: 500 mcg/kg IV em 1 min, seguido de 50 mcg/kg/min',
            dosePorKg: 0.5,
            doseMaxima: 0.5,
            unidade: 'mg',
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Controle da frequência cardíaca',
            descricaoDose: '50–150 mcg/kg/min IV contínua',
            peso: peso,
          ),
          _linhaIndicacaoDoseCalculada(
            titulo: 'Crise hipertensiva com taquicardia',
            descricaoDose: '60 mcg/kg/min IV contínua',
            peso: peso,
          ),
        ],
        const SizedBox(height: 16),
        const Text('Off-label', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        if (faixaEtaria == 'Recém-nascido') ...[
          _textoObs('• Neonatos: uso restrito a casos selecionados de taquicardia refratária, com monitoração intensiva obrigatória.'),
        ] else if (faixaEtaria == 'Lactente' || faixaEtaria == 'Criança') ...[
          _textoObs('• Crianças: uso em taquicardia pediátrica é amplamente empregado, mas não consta formalmente na bula.'),
          _textoObs('• Doses pediátricas são baseadas em evidências limitadas.'),
        ] else if (faixaEtaria == 'Adolescente' || faixaEtaria == 'Adulto') ...[
          _textoObs('• Adultos: uso em fibrilação atrial é off-label mas amplamente aceito na prática clínica.'),
          _textoObs('• Uso em taquicardia ventricular polimórfica é off-label mas padrão de tratamento.'),
        ] else if (faixaEtaria == 'Idoso') ...[
          _textoObs('• Idosos: uso exige cautela redobrada devido ao maior risco de bradicardia e insuficiência cardíaca.'),
        ],
        const SizedBox(height: 16),
        const Text('Cálculo da Infusão', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        ConversaoInfusaoSlider(
          peso: peso,
          opcoesConcentracoes: {
            '2500mg/250mL (10mg/mL)': 10000,
            '1000mg/100mL (10mg/mL)': 10000,
            '100mg/100mL (1mg/mL)': 1000,
            '200mg/100mL (2mg/mL)': 2000,
          },
          unidade: 'mcg/kg/min',
          doseMin: 50,
          doseMax: 300,
        ),
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Betabloqueador ultracurto, início rápido, meia-vida ~9min.'),
        _textoObs('• Beta-bloqueador cardioseletivo de ação ultra-curta (t1/2 = 9 min).'),
        _textoObs('• Ideal para controle transitório de FC e PA.'),
        _textoObs('• Ideal para controle temporário de taquicardia.'),
        _textoObs('• Cuidado com hipotensão e bradicardia.'),
        _textoObs('• Pode causar hipotensão e bradicardia.'),
        _textoObs('• Efeito cessa rapidamente após suspender.'),
        _textoObs('• Contraindicado em BAV, ICC descompensada e bradicardia.'),
        _textoObs('• Contraindicado em insuficiência cardíaca descompensada.'),
        _textoObs('• Monitorar ECG, PA e broncoespasmo.'),
        _textoObs('• Monitorar pressão arterial e frequência cardíaca.'),
        _textoObs('• Titular dose conforme resposta clínica.'),
        const SizedBox(height: 16),
        const Text('Metabolismo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Metabolização rápida por esterases plasmáticas.'),
        _textoObs('• Excreção renal como metabólitos inativos.'),
        _textoObs('• Meia-vida plasmática: 9 minutos.'),
        _textoObs('• Início de ação: 1–2 minutos IV.'),
      ],
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
    required double peso,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(descricaoDose),
          if (dosePorKg != null && unidade != null) Text('Dose: ${(dosePorKg * peso).toStringAsFixed(2)} $unidade'),
          if (dosePorKgMinima != null && dosePorKgMaxima != null && unidade != null)
            Text('Dose: ${(dosePorKgMinima * peso).toStringAsFixed(2)}–${(dosePorKgMaxima * peso).toStringAsFixed(2)} $unidade'),
          if (doseMaxima != null && unidade != null) Text('Dose máxima: $doseMaxima $unidade'),
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