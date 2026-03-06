import 'dart:developer';

import 'package:NumeriGo/data/models/Siswa.dart';

import '../network/api_endpoints.dart';
import '../network/network_service.dart';

class AuthRepository {
  static Future login(String kelas_id, String siswa_id) async {
    try {
      final response = await NetworkService.post(
        ApiEndpoints.baseUrl,
        ApiEndpoints.login,
        data: {"kelas_id": kelas_id, "siswa_id": siswa_id},
        headers: {},
        isHttps: true,
        withToken: false,
      );
      if (response != null) {
        return response;
      }
    } catch (e) {
      log(e.toString(), name: 'AUTH REPOSITORY');
      rethrow;
    }
  }

  static Future<Siswa> getProfile() async {
    try {
      var response = await NetworkService.get(
        ApiEndpoints.baseUrl,
        ApiEndpoints.getProfile,
        headers: {},
        isHttps: true,
        withToken: true,
      );
      log(response.toString(), name: 'AUTH GET PROFILE');
      final result = Siswa.fromJson(response['profile']);

      return result;
    } catch (e) {
      log(e.toString(), name: 'AUTH GET PROFILE');
      rethrow;
    }
  }
}
