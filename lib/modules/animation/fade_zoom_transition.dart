import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FadeZoomTransition extends CustomTransition {
  @override
  Widget buildTransition(
    BuildContext context,
    Curve? curve,
    Alignment? alignment,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final fadeAnim = CurvedAnimation(
      parent: animation,
      curve: curve ?? Curves.easeIn,
    );

    final scaleAnim = CurvedAnimation(
      parent: animation,
      curve: curve ?? Curves.decelerate,
    );

    return FadeTransition(
      opacity: fadeAnim,
      child: ScaleTransition(
        scale: scaleAnim,
        child: child,
      ),
    );
  }
}
