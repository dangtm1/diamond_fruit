import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    late int unlockedLevel = 11;
    return Scaffold(
      body: Stack(
        children: [
          // Ảnh nền
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
            ),
          ),

          // Lớp phủ mờ tùy chọn
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.3),
            ),
          ),

          // Nội dung
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 24),

                // Tiêu đề / logo
                const Text(
                  'Chọn Màn Chơi',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 16),

                // Grid level
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: GridView.builder(
                      itemCount: 100,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (context, index) {
                        final level = index + 1;
                        final bool isUnlocked = level <= unlockedLevel;

                        return Stack(
                          children: [
                            // Nền cho từng ô (ảnh nền riêng nếu muốn)
                            Positioned.fill(
                              child: Image.asset(
                                'assets/images/wood.png', // Ảnh nền từng ô
                                fit: BoxFit.cover,
                              ),
                            ),

                            // Nút hoặc khóa
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: isUnlocked
                                    ? () {
                                        Navigator.pushNamed(
                                          context,
                                          '/game',
                                          arguments: level,
                                        );
                                      }
                                    : null,
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
                      }
                    ),
                  ),
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
