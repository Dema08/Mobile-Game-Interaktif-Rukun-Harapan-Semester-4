import 'package:NumeriGo/constants/colors.dart';
import 'package:NumeriGo/modules/home/widget/background_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../data/network/response_call.dart';
import 'Controller/PeringkatController.dart';

class PeringkatPage extends StatefulWidget {
  PeringkatPage({super.key});

  @override
  _PeringkatPageState createState() => _PeringkatPageState();
}

class _PeringkatPageState extends State<PeringkatPage> {
  final _controller = Get.put(PeringkatController());

  @override
  void initState() {
    super.initState();
    getPeringkat();
  }

  Future<void> getPeringkat() async {
    await _controller.fetchPeringkat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary90Color,
      appBar: AppBar(
        title: Text(
          'Leaderboard'.tr,
          style: TextStyle(
              color: whiteColor, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        leadingWidth: 0,
        backgroundColor: primary90Color,
        elevation: 0,
        leading: SizedBox(),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [primary90Color, primary70Color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  child: Stack(
                    children: [
                      const BackgroundHome(backgroundColor: primary90Color),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Obx(() {
                          final call = _controller.peringkatCall.value;

                          if (call.status == Status.loading) {
                            return Center(child: CircularProgressIndicator());
                          } else if (call.status == Status.error) {
                            return Center(
                                child:
                                    Text(call.message ?? 'problem_warning'.tr));
                          } else if (call.status == Status.completed) {
                            final data = call.data ?? [];
                            if (data.isEmpty) {
                              return Center(child: Text('empty_ranking'.tr));
                            }

                            return RefreshIndicator(
                              onRefresh: () async {
                                await _controller.fetchPeringkat();
                              },
                              child: ListView.builder(
                                physics: AlwaysScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: data.length + 1, // +1 untuk header
                                itemBuilder: (context, index) {
                                  if (index == 0) {
                                    return _leaderboardRow(
                                      'name'.tr,
                                      'Leaderboard'.tr,
                                      'points'.tr,
                                      isHeader: true,
                                    );
                                  }

                                  final item = data[index - 1];

                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    duration: const Duration(milliseconds: 300),
                                    child: SlideAnimation(
                                      verticalOffset: 50.0,
                                      child: FadeInAnimation(
                                        child: _leaderboardRow(
                                          item.fullName,
                                          index.toString(),
                                          item.totalPoint.toString(),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                          return SizedBox.shrink();
                        }),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }

  /// Baris leaderboard (baik header atau item)
  Widget _leaderboardRow(String name, String rank, String point,
      {bool isHeader = false}) {
    Color getRankColor(String rank) {
      switch (rank) {
        case '1':
          return Colors.amber.shade100;
        case '2':
          return Colors.grey.shade300;
        case '3':
          return Colors.brown.shade200;
        default:
          return Colors.white;
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: isHeader ? primary90Color : getRankColor(rank),
        borderRadius: isHeader
            ? const BorderRadius.vertical(top: Radius.circular(20))
            : BorderRadius.circular(20),
      ),
      margin: isHeader ? null : const EdgeInsets.only(top: 6),
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (!isHeader) Icon(Icons.person, color: Colors.purple.shade900),
              if (!isHeader) const SizedBox(width: 8),
              Text(
                name,
                style: TextStyle(
                  fontSize: isHeader ? 18 : 16,
                  fontWeight: isHeader ? FontWeight.bold : FontWeight.w500,
                  color: isHeader ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: isHeader
                      ? Colors.white
                      : Colors.purple.shade700.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  rank,
                  style: TextStyle(
                    fontSize: isHeader ? 16 : 14,
                    fontWeight: FontWeight.bold,
                    color: isHeader ? Colors.purple : Colors.purple.shade900,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '$point pts',
                style: TextStyle(
                  fontSize: isHeader ? 16 : 14,
                  fontWeight: FontWeight.w600,
                  color: isHeader ? Colors.white : Colors.black87,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
