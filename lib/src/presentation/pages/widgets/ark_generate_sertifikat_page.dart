import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class ArkGenerateSertifikaPage extends StatelessWidget {
  const ArkGenerateSertifikaPage(
      {Key? key, required this.url, required this.onAction})
      : super(key: key);

  final String url;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    String js =
        "document.querySelector('meta[name=\"viewport\"]').setAttribute('content', 'width=1209px, initial-scale=' + (document.documentElement.clientWidth / 1209))";
    return InAppWebView(
      initialOptions: InAppWebViewGroupOptions(
          android: AndroidInAppWebViewOptions(
              clearSessionCache: true,
              cacheMode: AndroidCacheMode.LOAD_NO_CACHE)),
      initialUrlRequest: URLRequest(
        url: Uri.parse(url),
        headers: {
          'Cache-Control': 'nocache',
          'Access-Control-Allow-Origin': '*'
        },
      ),
      onProgressChanged: (controller, prog) {
        controller.clearCache();
        controller.evaluateJavascript(source: js);
        PaintingBinding.instance.imageCache.clear();
      },
      onLoadError: (_, __, ___, ____) {
        Get.defaultDialog(title: 'error');
      },
      onLoadStop: (_, __) async {
        Future.delayed(const Duration(seconds: 5), () async {
          () async => onAction();
        });
      },
    );
  }
}
