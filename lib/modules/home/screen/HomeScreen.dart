import 'package:NumeriGo/modules/Profile/ProfilePage.dart';
import 'package:NumeriGo/modules/Report/ReportPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/colors.dart';
import '../../../constants/duration.dart';
import '../../../routes/route_names.dart';
import '../../Games/PeringkatPage.dart';
import '../Page/HomePage.dart';
import '../controllers/bottomnavbarController.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _bottomNavController = Get.put(Bottomnavbarcontroller());

  // _setSystemBarColor() {
  //   SystemChrome.setSystemUIOverlayStyle(
  //     const SystemUiOverlayStyle(
  //       systemNavigationBarColor: whiteColor,
  //       statusBarColor: Colors.transparent,
  //       statusBarBrightness: Brightness.light,
  //       statusBarIconBrightness: Brightness.light,
  //     ),
  //   );
  // }

  @override
  void initState() {
    // * Inject all required controller for each page

    // _setSystemBarColor();

    super.initState();
  }

  Future<bool> _onWillPop() async {
    final shouldExit = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        title: Text('konfirmation'.tr),
        content: Text('confirmation_message'.tr),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'no'.tr,
              style: const TextStyle(color: primary90Color),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              'yes'.tr,
              style: const TextStyle(color: primary90Color),
            ),
          ),
        ],
      ),
    );
    return shouldExit ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => _onWillPop(),
        child: Scaffold(
          backgroundColor: neutral10Color,
          body: SafeArea(
            child: Obx(
              () {
                Widget activePageWidget = const HomePage();

                if (_bottomNavController.activePage.value == 1) {
                  activePageWidget = PeringkatPage();
                }

                if (_bottomNavController.activePage.value == 2) {
                  activePageWidget = ReportPage();
                }

                if (_bottomNavController.activePage.value == 3) {
                  activePageWidget = ProfilePage();
                }
                return AnimatedSwitcher(
                  duration: fastDuration,
                  child: activePageWidget,
                );
              },
            ),
          ),
          bottomNavigationBar: Obx(() {
            return BottomNavigationBar(
              currentIndex: _bottomNavController.activePage.value,
              iconSize: 24,
              selectedFontSize: 14,
              unselectedFontSize: 14,
              onTap: (index) {
                _bottomNavController.handleChangePage(index);
              },
              items: [
                BottomNavigationBarItem(
                  label: 'Home'.tr,
                  tooltip: 'Home'.tr,
                  icon: const Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Icon(Icons.home_outlined),
                  ),
                  activeIcon: const Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Icon(
                      Icons.home,
                      color: primary90Color,
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'Leaderboard'.tr,
                  tooltip: 'Leaderboard'.tr,
                  icon: const Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Icon(Icons.show_chart_outlined),
                  ),
                  activeIcon: const Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Icon(
                      Icons.show_chart,
                      color: primary90Color,
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'Report'.tr,
                  tooltip: 'Report'.tr,
                  icon: const Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Icon(Icons.bar_chart_outlined),
                  ),
                  activeIcon: const Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Icon(
                      Icons.bar_chart,
                      color: primary90Color,
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'Profile'.tr,
                  tooltip: 'Profile'.tr,
                  icon: const Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Icon(Icons.person_outline),
                  ),
                  activeIcon: const Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Icon(
                      Icons.person,
                      color: primary90Color,
                    ),
                  ),
                ),
              ],
            );
          }),
        ));
  }
}
