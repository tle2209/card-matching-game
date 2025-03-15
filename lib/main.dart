import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/game_screen.dart';
import 'providers/game_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => GameProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: GameScreen(),
      ),
    ),
  );
}
