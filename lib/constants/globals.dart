import 'package:quize/models/animal.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Globals {
  Globals._();

  static const googleAIStudioAPIKey = 'AIzaSyCeqKDI2PlPrFtk8ylQEWLMVY3G8AZtKXY';

  /// animals
    static final animal = <Animal>[
      Animal(
        name: 'cat',
        color: Colors.white10,
        lottie: lottieCat,
      ),
      Animal(
        name: 'dog',
        color: Colors.yellow.shade700,
        lottie: lottieDog,
      ),
      Animal(
        name: 'elephant',
        color: Colors.blueGrey.shade700,
        lottie: lottieElephant,
      ),
      Animal(
        name: 'giraffe',
        color: Colors.orangeAccent,
        lottie: lottieGiraffe,
      ),
      Animal(
        name: 'koala',
        color: Colors.blueGrey,
        lottie: lottieKoala,
      ),
      Animal(
        name: 'lion',
        color: Colors.green.shade700,
        lottie: lottieLion,
      ),
      Animal(
        name: 'monkey',
        color: Colors.purple.shade900,
        lottie: lottieMonkey,
      ),
      Animal(
        name: 'tiger',
        color: Colors.black87,
        lottie: lottieTiger,
      )
    ];

  ///Lottie Files -Animal
  static final lottieCat = Lottie.asset(
    'assets/animal/cat.json',
    width: 300,
    height: 300,
  );

  static final lottieDog = Lottie.asset(
    'assets/animal/dog.json',
    width: 300,
    height: 300,
  );

  static final lottieElephant = Lottie.asset(
    'assets/animal/elephant.json',
    width: 300,
    height: 300,
  );

  static final lottieGiraffe = Lottie.asset(
    'assets/animal/giraffe.json',
    width: 300,
    height: 300,
  );

  static final lottieKoala = Lottie.asset(
    'assets/animal/koala.json',
    width: 300,
    height: 300,
  );

  static final lottieLion = Lottie.asset(
    'assets/animal/lion.json',
    width: 300,
    height: 300,
  );

  static final lottieMonkey = Lottie.asset(
    'assets/animal/monkey.json',
    width: 300,
    height: 300,
  );

  static final lottieTiger = Lottie.asset(
    'assets/animal/tiger.json',
    width: 300,
    height: 300,
  );

  static final lottieLoading = Lottie.asset(
    'assets/animal/loading.json',
    width: 300,
    height: 300,
  );


}
