import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/theme.dart';
import 'small_primary_button.dart';

class ErrorMessageDisplay extends StatelessWidget {
  const ErrorMessageDisplay({
    super.key,
    required this.message,
    required this.onRefresh,
  });

  final String message;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: appTextTheme.bodyLarge,
          ),
          const SizedBox(height: 8),
          SmallPrimaryButton(
            text: "refresh".tr,
            onPressed: onRefresh,
          )
        ],
      ),
    );
  }
}
