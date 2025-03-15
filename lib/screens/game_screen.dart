import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/card_widget.dart';
import '../providers/game_provider.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Card Matching Game")),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 6,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemCount: gameProvider.cards.length,
        itemBuilder: (context, index) {
          return CardWidget(
            card: gameProvider.cards[index],
            onTap: () {
              gameProvider.flipCard(gameProvider.cards[index]);
            },
          );
        },
      ),
    );
  }
}
