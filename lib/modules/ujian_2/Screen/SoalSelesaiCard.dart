import 'package:NumeriGo/constants/colors.dart';
import 'package:NumeriGo/modules/home/widget/background_home.dart';
import 'package:NumeriGo/modules/music/MusicService.dart';
import 'package:NumeriGo/modules/ujian_2/Controller/MagicCardController.dart';
import 'package:NumeriGo/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SoalSelesaiCard extends StatefulWidget {
  @override
  _SoalSelesaiCardState createState() => _SoalSelesaiCardState();
}

class _SoalSelesaiCardState extends State<SoalSelesaiCard> {
  final idujian = Get.arguments['idujian'];
  final jumlahpoint = Get.arguments['jumlahpoint'] ?? 0;
  final _controller = Get.put(Magiccardcontroller());

  Future<bool> _onWillPop() async {
    Get.snackbar(
      'warning'.tr,
      'warning_message'.tr,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
    return false;
  }

  @override
  void initState() {
    super.initState();
    MusicService.stopSfxOnly();
    MusicService.playRingtoneOnce();
  }

  Future<void> _showEndExamConfirmation() async {
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
    }
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primary90Color,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: _showEndExamConfirmation,
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
                child: Align(
                  alignment: Alignment(0.0, -0.3),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'kerja_bagus'.tr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.thumb_up_sharp,
                            size: 60,
                            color: primary90Color,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 40,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 60,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.white,
                            size: 40,
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        '${'get_points'.tr} ${jumlahpoint} ${'points'.tr}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Get.toNamed(RouteNames.SoalUjianPageCard,
                                arguments: {
                                  'idujian': Get.arguments['idujian'],
                                });
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
                            'next'.tr,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: ElevatedButton(
                          onPressed: () {
                            _controller.activePage.value =
                                _controller.activePage.value - 1;
                            Get.toNamed(RouteNames.SoalUjianPageCard,
                                arguments: {
                                  'idujian': idujian,
                                });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primary30Color,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            minimumSize: Size(double.infinity, 50),
                          ),
                          child: Text(
                            'retry'.tr,
                            style:
                                TextStyle(fontSize: 20, color: primary90Color),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
