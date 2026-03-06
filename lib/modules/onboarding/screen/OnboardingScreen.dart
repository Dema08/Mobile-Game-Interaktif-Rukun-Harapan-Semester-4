import 'dart:ui';
import 'package:NumeriGo/constants/colors.dart';
import 'package:NumeriGo/modules/home/widget/WavesBackground.dart';
import 'package:NumeriGo/modules/onboarding/widget/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:NumeriGo/routes/route_names.dart';
import 'package:lottie/lottie.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle(
          statusBarColor: Color(0x806A5AE0).withOpacity(0.1),
          statusBarIconBrightness: Brightness.light,
        ),
        child: Stack(
          children: [
            const WavesBackground(),
            const AnimatedDecorations(),
            //decorasi gambar hiasan

            Positioned(
              top: 40, // sedikit turun dari atas
              left: 20, // agak masuk dari kiri
              child: IconButton(
                icon:
                    const Icon(Icons.arrow_back, color: Colors.white, size: 30),
                onPressed: () {
                  Get.toNamed(RouteNames
                      .languageScreen); // ini untuk kembali ke halaman sebelumnya
                },
              ),
            ),
            Positioned(
              top: 350,
              right: 0,
              left: 0,
              child: Center(
                child: Lottie.asset(
                  'assets/animation/hand_animation.json',
                  width: 275,
                  height: 275,
                  repeat: true,
                  reverse: false,
                  animate: true,
                ),
              ),
            ),

            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image.asset(
                      'assets/images/logo_sekolah.jpg',
                      height: 160,
                    ),
                  ),
                  // const SizedBox(height: 24),
                  Container(
                    margin: EdgeInsets.only(top: 40, bottom: 10),
                    child: const Text(
                      'NumeriGo',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    'app_desc'.tr,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 350),
                  ElevatedButton(
                    onPressed: () => Get.toNamed(RouteNames.loginscreen),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary90Color,
                      minimumSize: const Size(350, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      'get_started'.tr.toUpperCase(),
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w800),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
