import 'package:flame_audio/flame_audio.dart';

class AudioController {
  static bool isMusicOn = true;
  static bool isGameMusicOn = true;

  static Future<void> playMenuMusic() async {
    if (isMusicOn) {
      await FlameAudio.bgm.stop(); // dừng nhạc cũ nếu có
      await FlameAudio.bgm.play('game_music.wav', volume: 0.5);
    }
  }

  static Future<void> playGameMusic() async {
    if (isGameMusicOn) {
      await FlameAudio.bgm.stop();
      await FlameAudio.bgm.play('game_music.wav', volume: 0.5);
    }
  }

  static void stopMusic() async {
    await FlameAudio.bgm.stop();
  }

  static void toggleMenuMusic(bool value) {
    isMusicOn = value;
    if (value) {
      playMenuMusic();
    } else {
      stopMusic();
    }
  }

  static void toggleGameMusic(bool value) {
    isGameMusicOn = value;
    if (!value) stopMusic();
  }
}
