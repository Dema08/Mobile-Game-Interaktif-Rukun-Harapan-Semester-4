import 'dart:developer';

import 'package:NumeriGo/data/models/SiswaResponse.dart';

import '../network/api_endpoints.dart';
import '../network/network_service.dart';

class siswaRepository {
  static const tag = 'SiswaRepository';
  static Future<SiswaResponse> getSiswaByIdKelas(String id_kelas) async {
    final response = await NetworkService.post(
      ApiEndpoints.baseUrl,
      ApiEndpoints.getsiswabykelasid,
      data: {"id_kelas": id_kelas},
      headers: {},
      isHttps: true,
      withToken: false,
    );
    final res = SiswaResponse.fromJson(response as Map<String, dynamic>);
    return res;
  }
}
