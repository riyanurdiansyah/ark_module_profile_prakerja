import 'package:ark_module_profile_prakerja/src/domain/entities/my_nilai_quiz_entity.dart';

class MyNilaiQuizDTO extends MyNilaiQuizEntity {
  MyNilaiQuizDTO({
    required super.quiz,
    required super.title,
    required super.marks,
    required super.max,
  });

  factory MyNilaiQuizDTO.fromJson(Map<String, dynamic> json) => MyNilaiQuizDTO(
        quiz: json["quiz"] ?? "",
        title: json["title"] ?? "",
        marks: json["marks"] ?? 0,
        max: json["max"] ?? 0,
      );
}
