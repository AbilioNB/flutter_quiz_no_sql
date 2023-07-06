import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF30B3B7), // Cor da barra de aplicativos
        title: Text('Material de Apoio'),
      ),
      body: Container(
        color: Colors.white, // Fundo branco
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            HelpCard(
              cardName: 'MongoDB University',
              cardLink: 'https://university.mongodb.com/',
            ),
            HelpCard(
              cardName: 'Redis Labs Training',
              cardLink: 'https://redislabs.com/redis-best-practices/redis-training/',
            ),
            HelpCard(
              cardName: 'Couchbase Developer Portal',
              cardLink: 'https://developer.couchbase.com/',
            ),
            HelpCard(
              cardName: 'Neo4j GraphAcademy',
              cardLink: 'https://neo4j.com/graphacademy/',
            ),
            HelpCard(
              cardName: 'Cassandra Documentation',
              cardLink: ' https://cassandra.apache.org/doc/latest/',
            ),
            HelpCard(
              cardName: 'O que é NoSQL?',
              cardLink: 'https://www.oracle.com/br/database/nosql/what-is-nosql/',
            ),
            HelpCard(
              cardName: 'Blog do Lomadee',
              cardLink: 'https://www.lomadee.com/blog/tudo-sobre-banco-de-dados-nosql/',
            ),
            HelpCard(
              cardName: 'Couchbase Brasil',
              cardLink: 'https://www.couchbase.com.br/',
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Voltar'),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF1D63CB), // Cor do botão Voltar
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HelpCard extends StatefulWidget {
  final String cardName;
  final String cardLink;

  HelpCard({required this.cardName, required this.cardLink});

  @override
  _HelpCardState createState() => _HelpCardState();
}

class _HelpCardState extends State<HelpCard> {
  bool isExpanded = false;

  void _toggleExpand() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  void _launchURL() async {
    if (await canLaunch(widget.cardLink)) {
      await launch(widget.cardLink);
    } else {
      throw 'Não foi possível abrir o link: ${widget.cardLink}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          ListTile(
            title: Text(
              widget.cardName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Icon(
              isExpanded ? Icons.expand_less : Icons.expand_more,
            ),
            onTap: _toggleExpand,
          ),
          if (isExpanded)
            ListTile(
              title: Text(widget.cardLink),
              onTap: _launchURL,
            ),
        ],
      ),
    );
  }
}
