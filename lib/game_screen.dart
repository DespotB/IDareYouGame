import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'players_screen.dart';

// ignore: must_be_immutable
class GamePage extends StatelessWidget {
  List<String> _tasks = List<String>();
  List<String> _doneTasks = List<String>();
  List<String> _persons = List<String>();
  bool isFirstTask = true;
  bool isGameOver = false;
  int counterForGameOver = 0;
  var _isNextBackgroundLight = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Material(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              if(isGameOver) {
                isGameOver = false;
                counterForGameOver = 0;
                Navigator.of(context).pop();
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.portraitUp,
                  DeviceOrientation.portraitDown,
                ]);
              } else {
                (context as Element).reassemble();
              }
            },
            child: new Container(
              padding: const EdgeInsets.all(30.0),
              color: Color(generateBackgroundColor()),
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
                    new Container(
                      height: 80.0,
                      width: 800,
                    ),
                    textForTaskOrGameOver(),
                    new Padding(padding: EdgeInsets.only(top: 20.0)),
                  ]),
                ),
              ),
            ),
          ),
        )
    );
  }


  Text textForTaskOrGameOver(){
    if(counterForGameOver >= 100){
      isGameOver = true;
      return new Text(
        "Round Over",
        style: new TextStyle(
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
          fontFamily: "Horizon",
            color: Colors.white,
            fontSize: 70.0),
      );
    } else {
      counterForGameOver += 1;
      return new Text(
          generateGameTask(),
        textAlign: TextAlign.center,
        style: new TextStyle(
          fontFamily: "Arial",
            color: Colors.white,
            fontSize: 30.0),
      );
    }
  }

  String getOneRandomPerson() {
    var person = getRandomElement(_persons);
    return person;
  }

  String getRandomTask() {
    if(_tasks.isEmpty){
      return getRandomElement(_doneTasks);
    }else {
      String task = getRandomElement(_tasks);
      _doneTasks.add(task);
      _tasks.remove(task);
      return task;
    }
  }

  String generateGameTask() {
    if (isFirstTask) {
      initializeTasks();
      isFirstTask = false;
    }
    var task = getRandomTask();
    if(task == null){
     return null;
    }
    var randomPersons = get4RandomPersons();
    var personA = randomPersons[0];
    var personB = randomPersons[1];
    var personC = randomPersons[2];
    var personD = randomPersons[3];
    task = task.replaceAll("PERSONA", personA);
    task = task.replaceAll("PERSONB", personB);
    task = task.replaceAll("PERSONC", personC);
    task = task.replaceAll("PERSOND", personD);

    //TESTS
    print("Amount of Tasks: " + _tasks.length.toString());
    print("Task: " + task);
    print("All persons: " + randomPersons.toString());
    //TEST OVER

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
    if (_persons.length >= 4) {
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

  void setPersons(List players) {
    _persons = players;
  }

  void initializeTasks() {
    initializeAllPersons();
    initializeOnePerson();
    initializeTwoPersons();
    if (_persons.length >= 4) {
      initializeFourPersons();
    }
    print(_tasks.length);
  }

  int generateBackgroundColor(){
    if(_isNextBackgroundLight){
      _isNextBackgroundLight = false;
      return 0xffff637b;
    } else {
      _isNextBackgroundLight = true;
      return 0xfff94367;
    }
  }

  void initializeAllPersons() {
    _tasks.add('Everybody undresses one clothing or finishes their drink.');
    _tasks.add('Everybody who can touch their nose with their tongue, give out four sips.');
    _tasks.add('Every girl drinks as much sips as the number of hot boys who are playing from her point of view.');
    _tasks.add('Every boy drinks as much sips as the number of hot girls who are playing from his point of view.');
    _tasks.add('Everybody spin a bottle and kiss the person it points at or drink four times.');
    _tasks.add("Girls, take off a piece of clothing or drink two times.");
    _tasks.add("Boys, take off a piece of clothing or drink two times.");
    _tasks.add("How many people have you had sex with? Each person answers. If someone lies they finish their drink. PERSONA, you start.");
    _tasks.add("Everybody drink 2 times if you've ever held a sex toy in your hands.");
    _tasks.add("Drink four sips if you've ever slept with someone in a youth hostel.");
    _tasks.add("Everyone take off a piece of clothing!");
  }

  void initializeOnePerson() {
    _tasks.add(
        "PERSONA take off your pants/skirt or drink 3 times. If you don't wear any chose another clothing.");
    _tasks.add(
        'PERSONA write you ex that you want to come back together or drink two times');
    _tasks.add(
        'PERSONA confess which players mom you think is the hottest or drink three times.');
    _tasks.add(
        'PERSONA do 10 push-ups successfully with good from or drink two times.');
    _tasks.add(
        'PERSONA twerk for 20 seconds with your feet up a wall or drink two times.');
    _tasks.add(
        'PERSONA name the sexiest feature of every person in the group or drink five times.');
    _tasks.add('PERSONA go shirtless for one round or finish your drink.');
    _tasks.add(
        'PERSONA do a striptease and take a shot for every article of clothing you leave on or quit playing.');
    _tasks.add(
        'PERSONA go on a dating app and invite the last person you matched over or drink three times.');
    _tasks.add('PERSONA take 2 shots or quit playing.');
    _tasks.add(
        'PERSONA pretend like you are masturbating for 20 seconds or drink or drink three times.');
    _tasks.add(
        'PERSONA tell the story of how you lost your virginity or drink three times.');
    _tasks.add(
        'PERSONA tell the group which one of them you think has Big Dick Energy or drink four times.');
    _tasks.add('PERSONA get naked or finish your drink.');
    _tasks.add(
        'PERSONA name at least three types of sex toys or drink three times.');
    _tasks.add('PERSONA name at least three porn stars or drink three times.');
    _tasks.add('PERSONA take of three articles of clothing or drink 4 shots.');
    _tasks.add(
        'FREESTYLE: The group makes up a challenge for PERSONA, do it or you drink four times.');
    _tasks.add(
        'FREESTYLE: The group makes up a challenge for PERSONA, do it or you drink four times.');
    _tasks.add(
        'FREESTYLE: The group makes up a challenge for PERSONA, do it or you drink four times.');
    _tasks.add(
        'PERSONA stick out your tongue between two fingers while singing a song or drink two times.');
    _tasks.add(
        'PERSONA give a brief demonstration of how to give a rim job on an empty bottle or finish your drinks.');
    _tasks.add('PERSONA perform the chicken dance or drink two times.');
    _tasks.add(
        'PERSONA guess which player has had a threesome. If you get it right they drink three times else you drink three times.');
    _tasks.add(
        'PERSONA describe the most degrading thing you have ever done during sex or drink three times.');
    _tasks
        .add('PERSONA tell everybody your worst sex story or drink two times.');
    _tasks.add('PERSONA give your chair a lap dance or drink two times.');
    _tasks.add(
        "PERSONA send a text message to your last sexual partner letting them know you have herpes and don't reply for one hour or drink five times.");
    _tasks.add(
        'PERSONA make your butt cheeks jiggle like a porn star or finish your drink.');
    _tasks.add(
        'PERSONA confess which players dad you think is the hottest or drink three times.');
    _tasks.add(
        'PERSONA confess which player you think is the hottest or drink two times.');
    _tasks.add(
        'PERSONA let someone record you fingering your belly button while moaning or drink four times.');
    _tasks.add('PERSONA sit on the ground for one round or drink.');
    _tasks.add(
        'PERSONA bark like a dog every time someone talks to you until your next turn. If you fail drink five times.');
    _tasks.add(
        'PERSONA let the group view your search history or drink three times.');
    _tasks.add(
        "PERSONA reveal to everyone every single drug you've done or drink two times.");
    _tasks.add(
        'PERSONA choose a player and give him a wet kiss or both of you finish your drinks.');
    _tasks.add(
        "PERSONA show every tattoo you have, regardless of where it is or drink four times. If you don't have any tattoo drink three times.");
    _tasks.add(
        "PERSONA take of a piece of clothing every time you curse for the rest of the game or finish your drink.");
    _tasks.add(
        "PERSONA reveal to everyone how many people you've slept with or drink four times.");
    _tasks.add(
        "PERSONA tell everyone who you voted for in the last election or drink two times.");
    _tasks.add("PERSONA shave an eyebrow or drink two times.");
    _tasks.add(
        "PERSONA draw a mustache on your face with a marker and leave it there at least until your next turn or drink three times.");
    _tasks
        .add("PERSONA let another player give you a wedgie or take one shot.");
    _tasks.add(
        "PERSONA demonstrate how to give a blowjob for 15 seconds on a random object or drink four times.");
    _tasks.add("PERSONA name three sex positions or drink three times.");
    _tasks.add("PERSONA deep throat a banana or finish your drink.");
    _tasks.add(
        "PERSONA simultaneously hop on one foot, pat your head and rub your belly for 10 seconds if you fail drink three times.");
    _tasks.add(
        "PERSONA gets blindfold and spinned around. Walk until you bump into a person or object and make out with them or finish your drink.");
    _tasks.add(
        "PERSONA take off one article of clothing every time someone drinks until you're down to your underwear. Stay like this for the rest of the game. Do this or drink five times.");
    _tasks.add("PERSONA attempt to do the worm or drink twice.");
    _tasks.add(
        "PERSONA name at least three different strains of weed or drink two times.");
    _tasks.add("PERSONA dm your crush or drink two times.");
    _tasks.add("PERSONA make a fart noise with your hand or drink.");
    _tasks.add("PERSONA twerk for 20 seconds or drink twice.");
    _tasks.add(
        "PERSONA guess which player has a condom with them currently. If you get it right they drink twice, else you drink twice.");
    _tasks.add(
        "PERSONA get blindfolded and feel someones face. If you can't guess who it is on the first try, drink twice.");
    _tasks.add(
        "PERSONA take a little spoon of hot sauce of finish your drink. If the host doesn't have hot sauce they drink two times.");
    _tasks.add(
        "PERSONA let the group know if you would have or had sex with somebody who wasn't single or drink twice.");
    _tasks.add("PERSONA perform three one-handed push-ups or drink twice.");
    _tasks.add(
        "PERSONA show the most embarrassing picture in your phone or finish your drink.");
    _tasks.add(
        "PERSONA strip down to your underwear and run one round around the house or drink three times.");
    _tasks.add(
        "PERSONA spin a bottle and make out with the person it points to. Both of you must do this or finish your drinks");
    _tasks.add(
        "PERSONA spin a bottle and make out with the person it points to. Both of you must do this or finish your drinks");
    _tasks.add(
        'PERSONA open the front door and yell as loud as you can "I love anal" or drink two shots.');
    _tasks
        .add("PERSONA apply eyeliner with a black marker or drink four times.");
    _tasks.add(
        "PERSONA remove your pants and sit in your underwear until your next turn or finish your drink.");
    _tasks.add(
        "PERSONA try to shoot a balled up piece of paper into a cup of trash. If you miss drink twice, if you make it everybody else drinks twice.");
    _tasks.add("PERSONA freestyle rap for 20 seconds or finish your drink.");
    _tasks.add(
        "PERSONA go fill up a sink with cold water and dunk your face for 10 seconds or drink three times.");
    _tasks.add("PERSONA go pantless for one round or finish your drink.");
    _tasks.add(
        "PERSONA call your mum or your dad and tell them you need to get bailed out of jail or drink three times.");
    _tasks.add(
        "PERSONA put two ice cubes under your armpits and leave them there until they melt or drink twice.");
    _tasks.add(
        "PERSONA dance on the table to a song of the groups choice for at least 30 second or finish your drink.");
    _tasks.add('PERSONA, give out four sips to the hottest person from your point of view.');
    _tasks.add("PERSONA, close your eyes and try to recognise each player just form their smell. Drink tree sips if you can't.");
    _tasks.add('PERSONA, choose a word. First person to sing a song with this word, give out two sips.');
    _tasks.add("PERSONA, give out as many sips as there are single people around the table.");
    _tasks.add("PERSONA, challenge a player to unclip a female player's bra. If that person can't do it in 5 seconds time, he/she drinks three slips.");
    _tasks.add("PERSONA, let someone of your choice give you a hickey, where you want. Any refusal means two slips.");
    _tasks.add("PERSONA, lick someone's mouth or drink 3 times.");
    _tasks.add("PERSONA, choose someone to show one of their private parts. 4 sips in case of refusal.");
    _tasks.add("PERSONA, go around the room and drink three times and say who you want to have sex with tonight.");
    _tasks.add("PERSONA, if you made love for the first time before 17, give out two sips.");
  }

  void initializeTwoPersons() {
    _tasks.add('PERSONA and PERSONB make out or both of you drink two times.');
    _tasks.add(
        "PERSONA guess if PERSONB has had anal sex, if you're right PERSONB drinks two times, else you drink two times.");
    _tasks.add(
        'PERSONA give a foot massage to PERSONB or both of you drink two times.');
    _tasks.add(
        'PERSONA bite the booty of PERSONB or both of you drink three times.');
    _tasks.add(
        'PERSONA lick the neck of PERSONB and describe the taste or drink two times.');
    _tasks.add(
        'PERSONA guess if PERSONB has had or given road head. If you get it wrong drink two times else the other person drinks two times.');
    _tasks
        .add('PERSONA let PERSONB tickle you for 20 second or drink one time.');
    _tasks.add(
        'PERSONA send your best friend a picture with PERSONB or drink five times.');
    _tasks.add('PERSONA give a lap dance to PERSONB or finish your drink.');
    _tasks.add(
        'PERSONA sit on PERSONB until your next turn or both of you drink three times.');
    _tasks.add(
        'PERSONA let PERSONB go through your phones photo gallery for 30 seconds or drink two shots.');
    _tasks.add(
        'PERSONA give a hickey to PERSONB or both of you drink two times.');
    _tasks.add(
        'PERSONA suck on your finger sexually while staring at PERSONB or drink four times.');
    _tasks.add(
        'PERSONA go into another room with PERSONB and stay there for 1 minute at least or drink two times.');
    _tasks.add(
        'PERSONA put an ice cube in your mouth and transfer it into the mouth of PERSONB or both of you drink three times.');
    _tasks.add(
        'PERSONA put your hand on the genitals of PERSONB for 15 seconds or both of you drink three times.');
    _tasks.add(
        'PERSONA give PERSONB a back massage for 30 seconds while whispering sexually in their ear or drink two times.');
    _tasks.add(
        'PERSONA text a random phone number which PERSONB gives you "u up" or drink two times.');
    _tasks.add(
        "PERSONA try to make PERSONB nervous. If you succedd they drink three times, else you drink three times. The group decides.");
    _tasks.add(
        "PERSONA touch noses with PERSONB for 60 seconds without breaking eye contact or both you of you finish your drinks.");
    _tasks.add(
        "PERSONA give your phone to PERSONB and let them text a contact of their choice or drink three times.");
    _tasks.add(
        "PERSONA lick the nipple of PERSONB, both of you must do this or finish your drinks.");
    _tasks.add(
        "PERSONA and PERSONB are having a dance off. The loser drinks three times. The group decides.");
    _tasks.add(
        "PERSONA let PERSONB send an eggplant or peach emoji to someone in your phone or drink two times.");
    _tasks.add(
        "PERSONA make direct eye contact with PERSONB while eating a banana as sexually as possible or drink two times.");
    _tasks.add(
        'PERSONA and PERSONB act out the sex position "cowgirl" or drink three times.');
    _tasks.add(
        'PERSONA and PERSONB act out the sex position "seated oral" or drink three times.');
    _tasks.add(
        'PERSONA and PERSONB act out the sex position "doggy style" or drink three times.');
    _tasks.add(
        'PERSONA and PERSONB act out the sex position "69" or drink three times.');
    _tasks.add(
        'PERSONA and PERSONB act out the sex position "missionary" or drink three times.');
    _tasks.add("PERSONA let PERSONB slap you in the face or drink two times .");
    _tasks.add("PERSONA let PERSONB slap your ass or drink three times.");
    _tasks.add(
        'PERSONA let PERSONB spank you on the ass while you repeat the phrase "Harder, daddy, harder" for 10 seconds or finish your drink.');
    _tasks.add(
        "PERSONA write a four letter word on the back of PERSONB. If they guess correctly drink three times else they drink.");
    _tasks.add(
        "PERSONA let PERSONB draw a penis on your neck or drink three times.");
    _tasks.add(
        "PERSONA, PERSONB is now your master, do everything they say for one round or finish your drink.");
    _tasks.add(
        "PERSONA call a random number which PERSONB gives you and try to flirt with the person.");
    _tasks.add(
        "PERSONA let PERSONB ride on your back like you're a horse or drink three times.");
    _tasks.add(
        "PERSONA let PERSONB slap you as hard as they can on the ass or finish your drink.");
    _tasks.add("PERSONA put PERSONB on your shoulders or drink twice.");
    _tasks.add(
        "PERSONA do a trust fall into the arms of PERSONB or drink twice.");
    _tasks.add(
        "PERSONA unzip the pants of PERSONB with your teeth. Both of you must do this or finish your drinks.");
    _tasks.add(
        "PERSONA motorboat PERSONB for 15 seconds even if they don't have boobs. Both must do this or drink four times");
    _tasks.add(
        "PERSONA take a shot of the belly of PERSONB. Both must do this or take three shots.");
    _tasks.add(
        "PERSONA place your hand on the crotch of PERSONB for 10 seconds. Do this or both of you drink three times.");
    _tasks.add(
        "PERSONA place your hand on the breast of PERSONB for 10 seconds. Do this or both of you drink three times.");
    _tasks.add(
        "PERSONA turn your phone off for the rest of the game or drink four times. If you turn it on later finish your drink");
    _tasks.add(
        "PERSONA without laughing or breaking eye contact, unzip the pants of PERSONB. If you take longer then 20 seconds or don't do it drink the times.");
    _tasks.add(
        "PERSONA let PERSONB give you a titty twister or drink four times.");
    _tasks.add(
        "PERSONA go have sex with PERSONB or both of you finish your drinks.");
    _tasks.add(
        "PERSONA ask PERSONB a true or false question about yourself. If they get it right you drink, else they drink.");
    _tasks.add(
        "PERSONA use your feet to give PERSONB a sip from their drink without spilling. Both must do this or drink three times.");
    _tasks.add('PERSONA, kiss PERSONB or drink three times.');
    _tasks.add("PERSONA, if having sex with PERSONB wouldn't bother you, give out five sips.");
    _tasks.add("PERSONA must have one hand on PERSONB's thigh for one round.");
    _tasks.add("PERSONA, if PERSONB has ever seen you with no shirt on or in your bra, give out two sips. Otherwise drink them.");
    _tasks.add("PERSONA, kiss PERSONB or drink three times.");

  }

  void initializeThreePersons() {
    _tasks.add(
        'PERSONA, PERSONB and PERSONC form a human pyramid or drink two times.');
    _tasks.add(
        'PERSONA, PERSONB and PERSONC act out a sex position you would choose if you had a threesome or drink four times.');
    _tasks.add(
        'PERSONA let PERSONB and PERSONC pinch your nipples or drink four times.');
    _tasks.add(
        'PERSONA and PERSONB act out a sex position which PERSONC chooses or drink two times.');
    _tasks.add("PERSONA, make up your mind: which player do you think wants to have sex more, PERSONB or PERSONC? This player must drink4 sips and can go masturbate.");
    _tasks.add("PERSONA, make up your midn: who do you think is more capable of having anal sex with a stranger, PERSONB or PERSONC? This person must give out five sips.");
    _tasks.add("PERSONA, make up your mind: who do you think has more beautiful eyes, PERSONB or PERSONC? This person must give out four sips.");
  }

  void initializeFourPersons() {
    _tasks.add(
        'PERSONA, PERSONB, PERSONC and PERSOND have sex together or drink four times.');
    _tasks.add(
        "PERSONA confess who out of the group you would fuck, marry and kill or drink four times.");
  }
}