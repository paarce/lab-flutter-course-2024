import 'package:adv_basics/widgets/results_contanier.dart';
import 'package:flutter/material.dart';

import 'package:adv_basics/widgets/question_container.dart';
import 'package:adv_basics/widgets/landig_contanier.dart';

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  State<QuizApp> createState() {
    return _QuizAppState();
  }
}

class _QuizAppState extends State<QuizApp> {
  List<String> _selectedAnswers = [];
  Widget? currentScreen;

  @override
  void initState() {
    currentScreen = LandigContanier(switchScreen);
    super.initState();
  }

  void onCompleted() {
    setState(() {
      currentScreen = ResultContainer(
        onRestart: resetQuiz,
        selectedAnswers: _selectedAnswers,
      );
    });
  }

  void onSelectAnswer(String answer) {
    _selectedAnswers.add(answer);
  }

  void switchScreen() {
    setState(() {
      currentScreen = QuestionContainer(
        onSelectAnswer: onSelectAnswer,
        onCompleted: onCompleted,
      );
    });
  }

  void resetQuiz() {
    _selectedAnswers = [];
    setState(() {
      currentScreen = LandigContanier(switchScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 94, 27, 105),
          ),
          child: currentScreen,
        ),
      ),
    );
  }
}
