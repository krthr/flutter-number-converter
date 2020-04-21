import 'package:demo_app/state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Converter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            converterModeButton(),
            binaryText(),
            decimalText(),
            ButtonsContainer(),
            ResetButton()
          ]),
    );
  }

  Widget converterModeButton() {
    return Consumer<AppState>(
      builder: (context, state, child) => Container(
          alignment: Alignment.centerLeft,
          child: MaterialButton(
            child: Text(state.converterModeText),
            onPressed: () => state.changeMode(),
          )),
    );
  }

  Widget NumberButton(int digit) {
    return Consumer<AppState>(
      builder: (context, state, child) => Expanded(
        flex: 5,
        child: MaterialButton(
            padding: const EdgeInsets.all(8.0),
            color: Colors.blue,
            child: Text(
              digit.toString(),
              style: new TextStyle(fontSize: 26.0, color: Colors.white),
            ),
            onPressed: () => state.onNumberButtonPressed(digit)),
      ),
    );
  }

  Widget ResetButton() {
    return Consumer<AppState>(
        builder: (context, state, child) => Expanded(
              child: Container(
                child: MaterialButton(
                    color: Color(int.parse("#0069C0".replaceAll('#', '0xff'))),
                    onPressed: () => state.onNumberButtonPressed(-1),
                    child: Text("Reset",
                        style: new TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ))),
              ),
            ));
  }

  Widget TextInfo(String text) {
    return Container(
        alignment: Alignment.centerRight,
        child: Text(
          '$text',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(int.parse("#FF5722".replaceAll('#', '0xff'))),
              fontSize: 35),
        ));
  }

  Widget binaryText() {
    return Consumer<AppState>(
      builder: (context, state, child) => TextInfo(state.binary),
    );
  }

  Widget decimalText() {
    return Consumer<AppState>(
      builder: (context, state, child) => TextInfo(state.decimal),
    );
  }

  Widget ButtonsContainer() {
    return Consumer<AppState>(
      builder: (context, state, child) => Expanded(
        flex: 2,
        child: Container(
            margin: EdgeInsets.only(bottom: 8.0, top: 8.0),
            child: state.isBinToDecMode ? _bin2DecMode() : _dec2BinMode()),
      ),
    );
  }

  Widget _dec2BinMode() {
    Widget Btn(int digit) {
      return Consumer<AppState>(
        builder: (context, state, child) => Expanded(
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
                  onPressed: () => state.onNumberButtonPressed(digit)),
            )),
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

  Widget _bin2DecMode() {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[NumberButton(1), Spacer(flex: 1), NumberButton(0)]);
  }
}
