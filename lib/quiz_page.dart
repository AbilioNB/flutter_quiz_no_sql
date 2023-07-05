import 'dart:async';
import 'package:flutter/material.dart';
import 'score_page.dart';
import 'question.dart';

const int totalSecondsPerQuestion = 25; // Tempo total para responder cada pergunta em segundos

class QuizPage extends StatefulWidget {
  final String playerName;

  QuizPage(this.playerName);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int questionIndex = 0;
  int score = 0;
  int secondsRemaining = totalSecondsPerQuestion;
  Timer? timer;
  final List<Question> questions = [
    Question('Pergunta 1', ['Resposta 1', 'Resposta 2', 'Resposta 3'], 0),
    Question('Pergunta 2', ['Resposta 1', 'Resposta 2', 'Resposta 3'], 1),
    // Adicione as perguntas restantes aqui
  ];

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (secondsRemaining > 0) {
          secondsRemaining--;
        } else {
          timer.cancel();
          goToNextQuestion();
        }
      });
    });
  }

  void goToNextQuestion() {
    if (questionIndex < questions.length - 1) {
      setState(() {
        questionIndex++;
        secondsRemaining = totalSecondsPerQuestion;
        startTimer();
      });
    } else {
      if (mounted) {
        timer?.cancel();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ScorePage(widget.playerName, score),
          ),
        );
      }
    }
  }

  void checkAnswer(int selectedIndex) {
    if (selectedIndex == questions[questionIndex].correctAnswerIndex) {
      setState(() {
        score++;
      });
    }
    goToNextQuestion();
  }

  @override
  Widget build(BuildContext context) {
    double progressValue = secondsRemaining / totalSecondsPerQuestion;

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Pergunta ${questionIndex + 1}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              questions[questionIndex].questionText,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Column(
              children: List.generate(
                questions[questionIndex].options.length,
                    (index) {
                  return ElevatedButton(
                    onPressed: () {
                      checkAnswer(index);
                    },
                    child: Text(questions[questionIndex].options[index]),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            LinearProgressIndicator(
              value: progressValue,
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            SizedBox(height: 20),
            Text(
              'Tempo restante: $secondsRemaining segundos',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
