import 'package:flutter/material.dart';

class PcrPage extends StatelessWidget {
  const PcrPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PCR')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Idade: - anos"),
            const Text("Peso: - kg"),
            const Text("Altura: - cm"),
            const Text("Faixa Etária: -"),
            const SizedBox(height: 20),
            const Text('Conteúdo específico da tela.'),
          ],
        ),
      ),
    );
  }
}