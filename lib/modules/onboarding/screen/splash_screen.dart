import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../constants/duration.dart';
import '../../../routes/route_names.dart';
import '../../authentication/controllers/AuthController.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  final authController = Get.put(AuthController());
  late AnimationController _controller;
  late Animation<double> _animation;

  _setNavigationBarColor() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(systemNavigationBarColor: whiteColor),
    );
  }

  _navigateNext() async {
    await Future.delayed(splashDuration);
    await authController.getProfile();
    final data = authController.user.value;
    try {
      if (data != null) {
        Get.offAllNamed(RouteNames.homeScreen);
        return;
      } else {
        Get.offAllNamed(RouteNames.languageScreen);
        return;
      }
    } catch (e) {
      log(e.toString(), name: 'SPLASH SCREEN');
      Get.offAllNamed(RouteNames.languageScreen);
    }
  }

  @override
  void initState() {
    super.initState();
    _setNavigationBarColor();
    _navigateNext();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 30).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, -_animation.value),
                child: child,
              );
            },
            child: Image.asset(
              'assets/images/logo_sekolah.jpg',
              width: 200,
            ),
          ),
        ),
      ),
    );
  }
}
