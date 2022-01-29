import 'package:animated_splash_screen/animated_splash_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:order_app/screens/tabscreen.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Text("aaaa"),
      nextScreen: const Tab_Screen(),
      splashTransition: SplashTransition.rotationTransition,
      function: () async {
        return await Firebase.initializeApp();
      },
    );
  }
}
