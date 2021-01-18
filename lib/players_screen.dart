import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'game_screen.dart';

// ignore: must_be_immutable
class PlayersPage extends StatelessWidget {
  var _controller = TextEditingController();
  var _removeController = TextEditingController();
  List<String> _players = List<String>();
  GamePage _gamePage = GamePage();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
        home: Material(
            child: Scaffold(
                backgroundColor: Color(0xffff637b),
                resizeToAvoidBottomPadding: true,
                body: SingleChildScrollView(
                    child: new Container(
              padding: const EdgeInsets.all(30.0),
              child: new Container(
                child: new Center(
                  child: new Column(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'assets/icon.png',
                        height: 40.0,
                      ),
                    ),
                    new Padding(padding: EdgeInsets.only(top: 20.0)),
                    new Text(
                      'Add players to the game',
                      style: new TextStyle(
                          color: Color(0xFF3d5d72), fontSize: 25.0),
                    ),
                    new Padding(padding: EdgeInsets.only(top: 20.0)),
                    for (var name in _players)
                      Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.center,
                                width: 3000.0,
                                child: TextFormField(
                                  controller: _removeController,
                                  style: TextStyle(
                                    height: 0.9,
                                  ),
                                  readOnly: true,
                                  textAlign: TextAlign.left,
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      hintText: name,
                                      hintStyle: TextStyle(
                                          fontSize: 18.0, color: Colors.white),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30))),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30))),
                                      prefixIcon: Icon(
                                          Icons.accessibility_new_outlined,
                                          color: Colors.white),
                                      filled: true,
                                      fillColor: Color(0xFF3d5d72)),
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              )
                            ],
                          )),
                    new Padding(padding: EdgeInsets.only(top: 20.0)),
                    new TextFormField(
                      controller: _controller,
                      decoration: new InputDecoration(
                        labelText: "Enter player name",
                        labelStyle: TextStyle(color: Colors.white),
                        suffixIcon: IconButton(
                            onPressed: () {
                              if (_controller.value.text.length > 0) {
                                _players.add(_controller.value.text);
                                _controller.clear();
                                (context as Element).reassemble();
                              } else {
                                return showAlertDialogForInvalidName(context);
                              }
                            },
                            icon: Icon(Icons.add_circle, color: Colors.white)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                        //fillColor: Colors.green
                      ),
                      keyboardType: TextInputType.name,
                      style: new TextStyle(
                        fontFamily: "Aleo",
                        color: Colors.white,
                      ),
                    ),
                    new Padding(padding: EdgeInsets.only(bottom: 20.0)),
                    new FloatingActionButton.extended(
                      onPressed: () {
                        // Add your onPressed code here!
                        _gamePage.setPersons(_players);
                        if (_players.length < 2) {
                          showAlertDialogForToLessPlayers(context);
                        } else {
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (context) => _gamePage));
                          SystemChrome.setPreferredOrientations([
                            DeviceOrientation.landscapeRight,
                            DeviceOrientation.landscapeLeft,
                          ]);
                        }
                      },
                      label: Text('Start Game (' + _players.length.toString() + ')'),
                      icon: Icon(Icons.play_arrow_outlined),
                      backgroundColor: Color(0xFF3d5d72),
                    ),
                  ]),
                ),
              ),
            )))));
  }

  showAlertDialogForInvalidName(BuildContext context) {
    // set up the button
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop(true);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Attention!"),
      content: Text("You need to enter a name before adding the player."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialogForToLessPlayers(BuildContext context) {
    // set up the button
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop(true);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Attention!"),
      content: Text("You need to have at least 2 players to start the game."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
