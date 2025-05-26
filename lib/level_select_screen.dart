import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LevelSelectScreen extends StatefulWidget {
  const LevelSelectScreen({Key? key}) : super(key: key);

  @override
  State<LevelSelectScreen> createState() => _LevelSelectScreenState();
}

class _LevelSelectScreenState extends State<LevelSelectScreen> {
  int unlockedLevel = 1;

  @override
  void initState() {
    super.initState();
    loadProgress();
  }

  Future<void> loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      unlockedLevel = prefs.getInt('unlockedLevel') ?? 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Ảnh nền
          Positioned.fill(
            child: Image.asset(
              'assets/images/wood.png', // Đổi thành ảnh bạn muốn dùng
              fit: BoxFit.cover,
            ),
          ),
          // Danh sách level
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              itemCount: 100,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                final level = index + 1;
                final isUnlocked = level <= unlockedLevel;

                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isUnlocked ? Colors.blue : Colors.grey.shade700,
                  ),
                  onPressed: isUnlocked
                      ? () {
                          Navigator.pushNamed(context, '/game', arguments: level);
                        }
                      : null,
                  child: isUnlocked
                      ? Text('Level $level')
                      : const Icon(Icons.lock, color: Colors.white),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
