import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ZoomInTransition extends CustomTransition {
  @override
  Widget buildTransition(
    BuildContext context,
    Curve? curve,
    Alignment? alignment,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: animation,
        curve: curve ?? Curves.easeInOut,
      ),
      child: child,
    );
  }
}
