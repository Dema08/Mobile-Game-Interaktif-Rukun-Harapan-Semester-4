import 'dart:developer';

import 'package:NumeriGo/data/models/JawabanModel.dart';

import '../models/MagicCardUjian.dart';
import '../models/SoalResponse.dart';
import '../network/api_endpoints.dart';
import '../network/network_service.dart';

class MagicCardRepository {
  static const tag = 'MagicCardRepository';
  static Future<List<MagicCardUjian>> getMagicCardLevel(
      int id_kelas, String tipeujian) async {
    try {
      final response = await NetworkService.post(
        ApiEndpoints.baseUrl,
        ApiEndpoints.getujian,
        headers: {},
        data: {
          "kelas_id": id_kelas.toString(),
          "tipe_ujian": tipeujian,
        },
        isHttps: true,
        withToken: true,
      );
      if (response is List) {
        return response.map((item) => MagicCardUjian.fromJson(item)).toList();
      } else {
        throw Exception('Unexpected response format');
      }
    } catch (e) {
      log(e.toString(), name: tag);
      rethrow;
    }
  }

  static Future<SoalResponse> getSoal(int idujian, int page) async {
    try {
      final response = await NetworkService.get(
        ApiEndpoints.baseUrl,
        ApiEndpoints.getsoalujian,
        headers: {},
        queryParameters: {
          "ujian_id": idujian.toString(),
          "page": page.toString(),
        },
        isHttps: true,
        withToken: true,
      );
      log("$response xx", name: tag);
      return SoalResponse.fromJson(response);
    } catch (e) {
      log(e.toString(), name: tag);
      rethrow;
    }
  }

  static Future<JawabanModel> SubmitJawaban(
      int idujian, int soal_id, dynamic jawaban, int waktusubmit) async {
    try {
      final response = await NetworkService.post(
        ApiEndpoints.baseUrl,
        ApiEndpoints.submitjawaban,
        headers: {},
        data: {
          "ujian_id": idujian.toString(),
          "soal_id": soal_id.toString(),
          "jawaban": jawaban.toString(),
          "waktu_submit": waktusubmit.toString(),
        },
        isHttps: true,
        withToken: true,
      );

      log("$response xx", name: tag);
      return JawabanModel.fromJson(response);
    } catch (e) {
      log(e.toString(), name: tag);
      rethrow;
    }
  }
}
