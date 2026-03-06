import 'dart:developer';
import '../models/PeringkatModel.dart';
import '../network/api_endpoints.dart';
import '../network/network_service.dart';

class PeringkatRepository {
  static Future<List<PeringkatModel>> getPeringkat() async {
    try {
      final response = await NetworkService.get(
        ApiEndpoints.baseUrl,
        ApiEndpoints.getperingkat,
        isHttps: true,
        withToken: true,
      );

      if (response is List) {
        return response.map((e) => PeringkatModel.fromJson(e)).toList();
      } else {
        log('Unexpected response format: $response');
        return [];
      }
    } catch (e, stackTrace) {
      log('Error in PeringkatRepository.getPeringkat: $e',
          stackTrace: stackTrace);
      return [];
    }
  }
}
