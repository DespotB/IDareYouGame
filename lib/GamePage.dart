import 'package:flutter/material.dart';
import 'dart:math';
import 'PlayersPage.dart';

// ignore: must_be_immutable
class GamePage extends StatelessWidget {
  List<String> _tasksForOnePerson = List<String>();
  List<String> _tasksForTwoPersons = List<String>();
  List<String> _tasksForAllPersons = List<String>();
  List<String> _persons = List<String>();
  bool isFirstTask = true;

  List getTwoRandomPersons() {
    var person1 = getRandomElement(_persons);
    var person2;
    do {
      person2 = getRandomElement(_persons);
    } while (person1 == person2);
    return [person1, person2];
  }

  String getOneRandomPerson() {
    var person = getRandomElement(_persons);
    return person;
  }

  List getRandomTask() {
    var taskLists = ['OnePersonTasks', 'TwoPersonsTasks', 'AllPersonsTask'];
    var taskList = getRandomElement(taskLists);
    print(taskList);
    var task;
    var personCount;
    switch (taskList) {
      case 'OnePersonTasks':
        {
          task = getRandomElement(_tasksForOnePerson);
          personCount = 1;
        }
        break;
      case 'TwoPersonsTasks':
        {
          task = getRandomElement(_tasksForTwoPersons);
          personCount = 2;
        }
        break;
      case 'AllPersonsTask':
        {
          task = getRandomElement(_tasksForAllPersons);
          personCount = 0;
        }
        break;
    }
    List countAndTask = [personCount, task];
    return countAndTask;
  }

  String generateGameTask() {
    if (isFirstTask) {
      initializeLists();
      isFirstTask = false;
    }
    var countAndTask = getRandomTask();
    var persons = getTwoRandomPersons();
    var personA = persons[0];
    var personB = persons[1];
    String finalTask;

    switch (countAndTask[0]) {
      case 0:
        {
          finalTask = countAndTask[1];
        }
        break;
      case 1:
        {
          finalTask = countAndTask[1];
          finalTask = finalTask.replaceAll('PERSONA', personA);
        }
        break;
      case 2:
        {
          finalTask = countAndTask[1];
          finalTask = finalTask.replaceAll("PERSONA", personA);
          finalTask = finalTask.replaceAll("PERSONB", personB);
        }
        break;
    }
    return finalTask;
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

  void initializeLists() {
    _tasksForAllPersons.add('Everybody undresses one clothing.');
    _tasksForOnePerson.add('PERSONA take off your pants or finish your drink.');
    _tasksForTwoPersons.add(
        'PERSONA and PERSONB either make out or both of you finish your drink.');
  }


//TODO
//            new GestureDetector(
//                   behavior: HitTestBehavior.opaque,
//                   onTap: () => print('Tapped'),
//                   child: GamePage(),
//                 ),
}
