import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:mvc2_card_game/api/api.dart';
import 'package:mvc2_card_game/models/character.dart';
import 'package:playing_cards/playing_cards.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
          future: Api.getCharacter('Akuma'),
          builder: (builder, snapshot) {
            final character = snapshot.data as Character;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (snapshot.hasData)
                    Container(
                      height: 550,
                      decoration: BoxDecoration(
                        color: const Color(0xff7c94b6),
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: NetworkImage(
                            (character.headShot!),
                            scale: .5,
                          ),
                        ),
                      ),
                    )
                ],
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
