import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

import 'package:adv_basics/questions.dart';

class ResultContainer extends StatelessWidget {
  const ResultContainer(
      {super.key,
      required this.selectedAnswers,
      required Function() this.onRestart});

  final List<String> selectedAnswers;
  final void Function() onRestart;

  List<Map<String, Object>> get summaryData {
    return selectedAnswers.asMap().entries.map((item) {
      return {
        'title': questions[item.key].text,
        'real_answer': questions[item.key].answers[0],
        'user_answer': item.value,
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final totalQuestion = questions.length;
    final summary = summaryData;
    final correctAnswer = summary.where((item) => item['real_answer'] == item['user_answer']).length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your answered $correctAnswer out of $totalQuestion questions correctly!',
              style: GoogleFonts.lato(
                color: const Color.fromARGB(255, 153, 85, 176),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            ResultsSummary(summary),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton.icon(
              onPressed: onRestart,
              icon: const Icon(Icons.restart_alt),
              label: const Text('Restart quiz'),
            )
          ],
        ),
      ),
    );
  }
}

class ResultsSummary extends StatelessWidget {
  const ResultsSummary(this.summaryData, {super.key});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: SingleChildScrollView(
        child: Column(
          children: summaryData.asMap().entries.map((item) {
            final index = item.key + 1;
            final question = item.value;
            final isCorrect = question['real_answer'] == question['user_answer'];
            final bubbleColor = isCorrect ? 
              const Color.fromARGB(255, 118, 127, 222) : 
              const Color.fromARGB(255, 153, 85, 176);
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 30, height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: bubbleColor),
                    child: Center(child: Text(index.toString()))
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(question['title'] as String,
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,),
                        Text(question['real_answer'] as String,
                            style: GoogleFonts.lato(
                              color: const Color.fromARGB(255, 153, 85, 176),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,),
                        Text(question['user_answer'] as String,
                            style: GoogleFonts.lato(
                              color: const Color.fromARGB(255, 118, 113, 211),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left),
                      ],
                    ),
                  )
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
