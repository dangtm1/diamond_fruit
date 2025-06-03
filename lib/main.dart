import 'package:flutter/material.dart';
import 'game_screen.dart';
import 'level_select_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fruit Game',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const LevelSelectScreen(),        // Màn hình chính
        '/game': (context) => const GameScreen(),    // Truyền level qua arguments
      },
    );
  }
}
