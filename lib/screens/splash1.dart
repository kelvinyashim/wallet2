import 'package:flutter/material.dart';

class Splash1 extends StatelessWidget {
  const Splash1({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Image.asset(
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,

        "lib/assets/splash1.png"),
    );
  }
}