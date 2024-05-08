// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:front_end/views/screens/LoginScreen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Lottie.asset('assets/SplashLogo.json'),
      backgroundColor: Color.fromARGB(255, 0, 129, 223),
      nextScreen: LoginScreen(),
      splashIconSize: 200,
      duration: 5000,
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}
