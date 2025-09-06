import 'package:flutter/services.dart';

class PesoMaximo200Com3DecimaisFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Permite apenas números, vírgula e ponto
    String filtered = newValue.text.replaceAll(RegExp(r'[^0-9,.]'), '');
    
    // Converte vírgula para ponto para cálculo
    final double? value = double.tryParse(filtered.replaceAll(',', '.'));
    
    if (value != null && value > 200) {
      return oldValue; // Não deixa passar de 200 kg
    }
    
    // Limita a 3 casas decimais
    if (filtered.contains('.') && filtered.split('.').last.length > 3) {
      return oldValue;
    }
    
    return TextEditingValue(
      text: filtered,
      selection: TextSelection.collapsed(offset: filtered.length),
    );
  }
}

class AlturaMaxima220Com3DecimaisFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Permite apenas números, vírgula e ponto
    String filtered = newValue.text.replaceAll(RegExp(r'[^0-9,.]'), '');
    
    // Converte vírgula para ponto para cálculo
    final double? value = double.tryParse(filtered.replaceAll(',', '.'));
    
    if (value != null && value > 220) {
      return oldValue; // Não deixa passar de 220 cm
    }
    
    // Limita a 3 casas decimais
    if (filtered.contains('.') && filtered.split('.').last.length > 3) {
      return oldValue;
    }
    
    return TextEditingValue(
      text: filtered,
      selection: TextSelection.collapsed(offset: filtered.length),
    );
  }
}

class IdadeFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Permite apenas números, vírgula e ponto
    String filtered = newValue.text.replaceAll(RegExp(r'[^0-9,.]'), '');
    
    // Limita a 2 casas decimais
    if (filtered.contains('.') && filtered.split('.').last.length > 2) {
      return oldValue;
    }
    
    return TextEditingValue(
      text: filtered,
      selection: TextSelection.collapsed(offset: filtered.length),
    );
  }
}