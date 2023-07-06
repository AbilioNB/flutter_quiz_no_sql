import 'package:flutter/material.dart';
import 'home_page.dart';

class ScorePage extends StatelessWidget {
  final String playerName;
  final int score;

  ScorePage(this.playerName, this.score);

  Color _getScoreColor() {
    if (score == 12) {
      return Colors.green[900]!;
    } else if (score > 9 && score < 12) {
      return Colors.green;
    } else if (score > 5 && score <= 9) {
      return Colors.yellow;
    } else {
      return Colors.red;
    }
  }

  String _getScoreMessage() {
    if (score == 12) {
      return 'Parabéns, excelente trabalho!';
    } else if (score > 9 && score < 12) {
      return 'Bom trabalho, você obteve uma boa pontuação.';
    } else if (score > 5 && score <= 9) {
      return 'Poderia ser melhor, que tal  acessar o material de apoio?';
    } else {
      return 'Poxa, é importante estudar novamente os conceitos, acesse o material de apoio.';
    }
  }

  @override
  Widget build(BuildContext context) {
    Color scoreColor = _getScoreColor();
    String scoreMessage = _getScoreMessage();

    return Scaffold(
      appBar: AppBar(
        title: Text('Pontuação'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$playerName',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Sua pontuação: $score',
              style: TextStyle(fontSize: 18, color: scoreColor),
            ),
            SizedBox(height: 20),
            Text(
              scoreMessage,
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                padding: MaterialStateProperty.all(EdgeInsets.all(15)),
              ),
              child: Text(
                'Tela Inicial',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
