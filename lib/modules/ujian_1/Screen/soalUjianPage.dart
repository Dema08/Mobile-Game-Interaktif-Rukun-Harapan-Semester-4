import 'dart:developer';

import 'package:NumeriGo/data/models/JawabanModel.dart';
import 'package:NumeriGo/modules/music/MusicService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:NumeriGo/data/network/response_call.dart';
import 'package:NumeriGo/modules/home/widget/background_home.dart';
import 'package:NumeriGo/constants/colors.dart';
import 'package:NumeriGo/routes/route_names.dart';
import '../Controller/ChooseItController.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';

class SoalUjianPage extends StatefulWidget {
  const SoalUjianPage({super.key});

  @override
  _SoalUjianPageState createState() => _SoalUjianPageState();
}

class _SoalUjianPageState extends State<SoalUjianPage>
    with TickerProviderStateMixin {
  String? selectedAnswer;
  bool hasAnswered = false;
  late ChooseItController _controller;
  bool _isProcessing = false;
  late AnimationController _animationController;
  int idujian = Get.arguments['idujian'] ?? 0;
  late List<Animation<Offset>> _optionAnimations = [];

  @override
  void initState() {
    super.initState();
    MusicService.playSoalMusic();

    if (!Get.isRegistered<ChooseItController>()) {
      Get.put(ChooseItController());
    }
    _controller = Get.find<ChooseItController>();

    if (_controller.activePage.value == 1) {
      _controller.handleChangePage(1);
    } else {
      if (_controller.soalData.value.status == Status.iddle) {
        _controller.loadSoal(idujian);
      }
    }

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _setupAnimations(5);
    _loadSoal();
  }

  Future<void> _loadSoal() async {
    if (_controller.soalData.value.status == Status.iddle) {
      await _controller.loadSoal(idujian);
    }
  }

  void _setupAnimations(int optionCount) {
    _optionAnimations = List.generate(
      optionCount,
      (index) => Tween<Offset>(
        begin: const Offset(1.5, 0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            0.1 * index,
            0.6 + 0.1 * index,
            curve: Curves.easeOut,
          ),
        ),
      ),
    );
    _animationController.forward();
  }

  void handleAnswerSelection(String answer, int questionId) {
    if (!hasAnswered && !_isProcessing) {
      _isProcessing = true;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            selectedAnswer = answer;
            hasAnswered = true;
          });

          _isProcessing = false;
        }
      });
    }
  }

  Future<void> goToNextQuestion() async {
    if (_isProcessing) return;
    _isProcessing = true;

    try {
      JawabanModel? submitjawaban;
      if (selectedAnswer != null && hasAnswered) {
        final question = _controller.soalData.value.data?.data.first;
        if (question != null) {
          submitjawaban = await _controller.simpanJawaban(
              idujian, question.id, selectedAnswer!, 5);
        }
      }

      if (_controller.activePage.value <
          (_controller.soalData.value.data?.total ?? 0)) {
        if (mounted && submitjawaban != null) {
          _controller.activePage.value++;
          _controller.handleChangePage(_controller.activePage.value);
          Get.toNamed(RouteNames.SoalSelesai, arguments: {
            'idujian': idujian,
            'jumlahpoint': submitjawaban.jumlahPoint
          });
        }
      } else {
        Get.toNamed(RouteNames.UjianSelesai);
      }
    } catch (e) {
      debugPrint('Error in goToNextQuestion: $e');
      Get.snackbar('Error', 'Gagal menyimpan jawaban');
    } finally {
      _isProcessing = false;
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
      _controller.resetUjian();
      Get.offAllNamed(RouteNames.MapLevelScreen);
      return false;
    }
    return false;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text('${'question'.tr} ${_controller.activePage.value}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              )),
          backgroundColor: primary90Color,
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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Obx(() {
                  if (_controller.soalData.value.status == Status.iddle ||
                      _controller.soalData.value.status == Status.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (_controller.soalData.value.status == Status.error) {
                    return Center(
                      child:
                          Text('Error: ${_controller.soalData.value.message}'),
                    );
                  }

                  final soalResponse = _controller.soalData.value.data;
                  if (soalResponse == null || soalResponse.data.isEmpty) {
                    return const Center(child: Text("Tidak ada soal tersedia"));
                  }

                  final question = soalResponse.data.first;
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (question.opsi.isNotEmpty &&
                        _optionAnimations.length != question.opsi.length) {
                      _setupAnimations(question.opsi.length);
                    }
                  });

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: LinearProgressBar(
                            maxSteps: soalResponse.total,
                            currentStep: _controller.activePage.value,
                            progressType: LinearProgressBar.progressTypeLinear,
                            progressColor: primary90Color,
                            backgroundColor: Colors.grey.shade300,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(primary70Color),
                            semanticsValue:
                                "${_controller.activePage.value} dari ${soalResponse.total}",
                            minHeight: 12,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            question.gambar ?? '',
                            width: double.infinity,
                            height: 250,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              height: 250,
                              color: Colors.grey[300],
                              child: const Center(
                                child: Icon(Icons.error, color: Colors.red),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '${'question'.tr} ${_controller.activePage.value} ${'from'.tr} ${soalResponse.total}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          question.pertanyaan ?? 'Pertanyaan tidak tersedia',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ...List.generate(
                          question.opsi.length,
                          (index) {
                            if (index >= _optionAnimations.length) {
                              return const SizedBox();
                            }

                            final key = question.opsi.keys.elementAt(index);
                            final jawabanText = question.opsi[key]!;
                            final isCorrectAnswer =
                                key == question.jawabanBenar;
                            final isSelected = key == selectedAnswer;
                            log('Jawaban: $jawabanText, Benar: ${question.jawabanBenar}, key : $key',
                                name: 'SoalUjianPage');
                            log('iscorectanswer: $isCorrectAnswer, isSelected: $isSelected',
                                name: 'SoalUjianPage');

                            Color bgColor = Colors.white;
                            Color textColor = Colors.black;

                            if (hasAnswered) {
                              if (isCorrectAnswer) {
                                bgColor = alertSuccess;
                                textColor = Colors.white;
                              } else if (isSelected) {
                                bgColor = error50Color;
                                textColor = Colors.white;
                              }
                            } else if (isSelected) {
                              bgColor = primary90Color;
                              textColor = Colors.white;
                            }

                            return SlideTransition(
                              position: _optionAnimations[index],
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () =>
                                        handleAnswerSelection(key, question.id),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: bgColor,
                                      foregroundColor: textColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: Text(
                                      "$key. $jawabanText",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        if (hasAnswered)
                          Padding(
                            padding: const EdgeInsets.only(top: 24.0),
                            child: SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: goToNextQuestion,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primary90Color,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: Text(
                                  'next'.tr,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
