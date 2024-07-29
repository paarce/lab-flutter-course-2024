import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:adv_basics/questions.dart';

class QuestionContainer extends StatefulWidget {
  const QuestionContainer(
      {
        super.key, 
        required Function(String answer) this.onSelectAnswer,
        required Function() this.onCompleted
      }
    );

  final void Function(String answer) onSelectAnswer;
  final void Function() onCompleted;

  @override
  State<StatefulWidget> createState() {
    return _QuestionContainerState();
  }
}

class _QuestionContainerState extends State<QuestionContainer> {
  var currentQuestionIndex = 0;
  void onAnswerSelected(String answer) {
      widget.onSelectAnswer(answer);

    if ((currentQuestionIndex + 1) < questions.length) {
      setState(() {
          currentQuestionIndex++;
      });
    } else {
      widget.onCompleted();
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];

    return Center(
      child: Container(
        margin: const EdgeInsets.all(24),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                currentQuestion.text,
                style: GoogleFonts.lato(
                  color: const Color.fromARGB(255, 153, 85, 176),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              ...currentQuestion.suffleAnswers.map((item) {
                return AnswerButton(
                  item,
                  () {
                    onAnswerSelected(item);
                  }
                );
              }),
            ]),
      ),
    );
  }
}

class AnswerButton extends StatelessWidget {
  const AnswerButton(this.text, this.onTap, {super.key});

  final String text;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 49, 10, 60),
          foregroundColor: Colors.white),
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    );
  }
}
