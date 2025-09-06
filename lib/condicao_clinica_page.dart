import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CondicaoClinicaPage extends StatefulWidget {
  final String arquivoJson;

  const CondicaoClinicaPage({super.key, required this.arquivoJson});

  @override
  State<CondicaoClinicaPage> createState() => _CondicaoClinicaPageState();
}

class _CondicaoClinicaPageState extends State<CondicaoClinicaPage> {
  Map<String, dynamic>? dados;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    try {
      final raw = await rootBundle.loadString('assets/data/condicoes/${widget.arquivoJson}.json');
      final jsonMap = json.decode(raw);
      setState(() {
        dados = jsonMap['PT'];
      });
    } catch (e) {
      setState(() {
        dados = {'erro': 'Erro ao carregar dados: $e'};
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(dados?['titulo'] ?? 'Condição Clínica'),
      ),
      body: dados == null
          ? const Center(child: CircularProgressIndicator())
          : _buildConteudo(),
    );
  }

  Widget _buildConteudo() {
    if (dados!.containsKey('erro')) {
      return Center(child: Text(dados!['erro']));
    }

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      children: _construirSecoes(dados!),
    );
  }

  List<Widget> _construirSecoes(Map<String, dynamic> data) {
    final List<Widget> widgets = [];

    data.forEach((chave, valor) {
      if (chave == 'titulo') {
        widgets.insert(
          0,
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Text(
              valor,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
          ),
        );
        return;
      }

      widgets.add(_sectionTitle(_formatarTitulo(chave)));

      if (valor is String) {
        widgets.add(_info('', valor));
      } else if (valor is List) {
        for (var item in valor) {
          widgets.add(_info('•', item.toString()));
        }
      } else if (valor is Map) {
        valor.forEach((subtitulo, subvalor) {
          widgets.add(_info(_formatarTitulo(subtitulo), ''));
          if (subvalor is String) {
            widgets.add(_info('', subvalor));
          } else if (subvalor is List) {
            for (var item in subvalor) {
              widgets.add(_info('•', item.toString()));
            }
          }
        });
      }

      widgets.add(const SizedBox(height: 20));
    });

    return widgets;
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _info(String label, String value) {
    if (value.isEmpty && label.isEmpty) return const SizedBox.shrink();

    final isLista = label.trim() == '•';
    final isSubtitulo = label.isNotEmpty && !isLista && value.isEmpty;
    final isTextoComum = !isLista && !isSubtitulo;

    if (isSubtitulo) {
      return Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 6),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Colors.indigo,
            height: 1.3,
          ),
        ),
      );
    }

    if (isLista) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 6),
              child: Text('•', style: TextStyle(fontSize: 15, height: 1.5)),
            ),
            Expanded(
              child: Text(
                value,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.6,
                ),
              ),
            ),
          ],
        ),
      );
    }

    if (isTextoComum) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (label.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.indigo,
                  ),
                ),
              ),
            Text(
              value,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 15,
                height: 1.6,
              ),
            ),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }

  String _formatarTitulo(String chave) {
    return chave
        .replaceAll('_', ' ')
        .split(' ')
        .map((word) {
      if (word.isEmpty) {
        return '';
      }
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    })
        .join(' ');
  }
}
