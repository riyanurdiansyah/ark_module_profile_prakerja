import 'dart:developer';
import 'package:ark_module_profile_prakerja/ark_module_profile_prakerja.dart';
import 'package:ark_module_profile_prakerja/src/presentation/pages/ark_hero_image_page.dart';
import 'package:ark_module_profile_prakerja/src/presentation/pages/widgets/ark_empty_widget.dart';
import 'package:ark_module_profile_prakerja/src/presentation/pages/widgets/ark_error_widget.dart';
import 'package:ark_module_profile_prakerja/src/presentation/pages/widgets/ark_generate_sertifikat_page.dart';
import 'package:ark_module_profile_prakerja/src/presentation/pages/widgets/ark_sertifikat_loading_widget.dart';
import 'package:ark_module_profile_prakerja/utils/app_bottomsheet.dart';
import 'package:ark_module_profile_prakerja/utils/app_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../utils/app_constanta.dart';

class ArkSertifikatWidget extends StatelessWidget {
  ArkSertifikatWidget({Key? key}) : super(key: key);

  final _pC = Get.find<ArkProfilePrakerjaController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: RefreshIndicator(
        onRefresh: () async {
          await _pC.fetchMySertifikat();
        },
        child: Obx(() {
          if (_pC.isLoadingSertifikat.value) {
            return const ArkSertifikatLoadingWidget();
          }

          if (_pC.isHaveErrorSertifikat.value) {
            return ArkErrorWidget(onRefresh: () => _pC.fetchMySertifikat());
          }

          if (_pC.mySertifikat.value.certificates.isEmpty) {
            return ArkEmptyWidget(onTap: () {
              log("");
            });
          }
          return ListView(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                elevation: 3,
                margin: const EdgeInsets.only(left: 25, right: 25, top: 20),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.info, color: Colors.yellow[600]),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Informasi Sertifikat Prakerja',
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(62, 63, 67, 1),
                            ),
                          ),
                          const SizedBox(height: 4),
                          GestureDetector(
                            onTap: () =>
                                AppBottomSheet.sheetInformasiPrakerja(context),
                            child: const Text(
                              'lihat lebih detail',
                              style: TextStyle(
                                  fontFamily: 'SourceSansPro',
                                  color: Color.fromRGBO(8, 114, 199, 1),
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ListView.separated(
                separatorBuilder: (BuildContext context, int index) =>
                    const Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Divider(thickness: 1.5),
                ),
                itemCount: _pC.mySertifikat.value.certificates.length,
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, i) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        parseHtmlString(
                            _pC.mySertifikat.value.certificates[i].courseName),
                        style: const TextStyle(
                            color: Color.fromRGBO(28, 29, 32, 1),
                            fontSize: 12,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 5),
                      if (_pC.mySertifikat.value.certificates[i].certDate
                          .isNotEmpty)
                        Text(
                          _pC.mySertifikat.value.certificates[i].certDate,
                          style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(28, 29, 32, 0.8)),
                          textAlign: TextAlign.center,
                        ),
                      Obx(() {
                        if (_pC.listStatusGenerate[i]) {
                          return ArkGenerateSertifikaPage(
                            url: "",
                            onAction: () async {},
                          );

                          // return SizedBox(
                          //   height: 280,
                          //   child: Column(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: const [
                          //       SizedBox(
                          //         width: 28,
                          //         height: 28,
                          //         child: CircularProgressIndicator(
                          //           strokeWidth: 4,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // );
                        }
                        return GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) {
                              return ArkHeroImagePage(
                                url: _pC
                                    .mySertifikat.value.certificates[i].certUrl,
                                tag: "imageHero $i",
                              );
                            }),
                          ),
                          child: SizedBox(
                            width: Get.width,
                            height: 280,
                            child: Hero(
                              tag: "imageHero $i",
                              child: CachedNetworkImage(
                                imageUrl: _pC
                                    .mySertifikat.value.certificates[i].certUrl,
                                errorWidget: (_, __, ___) => Stack(
                                  children: [
                                    Image.asset(
                                      'assets/images/sertif-blur.png',
                                    ),
                                    Center(
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 60),
                                          Image.asset(
                                              'assets/images/logo-no-wifi.png',
                                              height: 55,
                                              width: 55),
                                          const SizedBox(height: 15),
                                          const Text(
                                            'Sertifikat gagal dimuat.\nMohon periksa koneksi internet anda.',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: 'SourceSansPro',
                                              height: 1.6,
                                              color: Color.fromRGBO(
                                                  198, 201, 207, 1),
                                            ),
                                          ),
                                          const SizedBox(height: 15),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: OutlinedButton(
                              onPressed: _pC.mySertifikat.value.certificates[i]
                                          .remainingGen ==
                                      0
                                  ? null
                                  : () =>
                                      AppDialog.dialogPerbaruiSertif(() async {
                                        Get.back();
                                        await _pC.saveGenerateSertifikat(i);
                                      }),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/refresh-icon.svg',
                                    height: 14,
                                    color: _pC.mySertifikat.value
                                                .certificates[i].remainingGen ==
                                            0
                                        ? Colors.grey
                                        : const Color.fromRGBO(44, 149, 235, 1),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    'Perbarui',
                                    style: TextStyle(
                                      color: _pC
                                                  .mySertifikat
                                                  .value
                                                  .certificates[i]
                                                  .remainingGen ==
                                              0
                                          ? Colors.grey
                                          : const Color.fromRGBO(
                                              44, 149, 235, 1),
                                      fontFamily: "montserrat",
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            flex: 1,
                            child: OutlinedButton(
                              onPressed: () async => await _pC.checkPermission(
                                  _pC.mySertifikat.value.certificates[i]
                                      .certUrl),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/download-icon.svg',
                                    height: 14,
                                    color:
                                        const Color.fromRGBO(44, 149, 235, 1),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  const Text(
                                    'Download',
                                    style: TextStyle(
                                      color: Color.fromRGBO(44, 149, 235, 1),
                                      fontFamily: "montserrat",
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
