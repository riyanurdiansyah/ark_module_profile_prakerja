import 'dart:convert';

import 'package:ark_module_profile_prakerja/src/data/dto/my_nilai_quiz_dto.dart';
import 'package:ark_module_profile_prakerja/src/domain/entities/my_nilai_entity.dart';

List<MyNilaiDTO> myNilaiFromJsonToList(String str) =>
    List<MyNilaiDTO>.from(json.decode(str).map((x) => MyNilaiDTO.fromJson(x)));

class MyNilaiDTO extends MyNilaiEntity {
  MyNilaiDTO({
    required super.courseId,
    required super.courseTitle,
    required super.isCompleted,
    required super.studentMark,
    required super.totalMark,
    required super.featuredImage,
    required super.quizes,
  });
  factory MyNilaiDTO.fromJson(Map<String, dynamic> json) => MyNilaiDTO(
        courseId: json["course_id"] ?? "",
        courseTitle: json["course_title"] ?? "",
        isCompleted: json["is_completed"] ?? false,
        studentMark: json["student_mark"] ?? 0,
        totalMark: json["total_mark"] ?? 0,
        featuredImage: json["featured_image"] ?? "",
        quizes: List<MyNilaiQuizDTO>.from(
            json["quizes"].map((x) => MyNilaiQuizDTO.fromJson(x))),
      );
}
