import 'package:NumeriGo/modules/music/MusicService.dart';
import 'dart:developer';
import 'package:NumeriGo/modules/home/widget/background_home.dart';
import 'package:NumeriGo/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:NumeriGo/constants/colors.dart';
import 'package:get/get.dart';
import '../../../data/network/response_call.dart';
import '../Controller/MagicCardController.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';

class SoalUjianPageCard extends StatefulWidget {
  @override
  _SoalUjianPageState createState() => _SoalUjianPageState();
}

class _SoalUjianPageState extends State<SoalUjianPageCard> {
  final idujian = Get.arguments['idujian'] ?? 0;
  final _controller = Get.put(Magiccardcontroller());

  int currentQuestionIndex = 0;

  void goToNextQuestion() {
    Get.toNamed(RouteNames.ScanBarcode, arguments: {
      'idujian': idujian,
      'currentQuestionIndex': currentQuestionIndex,
    });
  }

  @override
  void initState() {
    super.initState();
    MusicService.playSoalMusic();

    currentQuestionIndex = _controller.activePage.value;
    getSoal();
  }

  void getSoal() async {
    if (_controller.soalData.value.status == Status.iddle) {
      await _controller.loadSoal(idujian);
    }
  }

  Future<bool> _onWillPop() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('konfirmation'.tr),
        content: Text('konfirmasi_kembali'.tr),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('batal'.tr),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: primary90Color,
            ),
            child: Text('ya'.tr, style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (result == true) {
      Get.offAllNamed(RouteNames.MapLevelScreenCard);
      return false;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text('question'.tr + currentQuestionIndex.toString()),
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
          backgroundColor: primary90Color,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: _onWillPop,
          ),
        ),
        body: Container(
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
              Obx(() {
                if (_controller.soalData.value.status == Status.iddle) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (_controller.soalData.value.status == Status.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (_controller.soalData.value.status == Status.error) {
                  return Center(
                    child: Text('Error: ${_controller.soalData.value.message}'),
                  );
                }

                final questions = _controller.soalData.value.data?.data ?? [];

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: LinearProgressBar(
                            maxSteps: _controller.soalData.value.data?.total,
                            currentStep: _controller.activePage.value,
                            progressType: LinearProgressBar.progressTypeLinear,
                            progressColor: primary90Color,
                            backgroundColor: Colors.grey.shade300,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(primary70Color),
                            semanticsValue:
                                "${_controller.activePage.value + 1} dari ${_controller.soalData.value.data?.total ?? 1}",
                            minHeight: 12,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      // Gambar soal
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          questions.first.gambar ?? '',
                          width: double.infinity,
                          height: 250,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 250,
                              color: Colors.grey[300],
                              child: const Center(
                                child: Icon(
                                  Icons.error,
                                  color: Colors.red,
                                  size: 50,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        "${'question'.tr} ${currentQuestionIndex} ${'from'.tr} ${_controller.soalData.value.data?.total}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        questions.first.pertanyaan,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 32.0),

                      // Tombol Jawab
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: goToNextQuestion,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primary90Color,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32.0,
                              vertical: 12.0,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          child: Text(
                            'jawab'.tr,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
