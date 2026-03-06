import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget buildShimmer() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: GestureDetector(
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.grey, width: 0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: Colors.grey,
                          height: 10,
                          width: 60,
                        ),
                        const SizedBox(height: 4),
                        Container(
                          color: Colors.grey,
                          height: 10,
                          width: 100,
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        color: Colors.grey,
                        height: 10,
                        width: 30,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: SizedBox(
                  height: 1,
                  child: Container(
                    color: const Color(0xFFDBDBDB),
                  ),
                ),
              ),
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                        color: Colors.grey,
                        width: 80,
                        height: 80,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            color: Colors.grey,
                            height: 14,
                            width: 150,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Container(
                                color: Colors.grey,
                                height: 10,
                                width: 10,
                              ),
                              const SizedBox(width: 4),
                              Container(
                                color: Colors.grey,
                                height: 10,
                                width: 100,
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Container(
                            color: Colors.grey,
                            height: 12,
                            width: 80,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    ),
  );
}
