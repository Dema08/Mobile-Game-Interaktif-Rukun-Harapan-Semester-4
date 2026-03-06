import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class AnimatedDecorations extends StatefulWidget {
  const AnimatedDecorations({super.key});

  @override
  State<AnimatedDecorations> createState() => _AnimatedDecorationsState();
}

class _AnimatedDecorationsState extends State<AnimatedDecorations>
    with TickerProviderStateMixin {
  late AnimationController _floatingController;
  late Animation<double> _floatingAnimation;

  @override
  void initState() {
    super.initState();

    _floatingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _floatingAnimation =
        Tween<double>(begin: 0, end: 15).animate(CurvedAnimation(
      parent: _floatingController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _floatingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _floatingAnimation,
      builder: (context, child) {
        return Stack(
          children: [
            Positioned(
              bottom: 170 + _floatingAnimation.value,
              right: -10,
              child: Opacity(
                opacity: 0.7,
                child: Image.asset(
                  'assets/images/decors/book.png',
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Positioned(
              top: -70 - _floatingAnimation.value,
              left: -90,
              child: Opacity(
                opacity: 0.7,
                child: Image.asset(
                  'assets/images/decors/edubook.png',
                  height: 230,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Positioned(
              bottom: 50 + _floatingAnimation.value / 2,
              left: 30,
              child: Opacity(
                opacity: 0.5,
                child: Image.asset(
                  'assets/images/decors/coin_left.png',
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Positioned(
              top: 70 - _floatingAnimation.value / 2,
              right: -50,
              child: Opacity(
                opacity: 0.9,
                child: Image.asset(
                  'assets/images/decors/coin_right.png',
                  height: 150,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
