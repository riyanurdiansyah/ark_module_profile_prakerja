import 'package:ark_module_profile_prakerja/src/domain/entities/my_course_instructor_entity.dart';

class MyCourseInstructorDTO extends MyCourseInstructorEntity {
  MyCourseInstructorDTO({
    required super.id,
    required super.name,
    required super.avatar,
    required super.sub,
  });

  factory MyCourseInstructorDTO.fromJson(Map<String, dynamic> json) =>
      MyCourseInstructorDTO(
        id: json["id"],
        name: json["name"],
        avatar: json["avatar"],
        sub: json["sub"],
      );
}
