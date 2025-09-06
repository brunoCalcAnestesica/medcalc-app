import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import '../../shared_data.dart';

class Tenoxicam {
  static Future<Widget> buildCard(BuildContext context) async {
    return FutureBuilder<String>(
      future: rootBundle.loadString('assets/medicamentos/tenoxicam.json'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Card(
            child: ListTile(
              leading: CircularProgressIndicator(),
              title: Text('Carregando Tenoxicam...'),
            ),
          );
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return const Card(
            child: ListTile(
              leading: Icon(Icons.error, color: Colors.red),
              title: Text('Erro ao carregar Tenoxicam'),
            ),
          );
        }

        try {
          final Map<String, dynamic> data = json.decode(snapshot.data!);
          final String nome = data['nome'] ?? 'Tenoxicam';
          final String classificacao = data['classificacao'] ?? '';
          final String mecanismoAcao = data['mecanismoAcao'] ?? '';
          final String farmacocinetica = data['farmacocinetica'] ?? '';
          final String farmacodinamica = data['farmacodinamica'] ?? '';
          final List<dynamic> apresentacoes = data['apresentacoes'] ?? [];
          final String preparacao = data['preparacao'] ?? '';
          final List<dynamic> indicacoesClinicas = data['indicacoesClinicas'] ?? [];
          final String observacoes = data['observacoes'] ?? '';
          final String metabolismo = data['metabolismo'] ?? '';
          final List<dynamic> contraindicacoes = data['contraindicacoes'] ?? [];
          final List<dynamic> reacoesAdversas = data['reacoesAdversas'] ?? [];
          final String interacaoMedicamento = data['interacaoMedicamento'] ?? '';

          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ExpansionTile(
              key: GlobalKey(),
              leading: IconButton(
                icon: Icon(
                  SharedData.favoritos.contains(nome) 
                      ? Icons.favorite 
                      : Icons.favorite_border,
                  color: SharedData.favoritos.contains(nome) 
                      ? Colors.red 
                      : null,
                ),
                onPressed: () {
                  SharedData.toggleFavorito(nome);
                  (context as Element).markNeedsBuild();
                },
              ),
              title: Text(
                nome,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                classificacao,
                style: const TextStyle(fontSize: 12),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Apresentações
                      if (apresentacoes.isNotEmpty) ...[
                        const Text(
                          'Apresentações',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...apresentacoes.map<Widget>((apresentacao) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              '• ${apresentacao['concentracao']} - ${apresentacao['apresentacao']} (${apresentacao['via']})',
                              style: const TextStyle(fontSize: 12),
                            ),
                          );
                        }).toList(),
                        const SizedBox(height: 16),
                      ],

                      // Preparação
                      if (preparacao.isNotEmpty) ...[
                        const Text(
                          'Preparação',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          preparacao,
                          style: const TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 16),
                      ],

                      // Indicações Clínicas com Cálculo de Dose
                      if (indicacoesClinicas.isNotEmpty) ...[
                        const Text(
                          'Indicações Clínicas',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...indicacoesClinicas.map<Widget>((indicacao) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '• ${indicacao['indicacao']}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Dose: ${indicacao['dose']}',
                                  style: const TextStyle(fontSize: 12),
                                ),
                                Text(
                                  'Frequência: ${indicacao['frequencia']}',
                                  style: const TextStyle(fontSize: 12),
                                ),
                                Text(
                                  'Duração: ${indicacao['duracao']}',
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        const SizedBox(height: 16),
                      ],

                      // Observações
                      if (observacoes.isNotEmpty) ...[
                        const Text(
                          'Observações',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          observacoes,
                          style: const TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 16),
                      ],

                      // Mecanismo de Ação
                      if (mecanismoAcao.isNotEmpty) ...[
                        const Text(
                          'Mecanismo de Ação',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          mecanismoAcao,
                          style: const TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 16),
                      ],

                      // Farmacocinética
                      if (farmacocinetica.isNotEmpty) ...[
                        const Text(
                          'Farmacocinética',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          farmacocinetica,
                          style: const TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 16),
                      ],

                      // Farmacodinâmica
                      if (farmacodinamica.isNotEmpty) ...[
                        const Text(
                          'Farmacodinâmica',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          farmacodinamica,
                          style: const TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 16),
                      ],

                      // Metabolismo
                      if (metabolismo.isNotEmpty) ...[
                        const Text(
                          'Metabolismo',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          metabolismo,
                          style: const TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 16),
                      ],

                      // Contraindicações
                      if (contraindicacoes.isNotEmpty) ...[
                        const Text(
                          'Contraindicações',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...contraindicacoes.map<Widget>((contraindicacao) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              '• $contraindicacao',
                              style: const TextStyle(fontSize: 12),
                            ),
                          );
                        }).toList(),
                        const SizedBox(height: 16),
                      ],

                      // Reações Adversas
                      if (reacoesAdversas.isNotEmpty) ...[
                        const Text(
                          'Reações Adversas',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.orange,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...reacoesAdversas.map<Widget>((reacao) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              '• $reacao',
                              style: const TextStyle(fontSize: 12),
                            ),
                          );
                        }).toList(),
                        const SizedBox(height: 16),
                      ],

                      // Interações Medicamentosas
                      if (interacaoMedicamento.isNotEmpty) ...[
                        const Text(
                          'Interações Medicamentosas',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.purple,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          interacaoMedicamento,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          );
        } catch (e) {
          return Card(
            child: ListTile(
              leading: const Icon(Icons.error, color: Colors.red),
              title: Text('Erro ao processar dados: $e'),
            ),
          );
        }
      },
    );
  }
} 