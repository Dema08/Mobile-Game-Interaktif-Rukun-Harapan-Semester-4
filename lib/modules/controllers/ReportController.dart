import 'dart:developer';
import 'package:get/get.dart';

import '../../../data/network/response_call.dart';
import '../../../data/models/ProgressReportModel.dart';
import '../../../data/repositories/ReportRepository.dart';

class ReportController extends GetxController {
  var reportCall = ResponseCall<ProgressReportModel?>.iddle(null).obs;

  Future<void> getReport() async {
    try {
      reportCall.value = ResponseCall.loading('Loading');
      final response = await ReportRepository.getReport();
      reportCall.value = ResponseCall.completed(response);
    } catch (e) {
      reportCall.value = ResponseCall.error(e.toString());
      log(e.toString(), name: 'GET REPORT CONTROLLER');
      rethrow;
    }
  }
}
