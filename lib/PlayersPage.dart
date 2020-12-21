import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'GamePage.dart';

// ignore: must_be_immutable
class PlayersPage extends StatelessWidget {
  var _controller = TextEditingController();
  List<String> _players = List<String>();
  GamePage _gamePage = GamePage();

  showAlertDialogForToLessPlayers(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Player limit reached."),
      content: Text("You have already registered 15 Players."),
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

  showAlertDialogForStartGame(BuildContext context) {
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
      content: Text("You need at least two players to play this game."),
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

  @override
  Widget build(BuildContext context) {
    return Material(
        child: new Container(
          padding: const EdgeInsets.all(30.0),
          color: Colors.pinkAccent,
          child: new Container(
            child: new Center(
              child: new Column(children: [
                new Container(
                  height: 20.0,
                  width: 100.0,
                  decoration: new BoxDecoration(shape: BoxShape.circle),
                ),
                new Container(
                  child: new Text(
                    'Naughty Drinking Game',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Aleo',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                        color: Colors.indigoAccent),
                  ),
                ),
                new Padding(padding: EdgeInsets.only(top: 20.0)),
                new Text(
                  'Add players to the game',
                  style: new TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                new Padding(padding: EdgeInsets.only(top: 20.0)),
                for (var name in _players)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      name,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 18, color: Colors.white),

                    ),
                  ),
                new Padding(padding: EdgeInsets.only(top: 20.0)),
                new TextFormField(
                  controller: _controller,
                  decoration: new InputDecoration(
                    labelText: "Enter player name",
                    labelStyle: TextStyle(color: Colors.white),
                    suffixIcon: IconButton(
                        onPressed: () {
                          if (_players.length < 15) {
                            _players.add(_controller.value.text);
                            (context as Element).reassemble();
                            _controller.clear();
                          } else {
                            return showAlertDialogForToLessPlayers(context);
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
                    if(_players.length < 2){
                      showAlertDialogForStartGame(context);
                    } else {
                      Navigator.of(context)
                          .push(
                          new MaterialPageRoute(builder: (context) => _gamePage));
                    }
                  },
                  label: Text('Start Game'),
                  icon: Icon(Icons.play_arrow_outlined),
                  backgroundColor: Colors.indigo,
                ),
              ]),
            ),
          ),
        ));
  }
}
