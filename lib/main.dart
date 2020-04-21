import 'package:demo_app/screens/myhome.dart';
import 'package:flutter/material.dart';
import 'package:demo_app/state.dart';
import 'package:provider/provider.dart';

void main() => runApp(
    ChangeNotifierProvider(create: (context) => AppState(), child: MyHome()));
