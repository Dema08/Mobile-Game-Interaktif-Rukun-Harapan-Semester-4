import 'dart:developer';

import 'package:NumeriGo/constants/colors.dart';
import 'package:NumeriGo/data/models/DashboardModel.dart';
import 'package:NumeriGo/data/network/response_call.dart';
import 'package:NumeriGo/modules/home/controllers/HomeController.dart';
import 'package:NumeriGo/modules/home/widget/quiz_card_widget.dart';
import 'package:NumeriGo/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../../../data/models/DashboardModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _controller;
  final HomeController dashboardController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    dashboardController.fetchDashboard();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: primary90Color, statusBarBrightness: Brightness.light));

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [primary90Color, primary70Color],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          RefreshIndicator(
            onRefresh: _onRefresh,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      padding: const EdgeInsets.all(16),
                      child: _buildHeader().animate().slideY(duration: 400.ms),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          _buildStatsCard()
                              .animate()
                              .fade(duration: 500.ms)
                              .scale(duration: 400.ms),
                          const SizedBox(height: 20),
                          _buildDailyQuote()
                              .animate()
                              .fade(duration: 500.ms)
                              .slideX(begin: -1, duration: 500.ms),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(30)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              _buildQuizSection()
                                  .animate()
                                  .fade(duration: 500.ms)
                                  .slideY(begin: 0.2, end: 0, duration: 600.ms),
                              const SizedBox(height: 20),
                              _buildTipsSection()
                                  .animate()
                                  .fade(duration: 600.ms)
                                  .slideX(
                                      begin: -0.2, end: 0, duration: 600.ms),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Obx(() {
      final user = dashboardController.userProfile.value;
      final name = user?.fullName?.trim().isNotEmpty == true
          ? user!.fullName!
          : " pengguna".tr;
      final kelas =
          user?.namaKelas?.isNotEmpty == true ? user!.namaKelas! : "-";

      return Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white.withOpacity(0.9),
            child: const Icon(Icons.person, color: primary90Color),
          ).animate().scale(duration: 400.ms),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "welcome".tr + name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                kelas,
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
            ],
          ),
        ],
      );
    });
  }

  Widget buildStatItem(String label, String value, IconData icon) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 8),
        decoration: BoxDecoration(
          color: primary90Color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 6,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28, color: Colors.white),
            const SizedBox(width: 16),
            Column(
              children: [
                Text(label,
                    style: const TextStyle(fontSize: 14, color: Colors.white)),
                Text(value,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ],
            )
          ],
        ),
      ).animate().fadeIn(delay: 300.ms).shimmer(duration: 500.ms),
    );
  }

  Widget _buildStatsCard() {
    return Obx(() {
      final state = dashboardController.dashboardCall.value;

      if (state.status == Status.loading) {
        return const Center(child: CircularProgressIndicator());
      }

      if (state.status == Status.error) {
        return const Center(child: Text("Gagal memuat data"));
      }

      final DashboardModel? user = state.data;

      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "your_statistics".tr,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: primary90Color,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: buildStatItem("total_point".tr,
                      user?.point.toString() ?? "0", Icons.star),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: buildStatItem(
                      "ranking".tr, user?.ranking ?? "-", Icons.leaderboard),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _buildDailyQuote() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.orange.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        "quotes".tr,
        style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
      ).animate().slideX(begin: -1, duration: 500.ms),
    );
  }

  Widget quizCard(String title, IconData icon, String tipeujian) {
    return QuizCardWidget(
      title: title,
      icon: icon,
      onPressed: () {
        log("Quiz Card Pressed: $title");
        if (tipeujian == "choose_it") {
          log("choose it");
          Get.toNamed(RouteNames.MapLevelScreen);
        } else {
          log("magic card");
          Get.toNamed(RouteNames.MapLevelScreenCard);
        }
      },
    );
  }

  Widget _buildQuizSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("quiz_for_you".tr,
            style: const TextStyle(
                fontSize: 18,
                color: primary90Color,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child:
                  quizCard("choose_it".tr, Icons.theater_comedy, "choose_it"),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: quizCard("magic_card".tr, Icons.style, "magic_card"),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildTipsSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.lightBlue.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "tips_for_today".tr,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            "tips_1".tr,
            style: const TextStyle(fontSize: 14),
          ).animate().slideX(begin: -0.2),
          Text(
            "tips_2".tr,
            style: const TextStyle(fontSize: 14),
          ).animate(delay: 200.ms).slideX(begin: -0.2),
        ],
      ),
    );
  }
}
