import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'app_constanta.dart';

class AppBottomSheet {
  static sheetInformasiPrakerja(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) => SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, bottom: 10, top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.info,
                    color: Colors.yellow[600],
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Informasi Sertifikat Prakerja',
                    style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w800,
                        color: Color.fromRGBO(62, 63, 67, 1)),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(FontAwesomeIcons.xmark,
                        color: Color.fromRGBO(62, 63, 67, 1), size: 20),
                  ),
                ],
              ),
            ),
            const Divider(),
            const SizedBox(height: 6),
            for (int i = 0; i < prakerjaInfo.length; i++)
              Container(
                margin: const EdgeInsets.only(bottom: 10, left: 18, right: 24),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${i + 1}.',
                      style: const TextStyle(
                          color: Color.fromRGBO(90, 92, 96, 1),
                          fontFamily: 'SourceSansPro'),
                    ),
                    const SizedBox(width: 7),
                    Expanded(
                        child: Text(
                      prakerjaInfo[i],
                      style: const TextStyle(
                          color: Color.fromRGBO(90, 92, 96, 1),
                          fontFamily: 'SourceSansPro'),
                    ))
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
