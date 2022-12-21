import 'package:ark_module_profile_prakerja/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'app_constanta.dart';

class AppDialog {
  static dialogStateWithLottie(
    String lottiFile,
    String txt,
  ) {
    return Get.defaultDialog(
      radius: 8,
      middleText: '',
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: Column(
        children: [
          const SizedBox(height: 25),
          Lottie.asset('assets/images/$lottiFile',
              height: 100, width: 100, repeat: false),
          const SizedBox(height: 35),
          Text(
            txt,
            style: const TextStyle(
              fontSize: 16,
              height: 1.4,
              color: kNewBlack1,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  static dialogLoading() {
    return Get.defaultDialog(
      barrierDismissible: false,
      onWillPop: () async => false,
      radius: 8,
      middleText: '',
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: Column(
        children: [
          const SizedBox(height: 25),
          Lottie.asset('assets/images/loading-animation.json',
              height: 100, width: 100),
          const SizedBox(height: 35),
          const Text(
            'Harap Tunggu',
            style: TextStyle(
              fontSize: 16.5,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  static dialogDownloadSertif() {
    return Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 60, vertical: 24),
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8)),
              child: Image.asset(
                'assets/images/popup-kelas-sudahselesai.png',
                fit: BoxFit.fill,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 22, horizontal: 15),
              child: Material(
                color: Colors.white,
                child: Text(
                  'Anda telah berhasil mendownload\nSertifikat belajar.',
                  style: TextStyle(
                    height: 1.4,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(28, 29, 32, 1),
                    fontSize: 13.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 40,
              width: 90,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    primary: const Color.fromRGBO(8, 114, 199, 1),
                  ),
                  child: const Text(
                    'Oke',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Get.back();
                  }),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  static dialogPerbaruiSertif(Future Function() ontap) {
    return Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 50, vertical: 44),
        contentPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.zero,
        title: SizedBox(
          width: 570,
          height: 342,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 570,
                  height: 170,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromRGBO(19, 171, 229, 1),
                  ),
                  child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      child: Image.asset(
                          'assets/images/popup-perbaruii-cert.png',
                          fit: BoxFit.cover)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        height: 1.7,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(28, 29, 32, 1),
                        fontSize: 12,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Perbarui sertifikat hanya dapat digunakan '),
                        TextSpan(
                            text: '7 (kali) kali ',
                            style: TextStyle(fontWeight: FontWeight.w800)),
                        TextSpan(text: 'pada setiap sertifikat.')
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Padding(
                  padding:
                      EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 10),
                  child: Text(
                    'Apakah Anda yakin untuk Perbarui sertifikat?',
                    style: TextStyle(
                      height: 1.7,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(28, 29, 32, 1),
                      fontSize: 11,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: Get.size.height * 0.06,
                      width: Get.size.width * 0.3,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          primary: const Color.fromRGBO(220, 221, 225, 1),
                        ),
                        child: const Text(
                          'YA',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Color.fromRGBO(28, 29, 32, 1),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () async => await ontap(),
                      ),
                    ),
                    const SizedBox(width: 15),
                    SizedBox(
                      height: Get.size.height * 0.06,
                      width: Get.size.width * 0.3,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          primary: const Color.fromRGBO(8, 114, 199, 1),
                        ),
                        child: const Text(
                          'TIDAK',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ),
                  ],
                ),
                // const SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static dialogWithQuestion(
    String title,
    String content,
    String txtBatal,
    String txtOke,
    VoidCallback onTapOK,
  ) {
    return Get.defaultDialog(
      titlePadding: const EdgeInsets.only(top: 15, bottom: 10),
      title: title,
      titleStyle: TextStyle(
        fontSize: 16,
        color: Colors.red.shade600,
        fontWeight: FontWeight.bold,
      ),
      middleText: content,
      middleTextStyle: TextStyle(
        fontSize: 14,
        color: Colors.grey.shade400,
      ),
      cancel: Padding(
        padding: const EdgeInsets.only(right: 5),
        child: TextButton(
          onPressed: () => Get.back(),
          child: Text(
            txtBatal,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ),
      ),
      confirm: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: TextButton(
          onPressed: () => onTapOK(),
          child: Text(
            txtOke,
            style: const TextStyle(
              fontSize: 14,
              color: Color.fromRGBO(8, 114, 199, 1),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
