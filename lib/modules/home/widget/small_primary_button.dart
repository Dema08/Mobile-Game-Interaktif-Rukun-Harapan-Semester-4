import 'package:flutter/material.dart';

import '../../../config/theme.dart';
import '../../../constants/colors.dart';

class SmallPrimaryButton extends StatelessWidget {
  final String text;
  final double width;
  final VoidCallback onPressed;

  const SmallPrimaryButton({
    super.key,
    this.width = 144,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(width, 30),
        backgroundColor: accent50Color,
      ),
      child: Text(
        text,
        style: appTextTheme.bodyMedium.copyWith(
          color: whiteColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
