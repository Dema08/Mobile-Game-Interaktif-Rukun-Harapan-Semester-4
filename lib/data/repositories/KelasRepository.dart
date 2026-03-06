import 'dart:developer';

import '../models/KelasResponse.dart';
import '../network/api_endpoints.dart';
import '../network/network_service.dart';

class kelasRepository {
  static const tag = 'KelasRepository';
  static Future<KelasResponse> getKelas() async {
    try {
      final response = await NetworkService.get(
        ApiEndpoints.baseUrl,
        ApiEndpoints.getkelas,
        headers: {},
        isHttps: true,
        withToken: false,
      );
      log("$response xx", name: tag);
      final kelasResponse =
          KelasResponse.fromJson(response as Map<String, dynamic>);
      return kelasResponse;
    } catch (e) {
      log(e.toString(), name: tag);
      rethrow;
    }
  }
}
