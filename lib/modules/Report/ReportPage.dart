import 'package:NumeriGo/constants/colors.dart';
import 'package:NumeriGo/modules/home/widget/background_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/network/response_call.dart';
import '../controllers/ReportController.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> with TickerProviderStateMixin {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late AnimationController _fadeUpController;
  late Animation<double> _fadeUpAnimation;

  final ReportController controller = Get.put(ReportController());

  @override
  void initState() {
    super.initState();

    controller.getReport();

    _fadeUpController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeUpAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeUpController, curve: Curves.easeIn),
    );

    _fadeUpController.forward();
  }

  @override
  void dispose() {
    _fadeUpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary90Color,
      appBar: AppBar(
        title: Text('progress_report'.tr,
            style: TextStyle(
                color: whiteColor, fontSize: 24, fontWeight: FontWeight.bold)),
        centerTitle: false,
        leadingWidth: 0,
        backgroundColor: Color(0xFF7551E9),
        elevation: 0,
        leading: SizedBox(),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Stack(
          children: [
            const BackgroundHome(backgroundColor: primary90Color),
            Obx(() {
              final status = controller.reportCall.value.status;
              final model = controller.reportCall.value.data;

              if (status == Status.loading) {
                return Center(child: CircularProgressIndicator());
              }

              if (status == Status.error) {
                return Center(
                    child: Text(controller.reportCall.value.message ??
                        'cant_load_data'.tr));
              }

              if (status == Status.completed && model != null) {
                final List<Map<String, dynamic>> reportData = [
                  {
                    'icon': Icons.play_circle_fill,
                    'title': 'quiz_played'.tr,
                    'value': model.totalQuizzesPlayed.toString(),
                    'color': Colors.blueAccent
                  },
                  {
                    'icon': Icons.emoji_events,
                    'title': 'quiz_won'.tr,
                    'value': model.quizzesWon.toString(),
                    'color': Colors.orangeAccent
                  },
                  {
                    'icon': Icons.star,
                    'title': 'total_point'.tr,
                    'value': model.totalPoints.toString(),
                    'color': Colors.purpleAccent
                  },
                  {
                    'icon': Icons.lightbulb,
                    'title': 'top_category'.tr,
                    'value': model.topCategory ?? "-",
                    'color': Colors.green
                  },
                  {
                    'icon': Icons.calendar_today,
                    'title': 'active_days_this_month'.tr,
                    'value': model.activeDaysThisMonth.toString(),
                    'color': Colors.teal
                  },
                ];

                return RefreshIndicator(
                  onRefresh: () async {
                    await controller.getReport();
                    _fadeUpController.reset();
                    _fadeUpController.forward();
                  },
                  child: ListView.builder(
                    padding: EdgeInsets.all(16),
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: reportData.length,
                    itemBuilder: (context, index) {
                      final item = reportData[index];
                      final animation = Tween<Offset>(
                        begin: Offset(1, 0),
                        end: Offset(0, 0),
                      ).animate(
                        CurvedAnimation(
                          parent: _fadeUpController,
                          curve: Interval(
                            (index / reportData.length),
                            1.0,
                            curve: Curves.easeInOut,
                          ),
                        ),
                      );
                      return SlideTransition(
                        position: animation,
                        child: FadeTransition(
                          opacity: _fadeUpAnimation,
                          child: _buildReportCard(
                            icon: item['icon'],
                            title: item['title'],
                            value: item['value'],
                            color: item['color'],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }

              return Center(child: Text("Tidak ada data"));
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildReportCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    // Jika value panjang, potong menjadi 2 kalimat (maks 2 kalimat, sisanya diabaikan)
    String displayValue = value;
    if (value.contains('.') || value.contains('!') || value.contains('?')) {
      // Pisahkan berdasarkan tanda akhir kalimat
      final sentences = value.split(RegExp(r'(?<=[.!?])\s+'));
      if (sentences.length > 2) {
        displayValue = sentences.take(2).join(' ');
      }
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          CircleAvatar(
              backgroundColor: color, child: Icon(icon, color: Colors.white)),
          SizedBox(width: 20),
          Expanded(
              child: Text(title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))),
          Flexible(
            child: Text(
              displayValue,
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: color),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExportButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        minimumSize: Size(double.infinity, 50),
      ),
      icon: Icon(icon, color: Colors.white),
      label: Text(label, style: TextStyle(fontSize: 16, color: Colors.white)),
      onPressed: onPressed,
    );
  }
}
