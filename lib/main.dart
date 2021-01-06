import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        Duration(seconds: 5),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => PlayersPage())));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return new Scaffold(
        body: Container(
      padding: const EdgeInsets.all(30.0),
      color: Color(0xffff637b),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Naughty Drinking Game',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Aleo',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
                color: Color(0xFF3d5d72)),
          ),
          SizedBox(height: 80.0),
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
