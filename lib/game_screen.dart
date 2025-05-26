import 'package:flutter/material.dart';
import 'package:fruit_match_game/fruit_game_widget.dart';
import 'fruit_game_widget.dart'; // Widget chứa FlameGame

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final int level = ModalRoute.of(context)?.settings.arguments as int? ?? 1;

    return Scaffold(
      body: FruitGameWidget(level: level),
    );
  }
}