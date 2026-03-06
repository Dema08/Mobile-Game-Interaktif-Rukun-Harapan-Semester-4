import 'package:get/get.dart';

class Bottomnavbarcontroller extends GetxController {
  RxInt activePage = 0.obs;

  void handleChangePage(int page) {
    activePage.value = page;
  }
}
