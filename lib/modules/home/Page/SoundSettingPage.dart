import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

class SoundSettingsPage extends StatefulWidget {
  const SoundSettingsPage({super.key});

  @override
  State<SoundSettingsPage> createState() => _SoundSettingsPageState();
}

class _SoundSettingsPageState extends State<SoundSettingsPage> {
  double musicVolume = 0.5;
  double effectVolume = 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFF7E57C2),
        title: Text(
          'sound_desc'.tr,
          style: const TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Icon(Icons.music_note, size: 60, color: Colors.deepPurple),
            const SizedBox(height: 10),
            Text(
              'music_config'.tr,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            Slider(
              value: musicVolume,
              min: 0,
              max: 1,
              divisions: 10,
              label: '${(musicVolume * 100).round()}%',
              onChanged: (value) {
                setState(() {
                  musicVolume = value;
                });
              },
              activeColor: Colors.purple,
              thumbColor: Colors.orange,
            ),
            const SizedBox(height: 30),
            const Icon(Icons.volume_up, size: 60, color: Colors.deepPurple),
            const SizedBox(height: 10),
            Text(
              'sound_config'.tr,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            Slider(
              value: effectVolume,
              min: 0,
              max: 1,
              divisions: 10,
              label: '${(effectVolume * 100).round()}%',
              onChanged: (value) {
                setState(() {
                  effectVolume = value;
                });
              },
              activeColor: Colors.purple,
              thumbColor: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }
}
