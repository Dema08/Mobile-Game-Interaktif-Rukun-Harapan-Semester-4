import 'package:flutter/material.dart';

class BackgroundHome extends StatelessWidget {
  final Color backgroundColor;

  const BackgroundHome({
    super.key,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 80,
          left: -30,
          child: CircleAvatar(
            radius: 60,
            backgroundColor: backgroundColor.withOpacity(0.05),
          ),
        ),
        Positioned(
          bottom: 100,
          right: -20,
          child: CircleAvatar(
            radius: 40,
            backgroundColor: backgroundColor.withOpacity(0.05),
          ),
        ),
        Positioned(
          bottom: 200,
          left: 50,
          child: CircleAvatar(
            radius: 25,
            backgroundColor: backgroundColor.withOpacity(0.08),
          ),
        ),
        Positioned(
          top: 30,
          left: 20,
          child: Icon(
            Icons.school,
            size: 100,
            color: backgroundColor.withOpacity(0.15),
          ),
        ),
        Positioned(
          bottom: 30,
          right: 20,
          child: Icon(
            Icons.menu_book,
            size: 90,
            color: backgroundColor.withOpacity(0.15),
          ),
        ),
      ],
    );
  }
}
