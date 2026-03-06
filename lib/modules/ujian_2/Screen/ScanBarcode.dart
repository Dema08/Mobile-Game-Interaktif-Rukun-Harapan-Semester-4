import 'package:NumeriGo/constants/colors.dart';
import 'package:NumeriGo/data/models/JawabanModel.dart';
import 'package:NumeriGo/modules/ujian_2/Controller/MagicCardController.dart';
import 'package:NumeriGo/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanBarcode extends StatefulWidget {
  const ScanBarcode({super.key});

  @override
  State<ScanBarcode> createState() => _ScanBarcodeState();
}

class _ScanBarcodeState extends State<ScanBarcode> {
  Barcode? _barcode;
  final idujian = Get.arguments['idujian'] ?? 0;
  int currentQuestionIndex = Get.arguments['currentQuestionIndex'] ?? 0;
  final _controller = Get.put(Magiccardcontroller());
  late MobileScannerController cameraController;

  void goToNextQuestion(dynamic jawaban) async {
    JawabanModel submitjawaban = await _controller.SubmitJawaban(
        idujian, currentQuestionIndex, jawaban, 5);
    if (currentQuestionIndex < (_controller.soalData.value.data?.total ?? 0)) {
      setState(() {
        currentQuestionIndex++;
      });
      _controller.handleChangePage(currentQuestionIndex);

      _controller.loadSoal(idujian);
      Get.toNamed(RouteNames.SoalSelesaiCard, arguments: {
        'idujian': idujian,
        'jumlahpoint': submitjawaban.jumlahPoint
      });
    } else {
      Get.offAllNamed(RouteNames.UjianSelesaiCard);
    }
  }

  @override
  void initState() {
    super.initState();
    cameraController = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      facing: CameraFacing.back,
    );
  }

  void _handleBarcode(BarcodeCapture barcodes) async {
    if (_barcode != null || barcodes.barcodes.isEmpty) return;

    setState(() {
      _barcode = barcodes.barcodes.firstOrNull;
    });

    await cameraController.stop(); // Pause kamera setelah scan
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
      Get.back();
      return false;
    }
    return false;
  }

  void _submitAnswer() {
    if (_barcode == null) return;

    // Kirim jawaban ke controller
    // _controller.submitAnswer(_barcode!.displayValue!, idujian);

    // Pindah soal atau selesaikan ujian
    goToNextQuestion(_barcode!.displayValue!);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text('question'.tr + _controller.activePage.value.toString()),
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
          backgroundColor: primary90Color,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: _onWillPop,
          ),
        ),
        body: Stack(
          children: [
            // Scanner View
            MobileScanner(
              controller: cameraController,
              fit: BoxFit.cover,
              onDetect: _handleBarcode,
            ),

            // Overlay Crop Area (di tengah)
            if (_barcode == null)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: Align(
                  alignment: Alignment.center,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.width * 0.5,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green, width: 4),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.transparent,
                        ),
                      ),
                      Icon(
                        Icons.qr_code_scanner,
                        size: 100,
                        color: Colors.green.withOpacity(0.7),
                      ),
                    ],
                  ),
                ),
              ),
            if (_barcode != null)
              Container(
                color: primary90Color,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'answer_confirm'.tr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(32),
                    Text(
                      '${'answer_submit'.tr}: ${_barcode?.displayValue ?? ''}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    const Gap(40),
                    FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              setState(() {
                                _barcode = null;
                              });
                              cameraController.start(); // Mulai ulang scanner
                            },
                            icon: const Icon(Icons.replay),
                            label: Text('try_scan'.tr),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                            ),
                          ),
                          const SizedBox(width: 16),
                          ElevatedButton.icon(
                            onPressed: _submitAnswer,
                            icon: const Icon(Icons.save),
                            label: Text('save'.tr),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
