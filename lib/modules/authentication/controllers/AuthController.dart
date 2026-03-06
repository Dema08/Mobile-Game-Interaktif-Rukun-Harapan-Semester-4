import 'dart:developer';

import 'package:NumeriGo/data/models/Siswa.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/local/local_storage.dart';
import '../../../data/models/KelasResponse.dart';
import '../../../data/models/SiswaResponse.dart';
import '../../../data/network/response_call.dart';
import '../../../data/repositories/AuthRepository.dart';
import '../../../data/repositories/KelasRepository.dart';
import '../../../data/repositories/SiswaRepository.dart';

class AuthController extends GetxController {
  Rx<Siswa?> user = null.obs;
  var kelasCall = ResponseCall<KelasResponse>.iddle('iddle').obs;
  var siswaCall = ResponseCall<SiswaResponse>.iddle('iddle').obs;

  Future<KelasResponse> getKelas() async {
    try {
      kelasCall.value = ResponseCall.loading('Loading');
      final response = await kelasRepository.getKelas();
      kelasCall.value = ResponseCall.completed(response);
      return response;
    } catch (e) {
      kelasCall.value = ResponseCall.error(e.toString());
      rethrow;
    }
  }

  Future<SiswaResponse> getSiswaByIdKelas(String id_kelas) async {
    try {
      siswaCall.value = ResponseCall.loading('Loading');
      final response = await siswaRepository.getSiswaByIdKelas(id_kelas);
      siswaCall.value = ResponseCall.completed(response);
      return response;
    } catch (e) {
      siswaCall.value = ResponseCall.error(e.toString());
      log(e.toString(), name: 'GET SISWA BY ID KELAS CONTROLLER');
      rethrow;
    }
  }

  Future<bool> login(String kelas_id, String siswa_id) async {
    try {
      final response = await AuthRepository.login(kelas_id, siswa_id);
      if (response != null) {
        await LocalStorage.saveSession(response['token']);
        final dataUser = await getProfile();
        await LocalStorage.saveUser(dataUser);
        if (dataUser.id != null) {
          return true;
        }
        return false;
      }
      return false;
    } catch (e) {
      log(e.toString(), name: 'LOGIN CONTROLLER');
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return false;
    }
  }

  Future<Siswa> getProfile() async {
    try {
      Siswa response = await AuthRepository.getProfile();
      user = response.obs;
      return response;
    } catch (e) {
      user.value = null;
      log(e.toString(), name: 'GET PROFILE CONTROLLER');
      return Siswa(
          id: 0,
          username: '',
          fullName: '',
          nis: '',
          namaKelas: '',
          ranking: '-',
          harimasuk: 0);
    }
  }
}
