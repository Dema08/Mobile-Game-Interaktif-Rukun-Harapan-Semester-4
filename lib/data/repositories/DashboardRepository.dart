// lib/data/repositories/DashboardRepository.dart

import 'dart:developer';
import '../models/DashboardModel.dart';
import '../network/api_endpoints.dart';
import '../network/network_service.dart';

class DashboardRepository {
  static Future<DashboardModel> getDashboard() async {
    try {
      final response = await NetworkService.get(
        ApiEndpoints.baseUrl,
        ApiEndpoints.getdashboard,
        isHttps: true,
        withToken: true,
      );

      if (response is Map<String, dynamic>) {
        return DashboardModel.fromJson(response);
      } else {
        log('Unexpected response format: $response');
        throw Exception('Invalid response format');
      }
    } catch (e, stackTrace) {
      log('Error in DashboardRepository.getDashboard: $e',
          stackTrace: stackTrace);
      rethrow;
    }
  }
}
