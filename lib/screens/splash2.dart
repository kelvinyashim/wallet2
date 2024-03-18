import 'package:flutter/material.dart';

class Splash2 extends StatelessWidget {
  const Splash2({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
          child: Image.asset(
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            "lib/assets/splash2.png"),
                );
  }
}