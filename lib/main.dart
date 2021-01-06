import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'PlayersPage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyLoadingScreen(),
    );
  }
}

class MyLoadingScreen extends StatefulWidget {
  _MyLoadingScreenState createState() => _MyLoadingScreenState();
}

class _MyLoadingScreenState extends State<MyLoadingScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => PlayersPage())));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Container(
      padding: const EdgeInsets.all(30.0),
      color: Color(0xffff637b),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/icon.png',
            height: 100.0,
          ),
          SizedBox(height: 30.0),
          SpinKitRipple(color: Colors.white),
        ],
      ),
    ));
  }
}
