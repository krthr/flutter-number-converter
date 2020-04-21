import 'package:demo_app/widgets/converter.dart';
import 'package:flutter/material.dart';

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: Colors.blue,
            accentColor: Colors.blueAccent),
        home: Scaffold(
            appBar: AppBar(
              title: Text('Programación Móvil 2020'),
            ),
            body: Center(child: Converter())));
  }
}

