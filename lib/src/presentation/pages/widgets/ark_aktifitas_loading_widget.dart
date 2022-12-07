import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timelines/timelines.dart';

class ArkAktifitasLoadinWidget extends StatelessWidget {
  const ArkAktifitasLoadinWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Timeline.tileBuilder(
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
          itemCount: 8,
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
                  color: Colors.grey[200]!,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 5, right: 18, top: 10),
                height: 60,
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.grey[200]!,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
