import 'package:ark_module_profile_prakerja/ark_module_profile_prakerja.dart';
import 'package:ark_module_profile_prakerja/src/presentation/pages/widgets/ark_aktifitas_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:timelines/timelines.dart';

import '../../../../utils/app_constanta.dart';
import 'ark_error_widget.dart';

class ArkAktifitasWidget extends StatelessWidget {
  ArkAktifitasWidget({Key? key}) : super(key: key);

  final _pC = Get.find<ArkProfilePrakerjaController>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => _pC.fetchMyAktifitas(),
      child: Obx(
        () {
          if (_pC.isLoadingAktifitas.value) {
            return const ArkAktifitasLoadinWidget();
          }

          if (_pC.isHaveErrorSertifikat.value) {
            return ArkErrorWidget(onRefresh: () => _pC.fetchMyAktifitas());
          }

          return Timeline.tileBuilder(
            theme: TimelineThemeData(
                nodePosition: 0.06,
                indicatorPosition: 0.2,
                indicatorTheme: const IndicatorThemeData(
                    size: 10, color: Color.fromRGBO(9, 114, 199, 1)),
                connectorTheme: ConnectorThemeData(
                    thickness: 0.5, color: Colors.grey.withOpacity(0.5))),
            padding: EdgeInsets.zero,
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            builder: TimelineTileBuilder.connectedFromStyle(
              itemCount: _pC.myAktifitas.length,
              contentsAlign: ContentsAlign.basic,
              connectorStyleBuilder: (context, index) {
                return ConnectorStyle.solidLine;
              },
              lastConnectorStyle: ConnectorStyle.transparent,
              indicatorStyleBuilder: (context, index) => IndicatorStyle.dot,
              contentsBuilder: (context, i) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: const EdgeInsets.only(top: 13, left: 10),
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      width: 85,
                      height: 21,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color.fromRGBO(222, 240, 255, 1)),
                      child: Center(
                        child: Text(
                          readTimestamp(_pC.myAktifitas[i].date),
                          style: const TextStyle(
                              color: Color.fromRGBO(9, 114, 199, 1),
                              fontSize: 10,
                              fontWeight: FontWeight.w500),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 10),
                    child: Html(
                      style: {
                        "html": Style.fromTextStyle(
                          const TextStyle(
                            fontFamily: 'SourceSansPro',
                            fontSize: 12.5,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      },
                      data: _pC.myAktifitas[i].content,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
