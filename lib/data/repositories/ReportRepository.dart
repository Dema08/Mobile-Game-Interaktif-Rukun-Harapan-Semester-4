import 'dart:developer';
import '../models/ProgressReportModel.dart';
import '../network/api_endpoints.dart';
import '../network/network_service.dart';

class ReportRepository {
  static Future<ProgressReportModel?> getReport() async {
    try {
      final response = await NetworkService.get(
        ApiEndpoints.baseUrl,
        ApiEndpoints.getprogresreport,
        isHttps: true,
        withToken: true,
      );

      log('API Response: $response');

      return ProgressReportModel.fromJson(
        (response as Map<String, dynamic>)['data'] as Map<String, dynamic>,
      );
    } catch (e, stackTrace) {
      log('Error in getReport: $e', stackTrace: stackTrace);
      return null;
    }
  }
}
