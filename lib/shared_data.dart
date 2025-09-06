import 'package:shared_preferences/shared_preferences.dart';

class SharedData {
  static double? peso;
  static double? altura;
  static double? idade;
  static String sexo = 'Masculino';
  static String idadeTipo = 'anos';
  static Set<String> favoritos = {};

  static String get faixaEtaria {
    if (idade == null) return '-';
    if (idade! < 0.083) return 'Recém-nascido';
    if (idade! < 1) return 'Lactente';
    if (idade! < 12) return 'Criança';
    if (idade! < 18) return 'Adolescente';
    if (idade! < 60) return 'Adulto';
    return 'Idoso';
  }

  static Future<void> carregarFavoritos() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritosList = prefs.getStringList('medicamentosFavoritos') ?? [];
    favoritos = favoritosList.toSet();
  }

  static Future<void> toggleFavorito(String nome) async {
    final prefs = await SharedPreferences.getInstance();
    if (favoritos.contains(nome)) {
      favoritos.remove(nome);
    } else {
      favoritos.add(nome);
    }
    await prefs.setStringList('medicamentosFavoritos', favoritos.toList());
  }
}


