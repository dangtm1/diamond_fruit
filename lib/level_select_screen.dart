import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controllers/audio_controller.dart';
import 'services/level_config.dart';
import 'services/level_storage.dart';

class LevelSelectScreen extends StatefulWidget {
  const LevelSelectScreen({Key? key}) : super(key: key);

  @override
  State<LevelSelectScreen> createState() => _LevelSelectScreenState();
}

class _LevelSelectScreenState extends State<LevelSelectScreen> {
  int unlockedLevel = 1;
  List<LevelConfig> levels = [];
  LevelConfig levelLocal = LevelConfig(level: 0, moves: 0, targetScore: 0);

  @override
  void initState() {
    AudioController.stopMusic();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await loadUnlockedLevel();
      final levelData = await loadLevelConfigs();
      setState(() {
        levels = levelData;
      });
    });
  }

  Future<void> loadUnlockedLevel() async {
    final prefs = await LevelStorage.getUnlockedLevel();
    setState(() {
      unlockedLevel = prefs ?? 1;
    });
  }

  Future<void> _openLevel(config) async {
    AudioController.playMenuMusic();
    await Navigator.pushNamed(context, '/game', arguments: config);
    await loadUnlockedLevel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 24, bottom: 16),
                  child: Center(
                    child: Text(
                      'Chọn Màn Chơi',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverPadding(
                        padding: const EdgeInsets.all(12),
                        sliver: SliverGrid(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 1,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final config = levels.length > index ? levels[index] : levelLocal;
                              final level = config.level;
                              final bool isUnlocked = level <= unlockedLevel;
                              return Stack(
                                children: [
                                  Positioned.fill(
                                    child: Image.asset(
                                      'assets/images/wood.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: isUnlocked ? () => _openLevel(config) : null,
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: isUnlocked
                                            ? Text(
                                                'Level $level',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            : const Icon(Icons.lock, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                            childCount: 100,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ),
        ],
      ),
    );

  }
}
