
import 'dart:convert';
import 'package:flutter/services.dart';

Future<List<LevelConfig>> loadLevelConfigs() async {
  final String jsonString = await rootBundle.loadString('assets/levels.json');
  final List<dynamic> jsonList = json.decode(jsonString);
  return jsonList.map((e) => LevelConfig.fromJson(e)).toList();
}

class LevelConfig {
  final int level;
  final int moves;
  final int targetScore;

  LevelConfig({
    required this.level,
    required this.moves,
    required this.targetScore,
  });

  factory LevelConfig.fromJson(Map<String, dynamic> json) {
    return LevelConfig(
      level: json['level'],
      moves: json['moves'],
      targetScore: json['targetScore'],
    );
  }
}
