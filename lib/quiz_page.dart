import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'score_page.dart';
import 'question.dart';
import 'questions.dart';

const int totalSecondsPerQuestion = 25;

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
  List<Question> questions = [];

  @override
  void initState() {
    super.initState();
    startTimer();
    questions = getRandomQuestions();
  }

  List<Question> getRandomQuestions() {
    List<int> questionIds = generateRandomQuestionIds(30, 12);
    return allQuestions.where((question) => questionIds.contains(question.id)).toList();
  }


  List<int> generateRandomQuestionIds(int maxId, int count) {
    final List<int> ids = [];
    final Random random = Random();
    while (ids.length < count) {
      final int id = random.nextInt(maxId) + 1;
      if (!ids.contains(id)) {
        ids.add(id);
      }
    }
    return ids;
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
    if (selectedIndex == questions[questionIndex].correctAnswer) {
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Pergunta ${questionIndex + 1}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text(
                    questions[questionIndex].question_text,
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: List.generate(
                  questions[questionIndex].options.length,
                      (index) {
                    return ElevatedButton(
                      onPressed: () {
                        checkAnswer(index);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        padding: MaterialStateProperty.all(EdgeInsets.all(15)),
                      ),
                      child: Text(
                        questions[questionIndex].options[index],
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: LinearProgressIndicator(
              value: progressValue,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              'Tempo restante: $secondsRemaining segundos',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
