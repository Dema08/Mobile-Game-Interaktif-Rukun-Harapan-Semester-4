import 'package:NumeriGo/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' as devtools show log;
import '../home/Page/SoundSettingPage.dart';
import '../home/Page/LanguageSettingPage.dart';
import '../home/Page/AboutPage.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFF7551E9),
      appBar: AppBar(
        title: Text(
          'settings'.tr,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: primary90Color,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [primary90Color, primary70Color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildCardItem(
              icon: Icons.volume_up,
              title: 'sound'.tr,
              subtitle: 'sound_desc'.tr,
              color: Colors.green,
              onTap: () {
                devtools.log('Navigasi ke Suara');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SoundSettingsPage()),
                );
              },
            ),
            _buildCardItem(
              icon: Icons.language,
              title: 'language'.tr,
              subtitle: 'language_desc'.tr,
              color: Colors.blue,
              onTap: () {
                devtools.log('Navigasi ke Bahasa');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const LanguageSettingsPage()),
                );
              },
            ),
            _buildCardItem(
              icon: Icons.info,
              title: 'about_app'.tr,
              subtitle: 'about_app_desc'.tr,
              color: Colors.red,
              onTap: () {
                devtools.log('Navigasi ke Tentang Aplikasi');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AboutPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        leading: CircleAvatar(
          backgroundColor: color,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 14),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
