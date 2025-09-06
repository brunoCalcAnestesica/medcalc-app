import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BularioPage extends StatefulWidget {
  final String nomeMedicamento;

  const BularioPage({super.key, required this.nomeMedicamento});

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
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final manifestMap = json.decode(manifestContent) as Map<String, dynamic>;

    final arquivos = manifestMap.keys.where((String key) =>
    key.startsWith('assets/medicamentos/') &&
        key.toLowerCase().contains(widget.nomeMedicamento.toLowerCase()));

    if (arquivos.isNotEmpty) {
      final caminho = arquivos.first;
      final conteudo = await rootBundle.loadString(caminho);
      final jsonData = json.decode(conteudo);

      setState(() {
        bulario = jsonData['PT']?['bulario'];
      });
    } else {
      setState(() {
        bulario = {'erro': 'Medicamento não encontrado.'};
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.nomeMedicamento)),
      body: bulario == null
          ? const Center(child: CircularProgressIndicator())
          : _buildBula(),
    );
  }

  Widget _buildBula() {
    if (bulario!.containsKey('erro')) {
      return Center(
        child: Text(
          bulario!['erro'],
          style: const TextStyle(fontSize: 18, color: Colors.redAccent),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: bulario!.length,
      itemBuilder: (context, index) {
        final chave = bulario!.keys.elementAt(index);
        final valor = bulario![chave].toString();
        return _buildCard(_formatarCampo(chave), valor);
      },
    );
  }

  Widget _buildCard(String titulo, String conteudo) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titulo,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              conteudo,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

  String _formatarCampo(String campo) {
    return campo
        .replaceAll(RegExp(r'([a-z])([A-Z])'), r'$1 $2')
        .replaceAllMapped(RegExp(r'\b\w'), (match) => match.group(0)!.toUpperCase());
  }
}