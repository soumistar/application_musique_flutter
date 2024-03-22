import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'musique.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ISMA-ZIK',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'ISMA-ZIK'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Musique> maListesMusiques = [
    Musique("Cramer", "Jok'air", "assets/cramer.png", "null"),
    Musique("Nos souvenirs", "Jok'air", "assets/souvenirs.jpg", "null"),
  ];

  late StreamSubscription positionSub;
  late StreamSubscription stateSubscription;
  late AudioPlayer audioPlayer;
  late Musique maMusiqueActuelle;
  double position = 0.0;
  @override
  void initState() {
    super.initState();
    maMusiqueActuelle = maListesMusiques[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),

      backgroundColor: Colors.grey[800],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              elevation: 9,
              // ignore: sized_box_for_whitespace
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                child: Image.asset(
                  maMusiqueActuelle.imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 80),
            textAvecStyle(maMusiqueActuelle.titre, 1.5),
            const SizedBox(height: 30),
            textAvecStyle(maMusiqueActuelle.artiste, 1),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                bouton(Icons.fast_rewind, 30, ActionMusic.rewind),
                bouton(Icons.play_arrow, 45, ActionMusic.play),
                bouton(Icons.fast_forward, 30, ActionMusic.forward),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                textAvecStyle('0:0', 0.8),
                const Spacer(),
                textAvecStyle('0:22', 0.8),
              ],
            ),
            Slider(
                value: position,
                min: 0,
                max: 30,
                inactiveColor: Colors.white,
                activeColor: Colors.red,
                onChanged: (double d) {
                  setState(() {
                    position = d;
                  });
                })
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  IconButton bouton(IconData icone, double taille, ActionMusic action) {
    return IconButton(
      iconSize: taille,
      color: Colors.white,
      icon: Icon(icone),
      onPressed: () {
        switch (action) {
          case ActionMusic.play:
            print("play");
            break;
          case ActionMusic.pause:
            print("pause");
            break;
          case ActionMusic.forward:
            print("forward");
            break;
          case ActionMusic.rewind:
            print("rewind");
            break;
          default:
        }
      },
    );
  }

  Text textAvecStyle(String data, double scale) {
    return Text(
      data,
      // ignore: deprecated_member_use
      textScaleFactor: scale,
      textAlign: TextAlign.center,
      style: const TextStyle(
          color: Colors.white, fontSize: 20, fontStyle: FontStyle.italic),
    );
  }
}

void configurationAudioPlayer() {
  audioPlayer = AudioPlayer();
}

enum ActionMusic { play, pause, rewind, forward }

enum PlayerState { playing, stopped, paused }
