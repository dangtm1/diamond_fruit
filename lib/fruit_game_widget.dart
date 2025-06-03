import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:fruit_match_game/services/level_config.dart';
import 'fruit_game.dart';

class FruitGameWidget extends StatelessWidget {
  final LevelConfig config;

  const FruitGameWidget({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: FruitGame(config: config), // Truyền game bạn muốn chạy
      overlayBuilderMap: {
        'GameOver': (context, game) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Game Over!', style: TextStyle(fontSize: 32)),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Quay lại menu
                  },
                  child: const Text('Trở về menu'),
                ),
              ],
            ),
          );
        },
      },
    );
  }
}
