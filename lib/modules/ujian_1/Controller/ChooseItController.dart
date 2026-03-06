import 'dart:developer';
import 'package:NumeriGo/data/models/JawabanModel.dart';
import 'package:get/get.dart';
import '../../../data/network/response_call.dart';
import '../../../data/models/ChooseItUjian.dart';
import '../../../data/models/SoalResponse.dart';
import '../../../data/models/JawabanSiswaModel.dart';
import '../../../data/repositories/ChooseItRepository.dart';

class ChooseItController extends GetxController {
  RxInt activePage = 1.obs;
  RxBool isCorrect = false.obs;
  RxString selectedAnswer = ''.obs;
  RxBool isSubmitted = false.obs;

  static const tag = 'ChooseItController';

  Rx<ResponseCall<List<ChooseItUjian>>> chooseItLevel =
      ResponseCall<List<ChooseItUjian>>.iddle('iddle').obs;

  Rx<ResponseCall<SoalResponse>> soalData =
      (const ResponseCall<SoalResponse>.iddle('iddle')).obs;

  Future<void> loadLevel(int kelasId, String tipeujian) async {
    try {
      chooseItLevel.value = ResponseCall.loading('loading Choose It Level');
      final result = await ChooseItRepository.getLevel(kelasId, tipeujian);
      chooseItLevel.value = ResponseCall.completed(result);
    } catch (e) {
      chooseItLevel.value = ResponseCall.error(e.toString());
    }
  }

  Future<void> loadSoal(int idujian) async {
    try {
      soalData.value = ResponseCall.loading('loading Soal Data');
      final result =
          await ChooseItRepository.getSoal(idujian, activePage.value);
      soalData.value = ResponseCall.completed(result);
    } catch (e) {
      soalData.value = ResponseCall.error(e.toString());
    }
  }

  void handleChangePage(int page) {
    activePage.value = page;
  }

  Future<JawabanModel> simpanJawaban(
      int idujian, int question_id, String answer, int waktu_submit) async {
    try {
      final result = await ChooseItRepository.submitJawaban(
          idujian, question_id, answer, waktu_submit);
      return result;
    } catch (e) {
      Get.snackbar('Error', e.toString());
      log(e.toString());
      rethrow;
    }
  }

  void resetUjian() {
    activePage.value = 1;
    soalData.value = ResponseCall<SoalResponse>.iddle('iddle');
  }

  void resetCurrentQuestion() {
    selectedAnswer.value = '';
    isCorrect.value = false;
    isSubmitted.value = false;
  }
}
