import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SlideUpTransition extends CustomTransition {
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
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animation,
      curve: curve ?? Curves.easeOutBack,
    ));

    return SlideTransition(
      position: offsetAnimation,
      child: child,
    );
  }
}
