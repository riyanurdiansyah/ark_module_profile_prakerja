import 'package:ark_module_profile_prakerja/ark_module_profile_prakerja.dart';
import 'package:ark_module_profile_prakerja/src/presentation/pages/ark_setting_profile_page.dart';
import 'package:ark_module_profile_prakerja/src/presentation/pages/widgets/ark_aktifitas_widget.dart';
import 'package:ark_module_profile_prakerja/src/presentation/pages/widgets/ark_nilai_widget.dart';
import 'package:ark_module_profile_prakerja/src/presentation/pages/widgets/ark_sertifikat_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArkProfilePrakerjaPage extends StatelessWidget {
  ArkProfilePrakerjaPage({Key? key}) : super(key: key);

  final _pC = Get.find<ArkProfilePrakerjaController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F5),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: Colors.white,
          ),
        ),
        centerTitle: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: [
                Color(0xFF139DD6),
                Color(0xFF0977BE),
              ],
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () => Get.to(() => ArkSettingProfilePage()),
              child: const Icon(
                Icons.settings,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: Container(
          width: Get.width,
          height: Get.height,
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                            _pC.avatar.value,
                          ),
                          fit: BoxFit.cover,
                          onError: (_, __) => Image.asset(
                            'assets/images/fr_default_face.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Obx(
                      () {
                        if (_pC.isLogin.value) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _pC.profile.value.data.fullname,
                                style: TextStyle(
                                  fontSize:
                                      Get.size.shortestSide < 600 ? 17 : 30,
                                  color: const Color.fromRGBO(28, 29, 32, 1),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                _pC.email.value,
                                style: TextStyle(
                                  fontFamily: "SourceSansPro",
                                  fontSize:
                                      Get.size.shortestSide < 600 ? 13 : 18,
                                  color: const Color.fromRGBO(90, 92, 96, 1),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 6),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color:
                                          const Color.fromRGBO(25, 138, 231, 1),
                                    ),
                                    child: Center(
                                      child: Obx(
                                        () => Text(
                                          '${_pC.myCourses.length} kelas diikuti',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 8),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 6),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color:
                                          const Color.fromRGBO(25, 138, 231, 1),
                                    ),
                                    child: Center(
                                      child: Obx(
                                        () => Text(
                                          '${_pC.myCourses.where((e) => e.userStatus == "3" || e.userStatus == "4").toList().length} kelas selesai',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 8),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 36,
              ),
              const Card(
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(),
                elevation: 2,
                child: TabBar(
                  labelColor: Color.fromRGBO(28, 29, 32, 1),
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Montserrat',
                    fontSize: 13,
                  ),
                  labelPadding: EdgeInsets.zero,
                  unselectedLabelColor: Color.fromRGBO(198, 201, 207, 1),
                  indicatorColor: Color.fromRGBO(44, 149, 235, 1),
                  indicatorWeight: 3,
                  unselectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Montserrat',
                    fontSize: 13,
                  ),
                  tabs: [
                    Tab(
                      text: "Sertifikat",
                    ),
                    Tab(
                      text: 'Nilai',
                    ),
                    Tab(
                      text: 'Aktifitas',
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Expanded(
                child: TabBarView(
                  physics: const ScrollPhysics(),
                  children: [
                    ArkSertifikatWidget(),
                    ArkNilaiWidget(),
                    ArkAktifitasWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
