import 'dart:developer';

import 'package:NumeriGo/data/network/response_call.dart';
import 'package:NumeriGo/modules/home/widget/WavesBackground.dart';
import 'package:NumeriGo/modules/onboarding/widget/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:headup_loading/headup_loading.dart';

import '../../../config/theme.dart';
import '../../../constants/colors.dart';
import '../../../routes/route_names.dart';
import '../../home/widget/custom_loading_widget.dart';
import '../../home/widget/error_message_display.dart';
import '../../utilities/util.dart';
import '../controllers/AuthController.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _controller = Get.put(AuthController());
  final _loginFormKey = GlobalKey<FormState>();
  late Size _size;
  late TextEditingController _nameController;
  late TextEditingController _classController;
  bool _isClassFilled = false;
  String? _selectedName;

  @override
  void initState() {
    _nameController = TextEditingController();
    _classController = TextEditingController();

    _classController.addListener(() {
      setState(() {
        _isClassFilled = _classController.text.isNotEmpty;
      });
    });
    _fetchPageData();
    super.initState();
  }

  void _fetchPageData() {
    if (_controller.kelasCall.value.status == Status.iddle) {
      _controller.getKelas();
    }
  }

  void _fetchSiswaByIdKelas(String id_kelas) {
    setState(() {
      _selectedName = null;
    });
    _controller.getSiswaByIdKelas(id_kelas);
  }

  @override
  void didChangeDependencies() {
    _size = mediaSize(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _classController.dispose();
    super.dispose();
  }

  Future<bool> _handleLogin(String name, String className) async {
    final id_kelas = _classController.text ?? '';
    final id_siswa = _selectedName ?? '';
    return _controller.login(id_kelas, id_siswa);
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.shortestSide >= 600;
    final padding = isTablet
        ? const EdgeInsets.symmetric(horizontal: 64.0)
        : const EdgeInsets.symmetric(horizontal: 16.0);
    final gapSize = isTablet ? 32.0 : 16.0;

    return Scaffold(
        body: Stack(
      children: [
        const WavesBackground(),
        const AnimatedDecorations(),
        Positioned(
          top: 40, // sedikit turun dari atas
          left: 20, // agak masuk dari kiri
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
            onPressed: () {
              Get.toNamed(RouteNames.onboardingScreen);
            },
          ),
        ),
        SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsets.only(
                top: 32, left: padding.left, right: padding.right),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Gap(_size.width * 0.2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: isTablet ? 300 : 200,
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/logo_sekolah.jpg',
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(_size.width * 0.12),
                SelectionArea(
                  child: Text(
                    'welcome_back'.tr,
                    style: themeData.textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontSize: isTablet ? 32 : 24,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const Gap(8),
                SelectionArea(
                    child: Text(
                  'welcome_desc'.tr,
                  style: appTextTheme.titleSmall.copyWith(color: Colors.white),
                )),
                const Gap(16),
                Column(
                  children: [
                    Obx(() {
                      if (_controller.kelasCall.value.status == Status.iddle) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (_controller.kelasCall.value.status ==
                          Status.loading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (_controller.kelasCall.value.status == Status.error) {
                        return ErrorMessageDisplay(
                          message: _controller.kelasCall.value.message ?? "",
                          onRefresh: _controller.getKelas,
                        );
                      }

                      final data = _controller.kelasCall.value.data?.data ?? [];
                      return Form(
                        key: _loginFormKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            DropdownButtonFormField<String>(
                              value: _classController.text.isNotEmpty
                                  ? _classController.text
                                  : null,
                              onChanged: (value) {
                                _classController.text = value ?? '';
                                if (value != null && value.isNotEmpty) {
                                  _fetchSiswaByIdKelas(value);
                                }
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'class_not_filled'.tr;
                                }
                                return null;
                              },
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 18),
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                hintText: "class".tr,
                                hintStyle: const TextStyle(color: Colors.black),
                              ),
                              items: (data ?? [])
                                  .where((className) => className != null)
                                  .map((className) => DropdownMenuItem(
                                        value: className.id.toString(),
                                        child: Text(
                                            className.namaKelas.toString()),
                                      ))
                                  .toList(),
                            ),
                            Gap(gapSize),
                            DropdownButtonFormField<String>(
                              value: _selectedName,
                              onChanged: (value) {
                                setState(() {
                                  _selectedName = value;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'name_not_filled'.tr;
                                }
                                return null;
                              },
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 18),
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                hintText: "name".tr,
                                hintStyle: TextStyle(color: Colors.black),
                              ),
                              items: (_controller.siswaCall.value.data?.data ??
                                      [])
                                  .where((name) => name != null)
                                  .map((name) => DropdownMenuItem(
                                        value: name.id.toString(),
                                        child: Text(name.fullName.toString()),
                                      ))
                                  .toList(),
                            ),
                            Gap(gapSize),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(top: gapSize),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary90Color,
                      minimumSize: Size(_size.width, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () async {
                      CustomLoading.show(
                          context: context,
                          child: const CustomLoadingWidget(),
                          darken: true);

                      if (_loginFormKey.currentState!.validate()) {
                        _handleLogin(_selectedName ?? '', _classController.text)
                            .then((value) {
                          if (value) {
                            // log("Login Success", name: "LOGIN");
                            Get.offAllNamed(RouteNames.homeScreen);
                          } else {
                            CustomLoading.hide();
                          }
                        });
                      } else {
                        CustomLoading.hide();
                      }
                    },
                    child: Text(
                      'login'.tr.toUpperCase(),
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
                Gap(gapSize),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
