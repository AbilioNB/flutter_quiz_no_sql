import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informações'),
      ),
      body: Center(
        child: Text(
          'Algumas informações sobre o aplicativo...',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
