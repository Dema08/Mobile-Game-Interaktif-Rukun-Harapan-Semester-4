import 'dart:math';
import 'package:flutter/material.dart';

class WavesBackground extends StatefulWidget {
  const WavesBackground({super.key});

  @override
  State<WavesBackground> createState() => _WavesBackgroundState();
}

class _WavesBackgroundState extends State<WavesBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true); // Ulangi bolak-balik
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Fungsi untuk menggeser tiap wave secara sinusoidal
  double _waveOffset(int index) {
    return sin(_controller.value * 2 * pi + (index * pi / 3)) * 20;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          children: [
            for (int i = 1; i <= 7; i++)
              Positioned.fill(
                child: Transform(
                  transform: Matrix4.identity()
                    ..translate(
                        0.0, _waveOffset(i)) // Offset untuk pergerakan wave
                    ..scale(1.1, 1.1,
                        1), // Zoom in sedikit untuk memastikan wave tidak terpotong
                  alignment: Alignment.center,
                  child: ClipRect(
                    child: OverflowBox(
                      maxHeight: double
                          .infinity, // Pastikan wave bisa melewati batas atas
                      maxWidth: double
                          .infinity, // Pastikan wave bisa melewati batas kanan/kiri
                      child: Image.asset(
                        'assets/images/waves/wave$i.png',
                        fit: BoxFit.none, // Jangan ubah ukuran gambar
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
