import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'splash_screen.dart';
import 'consentimento_page.dart';
import 'bulario_page.dart';

late bool termoAceito;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  termoAceito = prefs.getBool('termoAceito') ?? false;

  runApp(const MedCalcApp());
}

class MedCalcApp extends StatelessWidget {
  const MedCalcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MedCalc',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        scaffoldBackgroundColor: Colors.grey[50],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          centerTitle: true, // Centro o título para ficar mais harmônico
          elevation: 2,       // Leve sombra para destacar o AppBar
        ),
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', ''),  // Português
        Locale('en', ''),  // Inglês
        Locale('es', ''),  // Espanhol
        Locale('zh', ''),  // Chinês
      ],
      debugShowCheckedModeBanner: false,
      initialRoute: termoAceito ? '/' : '/consentimento',
      routes: {
        '/': (context) => const SplashScreen(),
        '/consentimento': (context) => const ConsentimentoPage(),
        '/bulario': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as String?;
          return BularioPage(principioAtivo: args ?? 'adrenalina');
        },
      },
    );
  }
}
