import 'package:ark_module_profile_prakerja/ark_module_profile_prakerja.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArkSettingProfilePagePrakerja extends StatelessWidget {
  ArkSettingProfilePagePrakerja({Key? key}) : super(key: key);

  final _pC = Get.find<ArkProfilePrakerjaController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(244, 245, 247, 1),
      appBar: AppBar(
        iconTheme:
            const IconThemeData(size: 20, color: Color.fromRGBO(62, 63, 67, 1)),
        backgroundColor: Colors.white,
        titleSpacing: 0,
        title: const Text(
          'Pengaturan',
          style: TextStyle(
              color: Color.fromRGBO(28, 29, 32, 1),
              fontWeight: FontWeight.w700,
              fontSize: 15),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            width: Get.size.width,
            height: 100,
            padding: const EdgeInsets.only(top: 20, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Profil',
                  style: TextStyle(
                      color: Color.fromRGBO(62, 63, 67, 1),
                      fontWeight: FontWeight.w800,
                      fontSize: 17),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () => Get.toNamed("/edit-profile-prakerja"),
                  child: Row(
                    children: const [
                      Icon(Icons.people_outline, size: 20),
                      SizedBox(width: 10),
                      Text(
                        'Ubah Profile',
                        style: TextStyle(
                            color: Color.fromRGBO(51, 53, 57, 1),
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 5),
          Container(
            color: Colors.white,
            width: Get.size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: InkWell(
                    onTap: () => _pC.confirmLogout(),
                    child: Row(
                      children: const [
                        Icon(Icons.exit_to_app,
                            size: 20, color: Color.fromRGBO(238, 43, 43, 1)),
                        SizedBox(width: 10),
                        Text(
                          'Keluar',
                          style: TextStyle(
                              color: Color.fromRGBO(238, 43, 43, 1),
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: Get.size.height * 0.3),
          Center(
            child: Text(
              'Versi aplikasi v${_pC.version.value}',
              style: const TextStyle(
                  color: Color.fromRGBO(148, 150, 155, 1),
                  fontSize: 11,
                  fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
    );
  }
}
