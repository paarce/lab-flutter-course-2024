import 'package:flutter/material.dart';

import 'package:first_app/dice_roller/gradient_container.dart';

// DiceRoller
void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: GradientContainer([
          Color.fromARGB(255, 26, 2, 80),
          Color.fromARGB(255, 45, 7, 98)
        ]),
      ),
    ),
  );
}
