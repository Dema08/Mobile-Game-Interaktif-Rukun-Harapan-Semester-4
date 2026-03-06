import 'dart:developer';

import 'package:NumeriGo/constants/colors.dart';
import 'package:NumeriGo/data/local/local_storage.dart';
import 'package:NumeriGo/data/network/response_call.dart';
import 'package:NumeriGo/modules/home/widget/background_home.dart';
import 'package:NumeriGo/modules/music/MusicService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/route_names.dart';
import '../../home/widget/error_message_display.dart';
import '../Controller/MagicCardController.dart';

class MapLevelScreenCard extends StatefulWidget {
  const MapLevelScreenCard({super.key});

  @override
  State<MapLevelScreenCard> createState() => _MapLevelScreenCardState();
}

class _MapLevelScreenCardState extends State<MapLevelScreenCard> {
  final _controller = Get.put(Magiccardcontroller());

  @override
  void initState() {
    super.initState();
    MusicService.stopAll();

    fetchData();
  }

  void fetchData() async {
    final datauser = await LocalStorage.getUser();
    if (_controller.MagicCardlevel.value.status == Status.iddle) {
      _controller.loadMagicCardlevel(datauser?.kelasId ?? 0, 'magic_card');
    }
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
              if (_controller.MagicCardlevel.value.status == Status.iddle) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (_controller.MagicCardlevel.value.status == Status.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (_controller.MagicCardlevel.value.status == Status.error) {
                // return ErrorMessageDisplay(
                //   message: _controller.MagicCardlevel.value.message ?? "",
                //   onRefresh: fetchData,
                // );
              }

              final data = _controller.MagicCardlevel.value.data ?? [];

              return Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      data.length,
                      (index) => _buildLevel(index, context, data[index].id,
                          data[index].status_pengerjaan),
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
        'magic_card'.tr,
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
      margin: EdgeInsets.only(top: 20, bottom: 20),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (index != 0)
            Positioned(
              top: -60,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 800),
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
                    _controller.activePage.value = 1;
                    Get.toNamed(RouteNames.SoalUjianPageCard, arguments: {
                      'idujian': idujian,
                    });
                  }
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
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
                        offset: Offset(0, 4),
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
