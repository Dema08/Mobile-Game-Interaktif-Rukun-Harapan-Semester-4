import 'package:NumeriGo/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget buildStatItem(String title, String value, IconData icon) {
  return Card(
    color: primary90Color,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 30),
          const SizedBox(height: 8),
          Text(title,
              style: const TextStyle(fontSize: 14, color: Colors.white)),
          Text(value,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        ],
      ),
    ),
  );
}
