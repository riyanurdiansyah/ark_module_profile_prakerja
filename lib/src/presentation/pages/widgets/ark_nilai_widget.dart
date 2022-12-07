import 'package:ark_module_profile_prakerja/ark_module_profile_prakerja.dart';
import 'package:ark_module_profile_prakerja/src/presentation/pages/widgets/ark_nilai_loading_widget.dart';
import 'package:ark_module_profile_prakerja/utils/app_constanta.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArkNilaiWidget extends StatelessWidget {
  ArkNilaiWidget({Key? key}) : super(key: key);

  final _pC = Get.find<ArkProfilePrakerjaController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: RefreshIndicator(
        onRefresh: () async => _pC.fetchMyNilai(),
        child: Obx(() {
          if (_pC.isLoadingNilai.value) {
            return const ArkNilaiLoadingWidget();
          }

          return ListView(
            children: List.generate(
              _pC.myNilais.length,
              (i) => Column(
                children: [
                  ExpandableNotifier(
                    child: ScrollOnExpand(
                      scrollOnExpand: true,
                      scrollOnCollapse: false,
                      child: ExpandablePanel(
                        theme: ExpandableThemeData(
                          headerAlignment:
                              ExpandablePanelHeaderAlignment.center,
                          expandIcon: Icons.expand_more_rounded,
                          collapseIcon: Icons.expand_less_rounded,
                          iconSize: 26,
                          iconColor: Colors.grey.shade500,
                          animationDuration: const Duration(milliseconds: 900),
                        ),
                        collapsed: const SizedBox(),
                        header: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 11),
                          child: Row(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      _pC.myNilais[i].featuredImage,
                                    ),
                                    fit: BoxFit.fill,
                                    onError: (_, __) => Container(
                                      height: 48,
                                      width: 48,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      parseHtmlString(
                                          _pC.myNilais[i].courseTitle),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromRGBO(28, 29, 32, 1),
                                          fontSize: 11.5),
                                    ),
                                    const SizedBox(height: 5),
                                    RichText(
                                      text: TextSpan(
                                        text: 'Progres Pelatihan : ',
                                        style: const TextStyle(
                                            fontSize: 12.5,
                                            fontFamily: 'SourceSansPro',
                                            color: Color.fromRGBO(
                                                131, 133, 137, 1)),
                                        children: [
                                          TextSpan(
                                            text:
                                                '${_pC.myNilais[i].studentMark} / ${_pC.myNilais[i].totalMark}',
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Color.fromRGBO(
                                                    8, 114, 199, 1),
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        expanded: Padding(
                          padding: const EdgeInsets.only(
                              top: 14, left: 14, right: 14),
                          child: ListView.separated(
                            physics: const ScrollPhysics(),
                            shrinkWrap: true,
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemCount: _pC.myNilais[i].quizes.length,
                            itemBuilder: (context, innerIndex) {
                              final quiz = _pC.myNilais[i].quizes[innerIndex];
                              if (quiz.marks == 0) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      parseHtmlString(quiz.title),
                                      style: const TextStyle(
                                          color:
                                              Color.fromRGBO(172, 174, 178, 1),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11),
                                    ),
                                    const SizedBox(height: 5),
                                    const Text(
                                      'Belum terselesaikan',
                                      style: TextStyle(
                                          fontFamily: 'SourceSansPro',
                                          fontSize: 11,
                                          color:
                                              Color.fromRGBO(172, 174, 178, 1)),
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                );
                              }

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    parseHtmlString(quiz.title),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 11),
                                  ),
                                  const SizedBox(height: 5),
                                  RichText(
                                    text: TextSpan(
                                      text: 'Nilai: ',
                                      style: const TextStyle(
                                          fontFamily: 'SourceSansPro',
                                          fontSize: 12,
                                          color:
                                              Color.fromRGBO(131, 133, 137, 1)),
                                      children: [
                                        TextSpan(
                                          text: '${quiz.marks} / ${quiz.max}',
                                          style: const TextStyle(
                                            fontSize: 12.5,
                                            color:
                                                Color.fromRGBO(8, 114, 199, 1),
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 3.5,
                    color: Color.fromRGBO(247, 248, 249, 1),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
