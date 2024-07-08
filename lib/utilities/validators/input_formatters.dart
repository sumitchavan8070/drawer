import 'package:flutter/services.dart';

class NumberOnlyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    if (RegExp(r'^[0-9]+$').hasMatch(newValue.text)) {
      return newValue;
    } else {
      return oldValue;
    }
  }
}

class TextOnlyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    if (RegExp(r'^[a-zA-Z ]+$').hasMatch(newValue.text)) {
      return newValue;
    } else {
      return oldValue;
    }
  }
}