import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'players_screen.dart';
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setEnabledSystemUIOverlays([]);
    return new Scaffold(
        body: Container(
      padding: const EdgeInsets.all(30.0),
      color: Color(0xffff637b),
      child: Column(
        children: <Widget>[
          SizedBox(height: 20.0),
          SizedBox(
            width: 250.0,
            child: ScaleAnimatedTextKit(
              text: ['Naughty Drinking Game'],
              textAlign: TextAlign.center,
              isRepeatingAnimation: false,
              duration: Duration(milliseconds: 4000),
              textStyle: TextStyle(
                fontSize: 55.0,
                fontFamily: "Horizon",
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFFFFF),
                shadows: [
                  Shadow(
                    color: Color(0xff00efd1),
                    blurRadius: 10.0,
                    offset: Offset(5.0, 5.0),
                  ),
                  Shadow(
                    color: Color(0xFF3d5d72),
                    blurRadius: 10.0,
                    offset: Offset(-5.0, 5.0),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 70.0),
          Image.asset(
            'assets/icon.png',
            height: 100.0,
          ),
          SizedBox(height: 30.0),
          SpinKitRipple(color: Colors.white),
        ],
      ),
    ),);

  }

}
