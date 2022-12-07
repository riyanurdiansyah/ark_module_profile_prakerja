import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ArkNilaiLoadingWidget extends StatelessWidget {
  const ArkNilaiLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: List.generate(
          8,
          (index) => Container(
            margin: const EdgeInsets.only(top: 8),
            height: 80,
            color: Colors.grey[200]!,
          ),
        ),
      ),
    );
  }
}
