import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Animal {
  final String name;
  final Color color;
  final LottieBuilder lottie;

  Animal({
    required this.name,
    required this.color,
    required this.lottie,
  });
}
