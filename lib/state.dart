import 'package:flutter/material.dart';

enum ConverterMode { DECIMAL_TO_BINARY, BINARY_TO_DECIMAL }

class AppState extends ChangeNotifier {
  String _binary = "0";
  String _decimal = "0";
  ConverterMode _mode = ConverterMode.BINARY_TO_DECIMAL;

  String get decimal => _decimal;
  String get binary => _binary;
  ConverterMode get mode => _mode;

  bool get isBinToDecMode => _mode == ConverterMode.BINARY_TO_DECIMAL;

  String get converterModeText {
    return _mode == ConverterMode.BINARY_TO_DECIMAL
        ? "Binary -> Decimal"
        : "Decimal -> Binary";
  }

  void onNumberButtonPressed(int val) {
    if (val == -1) {
      _decimal = "";
      _binary = "";

      notifyListeners();
      return;
    }

    if (_mode == ConverterMode.BINARY_TO_DECIMAL) {
      _binary += val.toString();
      _decimal = int.parse(_binary, radix: 2).toRadixString(10);
    } else {
      _decimal += val.toString();

      int temp = int.parse(_decimal);
      int i = 1;
      int binaryTemp = 0;

      while (temp > 0) {
        binaryTemp = binaryTemp + (temp % 2) * i;
        temp = (temp / 2).floor();
        i = i * 10;
      }

      _binary = binaryTemp.toString();
    }

    notifyListeners();
  }

  void changeMode() {
    _mode = _mode == ConverterMode.BINARY_TO_DECIMAL
        ? ConverterMode.DECIMAL_TO_BINARY
        : ConverterMode.BINARY_TO_DECIMAL;

    notifyListeners();
  }
}
