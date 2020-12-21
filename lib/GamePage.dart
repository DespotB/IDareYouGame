import 'package:flutter/material.dart';
import 'dart:math';
import 'PlayersPage.dart';

// ignore: must_be_immutable
class GamePage extends StatelessWidget {
  List<String> _tasks = List<String>();
  List<String> _persons = List<String>();
  bool isFirstTask = true;


  String getOneRandomPerson() {
    var person = getRandomElement(_persons);
    return person;
  }

  String getRandomTask() {
    String task = getRandomElement(_tasks);
    return task;
  }

  String generateGameTask() {
    if (isFirstTask) {
      initializeTasks();
      isFirstTask = false;
    }
    var task = getRandomTask();
    var randomPersons = get4RandomPersons();
    var personA = randomPersons[0];
    var personB = randomPersons[1];
    var personC = randomPersons[2];
    var personD = randomPersons[3];

    print(task);
    print(randomPersons);
    task = task.replaceAll("PERSONA", personA);
    task = task.replaceAll("PERSONB", personB);
    task = task.replaceAll("PERSONC", personC);
    task = task.replaceAll("PERSOND", personD);

    return task;
  }

  List get4RandomPersons() {
    List notAssignedPersons = new List<String>.from(_persons);
    List randomPersons = new List<String>();

    var person1 = getRandomElement(notAssignedPersons);
    notAssignedPersons.remove(person1);
    notAssignedPersons.join(', ');
    randomPersons.add(person1);

    var person2 = getRandomElement(notAssignedPersons);
    notAssignedPersons.remove(person2);
    randomPersons.add(person2);

    var person3 = "";
    var person4 = "";
    if(_persons.length >= 4) {
      person3 = getRandomElement(notAssignedPersons);
      notAssignedPersons.remove(person3);
      notAssignedPersons.join(', ');

      person4 = getRandomElement(notAssignedPersons);
      notAssignedPersons.remove(person4);
      notAssignedPersons.join(', ');
    }
    randomPersons.add(person3);
    randomPersons.add(person4);

    return randomPersons;
  }


  T getRandomElement<T>(List<T> list) {
    final random = new Random();
    var i = random.nextInt(list.length);
    return list[i];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: new Container(
          padding: const EdgeInsets.all(30.0),
          color: Colors.pinkAccent,
          child: new Container(
            child: new Center(
              child: new Column(children: [
                new Container(
                  height: 250.0,
                  width: 800,
                ),
                new Text(
                  generateGameTask(),
                  style: new TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                new Padding(padding: EdgeInsets.only(top: 20.0)),
                new FloatingActionButton.extended(
                  onPressed: () {
                    (context as Element).reassemble();
                  },
                  label: Text('Generate New Task'),
                  icon: Icon(Icons.adb_sharp),
                  backgroundColor: Colors.indigo,
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  void setPersons(List players) {
    _persons = players;
  }

  void initializeTasks() {
    initializeAllPersons();
    initializeOnePerson();
    initializeTwoPersons();
    if(_persons.length >= 4) {
      initializeFourPersons();
    }
  }

  void initializeAllPersons() {
    _tasks.add('Everybody undresses one clothing or finishes their drink.');
  }

  void initializeOnePerson() {
    _tasks.add('PERSONA take off your pants/skirt or drink 3 times. If you dont wear any chose another clothing.');
  }

  void initializeTwoPersons() {
    _tasks.add('PERSONA and PERSONB make out or both of you drink 2 times.');
  }

  void initializeFourPersons() {
    _tasks.add('PERSONA, PERSONB, PERSONC and PERSOND have sex together or drink 4 times.');
  }

//TODO
//            new GestureDetector(
//                   behavior: HitTestBehavior.opaque,
//                   onTap: () => print('Tapped'),
//                   child: GamePage(),
//                 ),
}
