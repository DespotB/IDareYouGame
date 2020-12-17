import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'PlayersPage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Players",
      home: PlayersPage(),
    );
  }
}


