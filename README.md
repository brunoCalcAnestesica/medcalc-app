# MedCalc - Medical Calculator App

<div align="center">
  <img src="https://img.shields.io/badge/Flutter-3.32.5-blue?logo=flutter" alt="Flutter Version">
  <img src="https://img.shields.io/badge/Dart-3.8.1-blue?logo=dart" alt="Dart Version">
  <img src="https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web%20%7C%20Desktop-green" alt="Platform Support">
  <img src="https://img.shields.io/badge/License-MIT-yellow" alt="License">
</div>

<br>

<div align="center">
  <h3>🏥 Aplicativo Médico para Cálculos Clínicos e Farmacológicos</h3>
  <p>Ferramenta profissional para anestesiologistas e intensivistas</p>
</div>

---

## 📋 Sobre o Projeto

O **MedCalc** é um aplicativo Flutter desenvolvido especificamente para profissionais da área médica, especialmente anestesiologistas e intensivistas. O app oferece ferramentas de cálculo clínico, farmacologia médica e parâmetros fisiológicos para auxiliar na prática médica diária.

### 🎯 Principais Funcionalidades

- **👤 Gestão de Pacientes**: Cadastro com dados demográficos e cálculos automáticos
- **🧮 Parâmetros Fisiológicos**: 50+ cálculos médicos (IMC, pressão arterial, ventilação, etc.)
- **💊 Farmacologia**: 200+ medicamentos com cálculos de dose automáticos
- **🏥 Protocolos de Indução**: 80+ condições clínicas com doses específicas
- **📚 Bulário Integrado**: Informações completas de medicamentos
- **🌍 Internacionalização**: Suporte a Português, Inglês, Espanhol e Chinês

## 🚀 Tecnologias Utilizadas

- **Framework**: Flutter 3.32.5
- **Linguagem**: Dart 3.8.1
- **Plataformas**: Android, iOS, Web, macOS, Windows, Linux
- **Gerenciamento de Estado**: SharedPreferences
- **Internacionalização**: flutter_localizations

## 📱 Capturas de Tela

<div align="center">
  <img src="assets/screenshots/home.png" alt="Tela Principal" width="200">
  <img src="assets/screenshots/medications.png" alt="Medicamentos" width="200">
  <img src="assets/screenshots/physiology.png" alt="Fisiologia" width="200">
  <img src="assets/screenshots/induction.png" alt="Indução" width="200">
</div>

## 🏗️ Estrutura do Projeto

```
lib/
├── main.dart                    # Ponto de entrada da aplicação
├── home.dart                    # Tela principal com navegação
├── shared_data.dart             # Dados compartilhados globalmente
├── fisiologia.dart              # Cálculos fisiológicos
├── drogas_card/                 # Medicamentos organizados por categoria
│   ├── anti_inflamatorios/
│   ├── analgesicos_antipireticos/
│   ├── anestesicos_locais/
│   ├── opioides_analgesicos/
│   └── ... (20+ categorias)
├── pcr.dart                     # Parada cardiorrespiratória
├── inducao.dart                 # Doses de indução anestésica
└── bulario_page.dart           # Bulário de medicamentos
```

## 🧮 Cálculos Disponíveis

### Parâmetros Antropométricos
- Peso ideal, IMC, superfície corporal
- Percentual de peso ideal
- Peso esperado por faixa etária
- Altura esperada por idade

### Parâmetros Circulatórios
- Frequência cardíaca esperada
- Pressão arterial (sistólica, diastólica, média)
- Volume plasmático
- Tempo de reperfusão capilar

### Parâmetros Respiratórios
- Frequência respiratória
- Volume corrente e minuto
- Relação I:E
- PEEP sugerida
- Pressão de pico

### Parâmetros Ventilatórios
- Tamanhos de dispositivos (máscaras, cânulas, tubos)
- Laringoscópios (Miller, Macintosh)
- Tubos orotraqueais (com/sem cuff)
- Acesso central e cateteres

## 💊 Base de Dados de Medicamentos

- **200+ Medicamentos** organizados em categorias
- **Cálculos automáticos** de dose baseados no peso
- **Múltiplas concentrações** disponíveis
- **Conversão automática** mg/kg → mL/h
- **Sistema de favoritos** para medicamentos frequentes
- **Bulário completo** com informações detalhadas

### Categorias de Medicamentos
- Analgésicos e antipiréticos
- Anestésicos (locais e inalatórios)
- Opioides
- Vasopressores e hipotensores
- Antibióticos
- Anticoagulantes
- Antiarritmicos
- E muitas outras...

## 🏥 Protocolos de Indução

- **80+ Condições Clínicas** (choque cardiogênico, sepse, TCE, etc.)
- **Protocolos Personalizados** com doses específicas
- **Cálculos Automáticos** de conversão mg/kg para mg e mL
- **Sistema de Busca** por condição clínica
- **Favoritos** para protocolos frequentes

## 🛠️ Instalação e Execução

### Pré-requisitos
- Flutter SDK 3.32.5 ou superior
- Dart 3.8.1 ou superior
- Android Studio / VS Code
- Git

### Passos para Execução

1. **Clone o repositório**
```bash
git clone https://github.com/brunoCalcAnestesica/medcalc-app.git
cd medcalc-app
```

2. **Instale as dependências**
```bash
flutter pub get
```

3. **Execute o aplicativo**
```bash
# Para Android
flutter run

# Para iOS
flutter run -d ios

# Para Web
flutter run -d chrome

# Para Desktop
flutter run -d macos
flutter run -d windows
flutter run -d linux
```

## 📊 Estatísticas do Projeto

- **Arquivos**: 662 arquivos
- **Linhas de Código**: 120,000+ linhas
- **Medicamentos**: 200+ medicamentos
- **Protocolos**: 80+ condições clínicas
- **Cálculos**: 50+ parâmetros fisiológicos
- **Plataformas**: 6 plataformas suportadas

## 🤝 Contribuição

Contribuições são bem-vindas! Para contribuir:

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📝 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## 👨‍⚕️ Desenvolvido por

**Bruno Henrique Daroz**
- Email: bhdaroz@gmail.com
- GitHub: [@brunoCalcAnestesica](https://github.com/brunoCalcAnestesica)

## 📞 Suporte

Para suporte, dúvidas ou sugestões:
- 📧 Email: bhdaroz@gmail.com
- 🐛 Issues: [GitHub Issues](https://github.com/brunoCalcAnestesica/medcalc-app/issues)

## 🔮 Roadmap

### Próximas Funcionalidades
- [ ] Sincronização na nuvem
- [ ] Notificações de interações medicamentosas
- [ ] Relatórios exportáveis
- [ ] Modo offline aprimorado
- [ ] Integração com sistemas hospitalares
- [ ] IA para sugestões de doses

---

<div align="center">
  <p>Feito com ❤️ para a comunidade médica</p>
  <p>⭐ Se este projeto te ajudou, considere dar uma estrela!</p>
</div>