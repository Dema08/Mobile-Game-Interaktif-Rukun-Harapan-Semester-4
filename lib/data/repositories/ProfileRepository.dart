import 'dart:developer';
import '../models/ProfileModel.dart';
import '../network/api_endpoints.dart';
import '../network/network_service.dart';

class ProfileRepository {
  static Future<ProfileModel> getProfile() async {
    try {
      final response = await NetworkService.get(
        ApiEndpoints.baseUrl,
        ApiEndpoints.getProfile,
        isHttps: true,
        withToken: true,
      );

      if (response is Map<String, dynamic>) {
        return ProfileModel.fromJson(response);
      } else {
        log('Unexpected response format: $response');
        throw Exception('Invalid response format');
      }
    } catch (e, stackTrace) {
      log('Error in ProfileRepository.getProfile: $e', stackTrace: stackTrace);
      rethrow;
    }
  }
}
