import 'dart:ffi';

import 'package:flutter/material.dart';

class Converter extends StatefulWidget {
  @override
  _ConverterState createState() => _ConverterState();
}

enum ConverterMode { DECIMAL_TO_BINARY, BINARY_TO_DECIMAL }

class _ConverterState extends State<Converter> {
  String _binary = "";
  String _decimal = "0";
  ConverterMode _mode = ConverterMode.BINARY_TO_DECIMAL;

  void _onPressed(int val) {
    setState(() {
      if (val == -1) {
        _decimal = "";
        _binary = "";
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
    });
  }

  void _onConverterModePressed() {
    setState(() {
      _mode = _mode == ConverterMode.BINARY_TO_DECIMAL
          ? ConverterMode.DECIMAL_TO_BINARY
          : ConverterMode.BINARY_TO_DECIMAL;

      //_decimal = "0";
      //_binary = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ConverterModeButton(),
            BinaryText(),
            DecimalText(),
            ButtonsContainer(),
            ResetButton()
          ]),
    );
  }

  Widget ConverterModeButton() {
    return Container(
        alignment: Alignment.centerLeft,
        child: MaterialButton(
          child: Text(_mode == ConverterMode.BINARY_TO_DECIMAL
              ? "Binary -> Decimal"
              : "Decimal -> Binary"),
          onPressed: _onConverterModePressed,
        ));
  }

  Widget NumberButton(int digit) {
    return Expanded(
      flex: 5,
      child: MaterialButton(
          padding: const EdgeInsets.all(8.0),
          color: Colors.blue,
          child: Text(
            digit.toString(),
            style: new TextStyle(fontSize: 26.0, color: Colors.white),
          ),
          onPressed: () => _onPressed(digit)),
    );
  }

  Widget ResetButton() {
    return Expanded(
      child: Container(
        child: MaterialButton(
            color: Color(int.parse("#0069C0".replaceAll('#', '0xff'))),
            onPressed: () => _onPressed(-1),
            child: Text("Reset",
                style: new TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ))),
      ),
    );
  }

  Widget BinaryText() {
    return Container(
        alignment: Alignment.centerRight,
        child: Text(
          '$_binary',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(int.parse("#FF5722".replaceAll('#', '0xff'))),
              fontSize: 35),
        ));
  }

  Widget DecimalText() {
    return Container(
      alignment: Alignment.centerRight,
      child: Text(
        '$_decimal',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(int.parse("#FF5722".replaceAll('#', '0xff'))),
            fontSize: 35),
      ),
    );
  }

  Widget ButtonsContainer() {
    return Expanded(
      flex: 2,
      child: Container(
          margin: EdgeInsets.only(bottom: 8.0, top: 8.0),
          child: _mode == ConverterMode.BINARY_TO_DECIMAL
              ? Bin2DecMode()
              : Dec2BinMode()),
    );
  }

  Widget Dec2BinMode() {
    Widget Btn(int digit) {
      return Expanded(
        flex: 1,
        child: Container(
          padding: const EdgeInsets.all(2.0),
          child: MaterialButton(
              padding: const EdgeInsets.all(8.0),
              color: Colors.blue,
              child: Text(
                digit.toString(),
                style: new TextStyle(fontSize: 26.0, color: Colors.white),
              ),
              onPressed: () => _onPressed(digit)),
        ),
      );
    }

    return Column(
      children: <Widget>[
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[Btn(1), Btn(2), Btn(3)],
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[Btn(4), Btn(5), Btn(6)],
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[Btn(7), Btn(8), Btn(9)],
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[Btn(0)],
            ),
          ),
        )
      ],
    );
  }

  Widget Bin2DecMode() {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          NumberButton(1),
          Spacer(
            flex: 1,
          ),
          NumberButton(0),
        ]);
  }
}
