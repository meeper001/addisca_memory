import 'dart:async';

import 'package:addisca_memory/card.dart';
import 'package:flutter/material.dart';

import 'memory_game.dart';

class MemoryGameScreen extends StatefulWidget {
  final int cardCount;
  const MemoryGameScreen({super.key, required this.cardCount});

  @override
  State<MemoryGameScreen> createState() => _MemoryGameScreenState();
}

class _MemoryGameScreenState extends State<MemoryGameScreen> {
  late MemoryGame game;
  late Timer timer;

  @override
  void initState() {
    game = MemoryGame(widget.cardCount ~/ 2);
    timer = Timer(const Duration(seconds: 1), () {});
    timer.cancel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memory'),
      ),
      body: gameScreenBody(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (timer.isActive) {
              timer.cancel();
            }
            game.resetGame();
          });
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Widget gameScreenBody(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 40,
        ),
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          padding: const EdgeInsets.all(20),
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          children: [for (var card in game.cards) cardButton(context, card)],
        ),
        Text('Paare: ${game.foundPairs.toString()}',
            style: const TextStyle(fontSize: 20)),
        Text(
          'Versuche: ${game.tries.toString()}',
          style: const TextStyle(fontSize: 20),
        ),
      ],
    );
  }

  Widget cardButton(context, MemoryCard card) {
    var icon = Image.asset('assets/images/card_backside.jpg');
    if (card.flipped) {
      icon = Image.asset('assets/images/card${card.pairId.toString()}.jpg');
    }
    return IconButton(
      onPressed: () {
        if (timer.isActive) {
          timer.cancel();
          game.flipCards();
        }
        var flip = false;
        flip = game.selectCard(card);
        setState(() {});
        if (flip) {
          timer = Timer(const Duration(seconds: 1), () {
            game.flipCards();
            setState(() {});
          });
        }
      },
      icon: icon,
    );
  }
}
