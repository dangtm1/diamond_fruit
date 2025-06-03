import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as material;
import 'package:flame/input.dart';

import 'controllers/audio_controller.dart';
import 'volume_settings_modal.dart';


class TopBarComponent extends PositionComponent with HasGameRef{

  late final TextComponent levelText;
  late final TextComponent movesText;
  late final TextComponent scoreText;

  final void Function()? onBack;

  int level;
  int movesLeft;
  int score;

  TopBarComponent({
    required this.level,
    required this.movesLeft,
    required this.score,
    this.onBack
  });

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final context = gameRef.buildContext;
    final backButton = ButtonComponent(
      position: Vector2(10, 10),
      size: Vector2(60, 40),
      button: RectangleComponent()
        ..add(
          TextComponent(
            text: "←",
            anchor: Anchor.topLeft,
            position: Vector2(0, 0),
            textRenderer: TextPaint(style: const TextStyle(fontSize: 24, color: Colors.white)),
          ),
        ),
      onPressed: () {
        AudioController.stopMusic();
        final contextBack = gameRef.buildContext;
        if (contextBack != null) {
          material.Navigator.of(contextBack).pop();
        }
      },
    );
    add(backButton);
    levelText = TextComponent(
      text: "Màn: $level",
      anchor: Anchor.topCenter,
      position: Vector2(size.x / 2, 10),
      textRenderer: TextPaint(style: const TextStyle(fontSize: 20, color: Colors.white)),
    );
    add(levelText);
    final settingsButton = ButtonComponent(
      position: Vector2(size.x - 40, 10),
      size: Vector2(30, 30),
      button: RectangleComponent()
        ..add(
          TextComponent(
            text: "⚙",
            position: Vector2(0, 0),
            textRenderer: TextPaint(style: const TextStyle(fontSize: 24, color: Colors.white)),
          ),
        ),
      onPressed: () {
        final context = gameRef.buildContext;
        showModalBottomSheet(
          context: context!,
          builder: (context) => VolumeSettingsModal(
            isMenuMusicOn: AudioController.isMusicOn,
            isGameMusicOn: AudioController.isGameMusicOn,
            onToggleMenuMusic: AudioController.toggleMenuMusic,
            onToggleGameMusic: AudioController.toggleGameMusic,
          )
        );
      }
    );
    add(settingsButton);

    movesText = TextComponent(
      text: "Lượt: $movesLeft",
      anchor: Anchor.topLeft,
      position: Vector2(10, 45),
      textRenderer: TextPaint(style: const TextStyle(fontSize: 18, color: Colors.white)),
    );
    add(movesText);

    scoreText = TextComponent(
      text: "Điểm: $score",
      anchor: Anchor.topRight,
      position: Vector2(size.x - 10, 45),
      textRenderer: TextPaint(style: const TextStyle(fontSize: 18, color: Colors.white)),
    );
    add(scoreText);
  }

  void updateMoves(int moves) {
    movesLeft = moves;
    movesText.text = "Lượt: $movesLeft";
  }

  void updateScore(int newScore) {
    score = newScore;
    scoreText.text = "Điểm: $score";
  }

  void updateLevel(int newLevel) {
    level = newLevel;
    levelText.text = "Màn: $level";
  }
}
