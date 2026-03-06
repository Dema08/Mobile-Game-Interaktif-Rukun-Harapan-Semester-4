import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/colors.dart';
import '../../../config/theme.dart';
import '../../utilities/get_first_letter.dart';

class AccountInfoSection extends StatelessWidget {
  final String? name;
  final String? imageUrl;
  final VoidCallback onProfileImageTap;

  const AccountInfoSection({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.onProfileImageTap,
  });

  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'selamat_pagi'.tr;
    } else if (hour < 15) {
      return 'selamat_siang'.tr;
    } else if (hour < 18) {
      return 'selamat_sore'.tr;
    } else {
      return 'selamat_malam'.tr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: whiteColor,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(46),
            child: Container(
                height: 46,
                width: 46,
                decoration: BoxDecoration(
                    color: name != null ? accent30Color : neutral30Color),
                child: GestureDetector(
                  onTap: onProfileImageTap,
                  child: Builder(builder: (context) {
                    if (imageUrl != null) {
                      return CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.transparent,
                        backgroundImage: imageUrl != null
                            ? (File(imageUrl!).existsSync()
                                ? FileImage(File(imageUrl!))
                                    as ImageProvider<Object>?
                                : NetworkImage(imageUrl!)
                                    as ImageProvider<Object>?)
                            : null,
                        child: imageUrl == null
                            ? Text(
                                getFirstLetter(name!),
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400,
                                  color: accent90Color,
                                ),
                              )
                            : null,
                      );
                    }

                    if (name != null) {
                      return Center(
                        child: Text(
                          getFirstLetter(name!),
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      );
                    }

                    return const Center(
                      child: Icon(
                        Icons.person,
                        size: 24,
                        color: neutral70Color,
                      ),
                    );
                  }),
                )),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  getGreeting(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: appTextTheme.titleMedium.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: base50Color),
                ),
                Text(
                  name!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: appTextTheme.titleMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
