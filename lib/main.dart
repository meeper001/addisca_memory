import 'package:flutter/material.dart';

import 'memory_game_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memory',
      theme: ThemeData(
          primaryColor: Colors.lightBlue,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 28),
                backgroundColor: Colors.grey[400],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                )),
          )),
      home: const MyHomePage(title: 'Memory'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 40,
            ),
            const Text(
              'Wähle die Anzahl der Karten',
              style: TextStyle(fontSize: 28),
            ),
            const SizedBox(
              height: 40,
            ),
            (GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              padding: const EdgeInsets.all(50),
              mainAxisSpacing: 50,
              crossAxisSpacing: 50,
              children: List.generate(4, (index) {
                return chooseCardCountButton(context, index * 2 + 4);
              }),
            )),
          ],
        ),
      ),
    );
  }

  Widget chooseCardCountButton(BuildContext context, int cardCount) {
    return SizedBox(
        width: 100,
        height: 100,
        child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      MemoryGameScreen(cardCount: cardCount)));
            },
            child: Text(
              cardCount.toString(),
            )));
  }
}
