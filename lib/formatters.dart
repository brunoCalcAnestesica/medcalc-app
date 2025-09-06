import 'package:flutter/services.dart';

class PesoMaximo200Com3DecimaisFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final double? value = double.tryParse(newValue.text.replaceAll(',', '.'));
    if (value != null && value > 200) {
      return oldValue; // Não deixa passar de 200 kg
    }
    return newValue;
  }
}

class AlturaMaxima220Com3DecimaisFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final double? value = double.tryParse(newValue.text.replaceAll(',', '.'));
    if (value != null && value > 220) {
      return oldValue; // Não deixa passar de 220 cm
    }
    return newValue;
  }
}