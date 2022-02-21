import 'package:flutter/cupertino.dart';

class Validator {
  Validator._();
  static FormFieldValidator compare(
      TextEditingController? valueEc, String message) {
    return (value) {
      final valueCompare = valueEc?.text ?? '';
      if (value == null || value != valueCompare) {
        return message;
      }
    };
  }
}
