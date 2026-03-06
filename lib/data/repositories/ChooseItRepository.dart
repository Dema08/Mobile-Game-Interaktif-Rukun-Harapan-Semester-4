import 'dart:developer';

import 'package:NumeriGo/data/models/ChooseItUjian.dart';
import 'package:NumeriGo/data/models/JawabanModel.dart';
import 'package:NumeriGo/data/models/SoalResponse.dart';
import 'package:NumeriGo/data/network/api_endpoints.dart';
import 'package:NumeriGo/data/network/network_service.dart';
import 'package:NumeriGo/data/models/JawabanSiswaModel.dart';

class ChooseItRepository {
  static const tag = 'ChooseItRepository';

  static Future<List<ChooseItUjian>> getLevel(
      int kelasId, String tipeujian) async {
    final response = await NetworkService.post(
      ApiEndpoints.baseUrl,
      ApiEndpoints.getujian,
      data: {
        "kelas_id": kelasId.toString(),
        "tipe_ujian": tipeujian,
      },
      withToken: true,
    );

    if (response is List) {
      return response.map((item) => ChooseItUjian.fromJson(item)).toList();
    } else {
      throw Exception('Format respons tidak valid');
    }
  }

  static Future<SoalResponse> getSoal(int idujian, int page) async {
    final response = await NetworkService.get(
      ApiEndpoints.baseUrl,
      ApiEndpoints.getsoalujian,
      queryParameters: {
        "ujian_id": idujian.toString(),
        "page": page.toString(),
      },
      withToken: true,
    );

    return SoalResponse.fromJson(response);
  }

  static Future<JawabanModel> submitJawaban(
      int idujian, int question_id, String answer, int waktu_submit) async {
    try {
      final response = await NetworkService.post(
        ApiEndpoints.baseUrl,
        ApiEndpoints.submitjawaban,
        data: {
          "ujian_id": idujian.toString(),
          'soal_id': question_id.toString(),
          'jawaban': answer.toString(),
          'waktu_submit': waktu_submit.toString(),
        },
        withToken: true,
        isHttps: true,
      );
      return JawabanModel.fromJson(response);
    } catch (e) {
      log(e.toString(), name: tag);
      rethrow;
    }
  }
}
