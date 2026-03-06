import 'package:NumeriGo/data/network/response_call.dart';
import 'package:NumeriGo/modules/music/MusicService.dart';
import 'package:NumeriGo/modules/ujian_1/Controller/ChooseItController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:NumeriGo/constants/colors.dart';
import 'package:NumeriGo/modules/home/widget/background_home.dart';
import 'package:NumeriGo/data/local/local_storage.dart';
import 'package:NumeriGo/routes/route_names.dart';

class MapLevelScreen extends StatefulWidget {
  const MapLevelScreen({super.key});

  @override
  State<MapLevelScreen> createState() => _MapLevelScreenState();
}

class _MapLevelScreenState extends State<MapLevelScreen>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _animations;

  final _controller = Get.put(ChooseItController());

  @override
  void initState() {
    super.initState();
    MusicService.stopAll();
    Get.put(ChooseItController());
    fetchData();

    _controllers = List.generate(
      5,
      (i) => AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 500 + (i * 100)),
      )..forward(),
    );

    _animations = _controllers
        .map((controller) => CurvedAnimation(
              parent: controller,
              curve: Curves.elasticOut,
            ))
        .toList();
  }

  void fetchData() async {
    final datauser = await LocalStorage.getUser();
    if (_controller.chooseItLevel.value.status == Status.iddle) {
      _controller.loadLevel(datauser?.kelasId ?? 0, 'choose_it');
    }
  }

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      extendBodyBehindAppBar: true,
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
              if (_controller.chooseItLevel.value.status == Status.iddle ||
                  _controller.chooseItLevel.value.status == Status.loading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (_controller.chooseItLevel.value.status == Status.error) {
                // return ErrorMessageDisplay(
                //   message: _controller.chooseItLevel.value.message ?? "Error",
                //   onRefresh: fetchData,
                // );
              }

              final data = _controller.chooseItLevel.value.data ?? [];

              return Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      data.length,
                      (index) => ScaleTransition(
                        scale: _animations[index],
                        child: _buildLevel(index, context, data[index].id,
                            data[index].status_pengerjaan),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          Get.toNamed(RouteNames.homeScreen);
        },
      ),
      centerTitle: true,
      title: Text(
        'choose_it'.tr,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      // actions: [
      //   IconButton(
      //     icon: const Icon(Icons.more_vert, color: Colors.white),
      //     onPressed: () {},
      //   ),
      // ],
    );
  }

  Widget _buildLevel(
      int index, BuildContext context, int idujian, bool status_pengerjaan) {
    final isUnlocked = status_pengerjaan;

    final isLeft = index % 2 == 0;
    final boxSize = 80.0;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (index != 0)
            Positioned(
              top: -60,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 800),
                height: 60,
                width: 4,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          Row(
            mainAxisAlignment:
                isLeft ? MainAxisAlignment.start : MainAxisAlignment.end,
            children: [
              const SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  if (isUnlocked) {
                    if (Get.isRegistered<ChooseItController>()) {
                      Get.delete<ChooseItController>();
                    }

                    final newController = Get.put(ChooseItController());
                    newController.handleChangePage(1);

                    Get.toNamed(RouteNames.SoalUjianPage, arguments: {
                      'idujian': idujian,
                    });
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    left: isLeft ? 60 : 0,
                    right: isLeft ? 0 : 60,
                  ),
                  width: boxSize,
                  height: boxSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isUnlocked ? Colors.orangeAccent : Colors.white24,
                    border: Border.all(color: Colors.white54, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        offset: const Offset(0, 4),
                        blurRadius: 8,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                  child: Center(
                    child: isUnlocked
                        ? Text(
                            "${index + 1}",
                            style: const TextStyle(
                              fontSize: 28,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : const Icon(Icons.lock, color: Colors.white, size: 26),
                  ),
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
        ],
      ),
    );
  }
}
