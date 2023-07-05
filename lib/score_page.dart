import 'package:flutter/material.dart';
import 'home_page.dart';

class ScorePage extends StatelessWidget {
  final String playerName;
  final int score;

  ScorePage(this.playerName, this.score);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pontuação'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Parabéns, $playerName!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              'Sua pontuação: $score',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Text('Voltar para a tela principal'),
            ),
          ],
        ),
      ),
    );
  }
}
