import 'dart:developer';
import 'package:get/get.dart';

import '../../../data/models/PeringkatModel.dart';
import '../../../data/network/response_call.dart';
import '../../../data/repositories/PeringkatRepository.dart';

class PeringkatController extends GetxController {
  // Ganti 'iddle' jadi 'idle'
  var peringkatCall = ResponseCall<List<PeringkatModel>>.iddle('idle').obs;

  var currentUserPoint = ''.obs;
  var currentUserRank = ''.obs;

  Future<List<PeringkatModel>> fetchPeringkat() async {
    try {
      peringkatCall.value = ResponseCall.loading('Loading');
      final result = await PeringkatRepository.getPeringkat();
      peringkatCall.value = ResponseCall.completed(result);
      return result;
    } catch (e) {
      peringkatCall.value = ResponseCall.error('Gagal memuat peringkat');
      log('Error fetchPeringkat: $e');
      rethrow;
    }
  }
}
