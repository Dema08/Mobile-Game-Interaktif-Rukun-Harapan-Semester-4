import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:NumeriGo/routes/route_names.dart';
import 'package:NumeriGo/modules/Profile/SettingPage.dart';
import 'package:NumeriGo/constants/colors.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../data/network/response_call.dart';
import '../home/widget/background_home.dart';
import 'Controller/ProfileController.dart';

class ProfilePage extends StatelessWidget {
  final _controller = Get.put(ProfileController());

  ProfilePage({super.key}) {
    // _controller.fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECE4FF),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [primary90Color, primary70Color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Obx(() {
          final profileState = _controller.profileCall.value;
          final user = _controller.userProfile.value;
          final kelas = _controller.kelasUser.value;
          if (profileState.status == Status.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (profileState.status == Status.error) {
            return Center(
                child: Text(profileState.message ?? 'Error loading profile'));
          }

          final profile = profileState.data;

          return Column(
            children: [
              // Header Section
              Container(
                padding: const EdgeInsets.only(top: 50, bottom: 20),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.pinkAccent.shade100,
                      child: Text(
                        user?.fullName?.isNotEmpty == true
                            ? user!.fullName![0]
                            : '?',
                        style:
                            const TextStyle(fontSize: 36, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      user?.fullName ?? 'student_name'.tr,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'welcome_friend'.tr,
                      style: const TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 700.ms).slide(
                    begin: Offset(0, 0),
                    end: Offset(0, 0),
                    duration: 600.ms,
                  ),

              // Content Section
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  child: Stack(
                    children: [
                      const BackgroundHome(backgroundColor: primary90Color),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            _buildProfileCard(
                              icon: Icons.school,
                              title: 'class'.tr,
                              value: user?.namaKelas ?? "-",
                              color: const Color(0xFFD0B4FF),
                              iconColor: const Color(0xFF7551E9),
                            ).animate().fadeIn(duration: 400.ms).slide(
                                  begin: Offset(-1, 0),
                                  end: Offset(0, 0),
                                  duration: 400.ms,
                                ),

                            const SizedBox(height: 10),

                            _buildProfileCard(
                              icon: Icons.emoji_events,
                              title: 'ranking'.tr,
                              value: user?.ranking != null
                                  ? "#${user?.ranking}"
                                  : "#-",
                              color: const Color(0xFFFFE0B2),
                              iconColor: Colors.orange,
                            ).animate().fadeIn(duration: 500.ms).slide(
                                  begin: Offset(-1, 0),
                                  end: Offset(0, 0),
                                  duration: 500.ms,
                                ),

                            const SizedBox(height: 10),

                            _buildProfileCard(
                              icon: Icons.calendar_month,
                              title: 'day_login'.tr,
                              value: user?.harimasuk != null
                                  ? "${user!.harimasuk} ${'days'.tr}"
                                  : "0",
                              color: const Color(0xFFBBDEFB),
                              iconColor: Colors.blue,
                            ).animate().fadeIn(duration: 600.ms).slide(
                                  begin: Offset(-1, 0),
                                  end: Offset(0, 0),
                                  duration: 600.ms,
                                ),

                            const SizedBox(height: 20),

                            // Buttons Section
                            Column(
                              children: [
                                _buildActionButton(
                                  icon: Icons.settings,
                                  label: 'settings'.tr,
                                  onPressed: () =>
                                      Get.to(() => const SettingsPage()),
                                  color: primary90Color,
                                ),
                                const SizedBox(height: 12),
                                _buildActionButton(
                                  icon: Icons.logout,
                                  label: 'logout'.tr,
                                  onPressed: () => _showLogoutDialog(context),
                                  color: Colors.redAccent,
                                ),
                              ],
                            ).animate().fadeIn(duration: 700.ms),
                          ],
                        ),
                      ).animate().slide(
                          begin: Offset(0, 0.1),
                          end: Offset(0, 0),
                          duration: 400.ms),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildProfileCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.25),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: iconColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: iconColor.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      icon: Icon(icon),
      label: Text(label, style: const TextStyle(fontSize: 16)),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFFFBEAFF),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.exit_to_app, size: 60, color: Colors.purple),
              const SizedBox(height: 16),
              Text(
                'logout_confirmation'.tr,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'logout_message'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.cancel,
                          size: 20, color: Colors.purple),
                      label: Text('batal'.tr),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.purple,
                        side: const BorderSide(color: Colors.purple),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () =>
                          Get.offAllNamed(RouteNames.languageScreen),
                      icon: const Icon(Icons.logout, size: 20),
                      label: Text('logout'.tr, style: TextStyle(fontSize: 16)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
