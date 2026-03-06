import 'package:get/get.dart';
import '../../../data/local/local_storage.dart';
import '../../../data/models/Kelas.dart';
import '../../../data/models/ProfileModel.dart';
import '../../../data/models/Siswa.dart';
import '../../../data/network/response_call.dart';

class ProfileController extends GetxController {
  var profileCall = ResponseCall<ProfileModel>.iddle('iddle').obs;
  var userProfile = Rxn<Siswa>();
  var kelasUser = Rxn<Kelas>();

  @override
  void onInit() {
    super.onInit();
    getUserProfile();
    getKelasUser();
  }

  void getUserProfile() async {
    userProfile.value = await LocalStorage.getUser();
  }

  void getKelasUser() async {
    kelasUser.value = await LocalStorage.getKelas();
  }
}
