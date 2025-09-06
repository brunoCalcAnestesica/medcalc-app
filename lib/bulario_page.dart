import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BularioPage extends StatefulWidget {
  final String principioAtivo;

  const BularioPage({super.key, required this.principioAtivo});

  @override
  State<BularioPage> createState() => _BularioPageState();
}

class _BularioPageState extends State<BularioPage> {
  Map<String, dynamic>? bulario;

  @override
  void initState() {
    super.initState();
    _carregarBula();
  }

  Future<void> _carregarBula() async {
    try {
      final caminho =
          'assets/medicamentos/${widget.principioAtivo.toLowerCase()}.json';
      final conteudo = await rootBundle.loadString(caminho);
      final jsonData = json.decode(conteudo);
      setState(() {
        bulario = jsonData['PT']?['bulario'];
      });
    } catch (e) {
      setState(() {
        bulario = {'erro': 'Erro ao carregar o bulário: $e'};
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          bulario?['nomePrincipioAtivo'] ?? 'Bula',
        ),
      ),
      body: bulario == null
          ? const Center(child: CircularProgressIndicator())
          : _buildBula(),
    );
  }

  Widget _buildBula() {
    if (bulario!.containsKey('erro')) {
      return Center(child: Text(bulario!['erro']));
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _sectionTitle('Identificação'),
        _info('Princípio Ativo', bulario!['nomePrincipioAtivo']),
        _info('Nome Comercial', bulario!['nomeComercial']),
        _info('Classificação', bulario!['classificacao']),

        _sectionTitle('Farmacologia'),
        _info('Mecanismo de Ação', bulario!['mecanismoAcao']),
        _info('Farmacocinética', bulario!['farmacocinetica']),
        _info('Farmacodinâmica', bulario!['farmacodinamica']),

        _sectionTitle('Indicações e Administração'),
        _info('Indicações', bulario!['indicacoes']),
        _info('Posologia', bulario!['posologia']),
        _info('Administração', bulario!['administracao']),
        _info('Dose Máxima', bulario!['doseMaxima']),
        _info('Dose Mínima', bulario!['doseMinima']),

        _sectionTitle('Precauções e Riscos'),
        _info('Reações Adversas', bulario!['reacoesAdversas']),
        _info('Risco na Gravidez', bulario!['riscoGravidez']),
        _info('Risco na Lactação', bulario!['riscoLactacao']),
        _info('Contraindicações', bulario!['contraindicacoes']),
        _info('Ajuste para Função Renal', bulario!['ajusteRenal']),
        _info('Ajuste para Função Hepática', bulario!['ajusteHepatico']),

        _sectionTitle('Cuidados Assistenciais'),
        _info('Cuidados Médicos', bulario!['cuidadosMedicos']),
        _info('Cuidados Farmacêuticos', bulario!['cuidadosFarmaceuticos']),
        _info('Cuidados de Enfermagem', bulario!['cuidadosEnfermagem']),

        _sectionTitle('Preparo e Conservação'),
        _info('Preparo', bulario!['preparo']),
        _info('Apresentação', bulario!['apresentacao']),
        _info('Soluções Compatíveis', bulario!['solucoesCompatíveis']),
        _info('Armazenamento', bulario!['armazenamento']),

        _sectionTitle('Interações'),
        _info('Interações Medicamentosas', bulario!['interacaoMedicamento']),

        _sectionTitle('Fontes Bibliográficas'),
        _info('Fontes', bulario!['fontesBibliograficas']),
      ],
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.indigo,
        ),
      ),
    );
  }

  Widget _info(String label, String? value) {
    if (value == null || value.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            textAlign: TextAlign.justify,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}