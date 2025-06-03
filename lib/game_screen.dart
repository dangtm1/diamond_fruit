import 'package:flutter/material.dart';
import 'package:fruit_match_game/fruit_game_widget.dart';
import 'fruit_game_widget.dart';
import 'services/level_config.dart'; // Widget chứa FlameGame

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LevelConfig config = ModalRoute.of(context)?.settings.arguments as LevelConfig;

    return Scaffold(
      body: FruitGameWidget(config: config),
    );
  }
}