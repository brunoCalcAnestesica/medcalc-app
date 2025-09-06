import 'package:flutter/material.dart';
import '../drogas.dart';
import '../../shared_data.dart';

class MedicamentoPicadaCobra {
  static const String nome = 'Picada de Cobra';
  static const String idBulario = 'picada_cobra';

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
      conteudo: _buildConteudoPicadaCobra(context, peso, isAdulto),
    );
  }

  static Widget _buildConteudoPicadaCobra(BuildContext context, double peso, bool isAdulto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        
        // Informações gerais
        const Text('Informações Gerais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Emergência médica que requer atendimento imediato'),
        _textoObs('• Classificação: acidente ofídico'),
        _textoObs('• Tratamento específico com soro antiveneno'),
        _textoObs('• Notificação obrigatória ao SINAN'),
        
        // Manejo inicial
        const SizedBox(height: 16),
        const Text('Manejo Inicial', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _linhaPreparo('Estabilizar via aérea, ventilação e circulação (ABC)', ''),
        _linhaPreparo('Lavar o local com SF 0,9%. Não fazer torniquete nem cortes', ''),
        _linhaPreparo('Imobilizar membro afetado em posição funcional', ''),
        _linhaPreparo('Coletar informações sobre o animal: local, hora, aparência', ''),
        _linhaPreparo('Avaliar sinais de envenenamento local e sistêmico', ''),

        // Indicações de soro antiveneno
        const SizedBox(height: 16),
        const Text('Indicações de Soro Antiveneno', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),

        _linhaIndicacaoDoseFixa(
          titulo: 'Bothrops (Jararaca)',
          descricaoDose: '8 ampolas IV (leve) | 12 (moderado) | 20 (grave)',
          unidade: 'ampolas',
          valorMinimo: 8,
          valorMaximo: 20,
        ),
        _linhaIndicacaoDoseFixa(
          titulo: 'Crotalus (Cascavel)',
          descricaoDose: '5 ampolas IV (leve) | até 10 (moderado a grave)',
          unidade: 'ampolas',
          valorMinimo: 5,
          valorMaximo: 10,
        ),
        _linhaIndicacaoDoseFixa(
          titulo: 'Lachesis (Surucucu)',
          descricaoDose: '10 a 20 ampolas IV, conforme gravidade',
          unidade: 'ampolas',
          valorMinimo: 10,
          valorMaximo: 20,
        ),
        _linhaIndicacaoDoseFixa(
          titulo: 'Micrurus (Coral verdadeira)',
          descricaoDose: '10 ampolas IV, dose única, independentemente do peso',
          unidade: 'ampolas',
          valorMinimo: 10,
          valorMaximo: 10,
        ),

        // Preparo e administração
        const SizedBox(height: 16),
        const Text('Preparo e Administração', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Diluir soro em 250–500mL de SF 0,9%'),
        _textoObs('• Infundir lentamente em 1 hora'),
        _textoObs('• Monitorar sinais vitais durante a infusão'),
        _textoObs('• Ter adrenalina e anti-histamínicos prontos'),
        _textoObs('• Pode haver necessidade de repetição após 12–24h'),

        // Sinais de envenenamento
        const SizedBox(height: 16),
        const Text('Sinais de Envenenamento', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Locais: dor, edema, equimose, bolhas, necrose'),
        _textoObs('• Sistêmicos: hipotensão, taquicardia, sangramento'),
        _textoObs('• Neurológicos: ptose, paralisia, insuficiência respiratória'),
        _textoObs('• Renais: oligúria, anúria, insuficiência renal'),

        // Observações
        const SizedBox(height: 16),
        const Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Sempre monitorar sinais de anafilaxia.'),
        _textoObs('• Encaminhar notificação ao SINAN.'),
        _textoObs('• Manter vigilância de sintomas locais/sistêmicos.'),
        _textoObs('• Avaliar necessidade de suporte ventilatório.'),
        _textoObs('• Monitorar função renal e hepática.'),
        _textoObs('• Considerar profilaxia antitetânica.'),

        // Contraindicações
        const SizedBox(height: 16),
        const Text('Contraindicações', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Hipersensibilidade conhecida ao soro antiveneno.'),
        _textoObs('• Acidentes sem sinais de envenenamento.'),
        _textoObs('• Acidentes por serpentes não peçonhentas.'),

        // Reações adversas
        const SizedBox(height: 16),
        const Text('Reações Adversas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _textoObs('• Reações anafiláticas (urticária, angioedema, choque).'),
        _textoObs('• Febre, calafrios, mal-estar.'),
        _textoObs('• Dor no local da infusão.'),
        _textoObs('• Doença do soro (7–14 dias após).'),

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

  static Widget _linhaIndicacaoDoseFixa({
    required String titulo,
    required String descricaoDose,
    required String unidade,
    required double valorMinimo,
    required double valorMaximo,
  }) {
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
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              'Dose: $valorMinimo–$valorMaximo $unidade',
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