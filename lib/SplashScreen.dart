import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:food_order/Cheackuser.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: 'assets/images/dj.jpeg',
      nextScreen: Cheackuser(),
      duration: 2000,
      splashTransition: SplashTransition.sizeTransition,
      backgroundColor: const Color.fromARGB(255, 27, 30, 37),
    );
  }
}
