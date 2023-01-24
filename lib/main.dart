import 'package:flutter/material.dart';
import 'package:transport/screens/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rozkład autobusów',
      theme: ThemeData(
        primarySwatch: Colors.green,
        brightness: Brightness.dark,
        fontFamily: 'Roboto',
      ),
      home: BouncingButton(),
    );
  }
}

