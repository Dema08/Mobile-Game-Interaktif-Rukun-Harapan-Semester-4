import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BounceSlideTransition extends CustomTransition {
  @override
  Widget buildTransition(
    BuildContext context,
    Curve? curve,
    Alignment? alignment,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final offsetAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animation,
      curve: curve ?? Curves.elasticOut,
    ));

    return SlideTransition(
      position: offsetAnimation,
      child: child,
    );
  }
}
