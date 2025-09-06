import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'splash_screen.dart';

class ConsentimentoPage extends StatelessWidget {
  const ConsentimentoPage({super.key});

  String _getConsentText(BuildContext context) {
    final locale = Localizations
        .localeOf(context)
        .languageCode;
    switch (locale) {
      case 'pt':
        return "Este aplicativo é destinado exclusivamente a profissionais de saúde habilitados, preferencialmente médicos, e seu uso pressupõe conhecimento técnico, responsabilidade clínica e julgamento profissional. "
            "Ao prosseguir, você declara que possui qualificação para interpretar e aplicar as informações contidas no MedCalc.\n\n"
            "Ao utilizar este aplicativo, você concorda plenamente com os termos abaixo e isenta as plataformas de distribuição (Google Play Store e Apple App Store) de qualquer responsabilidade, direta ou indireta, decorrente da instalação, funcionamento, interpretação, uso incorreto ou falhas deste aplicativo.\n\n"
            "O MedCalc visa auxiliar o raciocínio clínico e facilitar cálculos médicos de uso profissional, não substituindo o julgamento médico, a conduta ética, as diretrizes clínicas atualizadas ou os protocolos institucionais. Toda informação tem caráter informativo e complementar, devendo ser validada antes de qualquer uso clínico.\n\n"
            "A equipe responsável pelo MedCalc não se responsabiliza por eventos adversos, erros de dosagem, falhas terapêuticas ou quaisquer consequências clínicas oriundas do uso ou mau uso do conteúdo. Ao identificar erros, o usuário compromete-se a comunicar a equipe responsável para possível correção.\n\n"
            "As decisões clínicas são de responsabilidade exclusiva do profissional usuário. Se não concordar integralmente com estes termos, interrompa imediatamente o uso e desinstale o aplicativo.";
      case 'es':
        return "Esta aplicación está destinada exclusivamente a profesionales de la salud calificados, preferentemente médicos, y su uso implica conocimiento técnico, responsabilidad clínica y juicio profesional. "
            "Al continuar, usted declara poseer calificación para interpretar y aplicar la información contenida en MedCalc.\n\n"
            "Al utilizar esta aplicación, usted acepta plenamente los términos a continuación y exime a las plataformas de distribución (Google Play Store y Apple App Store) de cualquier responsabilidad, directa o indirecta, derivada de la instalación, funcionamiento, interpretación o mal uso de esta aplicación.\n\n"
            "MedCalc tiene como objetivo apoyar el razonamiento clínico y facilitar cálculos médicos profesionales, sin sustituir el juicio médico, la conducta ética, las guías clínicas actualizadas o los protocolos institucionales. Toda la información tiene carácter informativo y complementario, y debe ser verificada antes de su uso clínico.\n\n"
            "El equipo responsable de MedCalc no se responsabiliza por eventos adversos, errores de dosificación, fallos terapéuticos o consecuencias clínicas derivadas del uso incorrecto del contenido. Al detectar errores, el usuario se compromete a informar al equipo para su posible corrección.\n\n"
            "Las decisiones clínicas son de responsabilidad exclusiva del usuario profesional. Si no está completamente de acuerdo con estos términos, interrumpa el uso y desinstale la aplicación inmediatamente.";
      case 'zh':
        return "本应用程序专为具有资质的医疗专业人士（优选执业医师）设计，使用即表示您具备解读与应用 MedCalc 信息的能力。\n\n"
            "使用本应用即视为您同意以下条款，并免除 Google Play 商店与 Apple App 商店因安装、操作、解释、误用或本应用任何故障导致的直接或间接责任。\n\n"
            "MedCalc 用于辅助临床推理和专业医学计算，不能替代医学判断、道德规范、最新临床指南或机构协议。所有信息仅供参考，使用前需经过验证。\n\n"
            "MedCalc 团队不对因使用、误用内容而造成的不良事件、剂量错误或临床后果承担责任。若发现错误，用户应立即通知开发团队以便修正。\n\n"
            "所有临床决策由使用者独立负责。如果您不同意这些条款，请立即停止使用并卸载本应用。";
      default:
        return "This application is intended exclusively for qualified healthcare professionals, preferably physicians. By continuing, you declare you have the qualifications to interpret and apply the content provided in MedCalc.\n\n"
            "By using this app, you fully agree to the terms below and release the distribution platforms (Google Play Store and Apple App Store) from any direct or indirect liability related to installation, performance, interpretation, misuse, or errors.\n\n"
            "MedCalc supports clinical reasoning and facilitates professional medical calculations. It does not replace medical judgment, ethics, updated clinical guidelines, or institutional protocols. All content is for informational purposes only and must be validated before clinical use.\n\n"
            "The MedCalc team shall not be held responsible for adverse events, dosage errors, therapeutic failures, or clinical consequences from misuse. Upon finding errors, users agree to notify the team for review and correction.\n\n"
            "All clinical decisions are the sole responsibility of the user. If you do not fully agree with these terms, stop using the app and uninstall it immediately.";
    }
  }


  String _getButtonText(BuildContext context) {
    final locale = Localizations
        .localeOf(context)
        .languageCode;
    switch (locale) {
      case 'pt':
        return "Aceitar e Continuar";
      case 'es':
        return "Aceptar y Continuar";
      case 'zh':
        return "接受并继续";
      default:
        return "Accept and Continue";
    }
  }

  Future<void> _aceitarTermo(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('termoAceito', true);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const SplashScreen(),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final consentText = _getConsentText(context);
    final buttonText = _getButtonText(context);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.medical_services_outlined, size: 64,
                        color: Colors.indigo),
                    const SizedBox(height: 20),
                    Text(
                      "MedCalc",
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      consentText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16, height: 1.5),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 3,
                        ),
                        onPressed: () => _aceitarTermo(context),
                        child: Text(
                          buttonText,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),

    );
  }
}
