import 'package:flutter/material.dart';
class VolumeSettingsModal extends StatefulWidget {
  final bool isMenuMusicOn;
  final bool isGameMusicOn;
  final ValueChanged<bool> onToggleMenuMusic;
  final ValueChanged<bool> onToggleGameMusic;

  const VolumeSettingsModal({
    Key? key,
    required this.isMenuMusicOn,
    required this.isGameMusicOn,
    required this.onToggleMenuMusic,
    required this.onToggleGameMusic,
  }) : super(key: key);

  @override
  State<VolumeSettingsModal> createState() => _VolumeSettingsModalState();
}

class _VolumeSettingsModalState extends State<VolumeSettingsModal> {
  late bool menuMusic;
  late bool gameMusic;

  @override
  void initState() {
    super.initState();
    menuMusic = widget.isMenuMusicOn;
    gameMusic = widget.isGameMusicOn;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Cài đặt âm thanh', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

          const SizedBox(height: 16),
          _buildSwitchRow('Nhạc nền', menuMusic, (v) {
            setState(() => menuMusic = v);
            widget.onToggleMenuMusic(v);
          }),
        ],
      ),
    );
  }

  Widget _buildSwitchRow(String label, bool value, ValueChanged<bool> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Switch(value: value, onChanged: onChanged),
      ],
    );
  }
}
