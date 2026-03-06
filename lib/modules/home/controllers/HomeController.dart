import 'dart:developer';
import 'package:get/get.dart';

import '../../../data/models/DashboardModel.dart';
import '../../../data/models/Siswa.dart';
import '../../../data/models/Kelas.dart';
import '../../../data/local/local_storage.dart';
import '../../../data/network/response_call.dart';
import '../../../data/repositories/DashboardRepository.dart';

class HomeController extends GetxController {
  var dashboardCall = ResponseCall<DashboardModel>.iddle('idle').obs;
  var userProfile = Rxn<Siswa>();
  var kelasUser = Rxn<Kelas>();

  @override
  void onInit() {
    super.onInit();
    getUserProfile();
    getKelasUser();
    fetchDashboard();
  }

  void getUserProfile() async {
    userProfile.value = await LocalStorage.getUser();
  }

  void getKelasUser() async {
    kelasUser.value = await LocalStorage.getKelas();
  }

  void fetchDashboard() async {
    try {
      dashboardCall.value = ResponseCall.loading('Loading');
      final result = await DashboardRepository.getDashboard();
      dashboardCall.value = ResponseCall.completed(result);
    } catch (e) {
      dashboardCall.value = ResponseCall.error('Gagal memuat dashboard');
      log('Error fetchDashboard: $e');
    }
  }
}
