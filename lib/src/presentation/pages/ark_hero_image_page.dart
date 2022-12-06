import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class ArkHeroImagePage extends StatelessWidget {
  const ArkHeroImagePage({Key? key, required this.url, required this.tag})
      : super(key: key);

  final String url;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        body: Center(
          child: Hero(
            tag: tag,
            child: PinchZoom(
              child: Image.network(
                url,
                errorBuilder: (_, __, ___) {
                  return Image.asset('assets/images/sertif-blur.png');
                },
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        Get.back();
      },
    );
  }
}
