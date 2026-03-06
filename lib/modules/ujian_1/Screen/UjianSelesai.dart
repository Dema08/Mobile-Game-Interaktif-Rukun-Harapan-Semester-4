import 'package:NumeriGo/modules/music/MusicService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:NumeriGo/constants/colors.dart';
import 'package:NumeriGo/modules/home/widget/background_home.dart';
import 'package:NumeriGo/routes/route_names.dart';
import '../Controller/ChooseItController.dart';

class UjianSelesai extends StatefulWidget {
  @override
  State<UjianSelesai> createState() => _UjianSelesaiState();
}

class _UjianSelesaiState extends State<UjianSelesai> {
  @override
  @override
  void initState() {
    super.initState();
    MusicService.stopAll();
    MusicService.playSelesaiMusic();
  }

  Widget build(BuildContext context) {
    final _controller = Get.find<ChooseItController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary90Color,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            _controller.resetUjian();
            Get.offAllNamed(RouteNames.MapLevelScreen);
          },
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [primary90Color, primary70Color],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            const BackgroundHome(backgroundColor: Colors.white),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'exam_completed'.tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 0),
                  Lottie.asset(
                    'assets/animation/success.json',
                    width: 400,
                    height: 400,
                  ),
                  SizedBox(height: 0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: ElevatedButton(
                      onPressed: () {
                        _controller.resetUjian();
                        Get.offAllNamed(RouteNames.MapLevelScreen);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary90Color,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        minimumSize: Size(double.infinity, 50),
                      ),
                      child: Text(
                        'back_to_map'.tr,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
