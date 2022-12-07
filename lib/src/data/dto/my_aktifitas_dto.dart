import 'dart:convert';

import 'package:ark_module_profile_prakerja/src/domain/entities/my_aktifitas_entity.dart';

List<MyAktifitasDTO> myAktifitasFromJsonToList(String str) =>
    List<MyAktifitasDTO>.from(
        json.decode(str).map((x) => MyAktifitasDTO.fromJson(x)));

class MyAktifitasDTO extends MyAktifitasEntity {
  MyAktifitasDTO({
    required super.id,
    required super.date,
    required super.content,
  });

  factory MyAktifitasDTO.fromJson(Map<String, dynamic> json) => MyAktifitasDTO(
        id: json["ID"] ?? 0,
        date: json["date"] ?? 0,
        content: json["content"] ?? "",
      );
}
