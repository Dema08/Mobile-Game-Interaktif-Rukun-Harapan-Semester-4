import 'dart:developer';
import 'package:get/get.dart';
import '../../../data/models/JawabanModel.dart';
import '../../../data/models/MagicCardUjian.dart';
import '../../../data/models/SoalResponse.dart';
import '../../../data/network/response_call.dart';
import '../../../data/repositories/MagicCardRepository.dart';

class Magiccardcontroller extends GetxController {
  RxInt activePage = 1.obs;

  static const tag = 'Magiccardcontroller';
  Rx<ResponseCall<List<MagicCardUjian>>> MagicCardlevel =
      ResponseCall<List<MagicCardUjian>>.iddle('iddle').obs;
  Rx<ResponseCall<SoalResponse>> soalData =
      ResponseCall<SoalResponse>.iddle('iddle').obs;

  Future<List<MagicCardUjian>> loadMagicCardlevel(
      int id_kelas, String tipeujian) async {
    try {
      MagicCardlevel.value = ResponseCall.loading('loading Magic Card Data');
      final response =
          await MagicCardRepository.getMagicCardLevel(id_kelas, tipeujian);

      MagicCardlevel.value = ResponseCall.completed(response);
      return response;
    } catch (e) {
      MagicCardlevel.value = ResponseCall.error(e.toString());
      log(e.toString(), name: tag);
      rethrow;
    }
  }

  Future<SoalResponse> loadSoal(int idujian) async {
    try {
      soalData.value = ResponseCall.loading('loading Soal Data');
      final response =
          await MagicCardRepository.getSoal(idujian, activePage.value);
      soalData.value = ResponseCall.completed(response);
      return response;
    } catch (e) {
      soalData.value = ResponseCall.error(e.toString());
      log(e.toString(), name: tag);
      rethrow;
    }
  }

  Future<JawabanModel> SubmitJawaban(
      int idujian, int soal_id, dynamic jawaban, int waktusubmit) async {
    try {
      final response = await MagicCardRepository.SubmitJawaban(
          idujian, soal_id, jawaban, waktusubmit);
      return response;
    } catch (e) {
      log(e.toString(), name: tag);
      rethrow;
    }
  }

  void handleChangePage(int page) {
    activePage.value = page;
  }
}
