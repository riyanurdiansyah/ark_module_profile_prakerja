import 'dart:convert';

import 'package:ark_module_profile_prakerja/src/domain/entities/my_course_entity.dart';
import 'my_course_instructor_dto.dart';

List<MyCourseDTO> myCourseJsonToList(String str) => List<MyCourseDTO>.from(
    json.decode(str).map((x) => MyCourseDTO.fromJson(x)));

class MyCourseDTO extends MyCourseEntity {
  MyCourseDTO({
    required super.id,
    required super.name,
    required super.courseSlug,
    required super.dateCreated,
    required super.userProgress,
    required super.userStatus,
    required super.userExpiry,
    required super.startDate,
    required super.featuredImage,
    required super.instructor,
    required super.sesiKonsultasi,
    required super.menuOrder,
  });

  factory MyCourseDTO.fromJson(Map<String, dynamic> json) => MyCourseDTO(
        id: json["id"],
        name: json["name"],
        courseSlug: json["course_slug"],
        dateCreated: json["date_created"],
        userProgress: json["user_progress"],
        userStatus: json["user_status"],
        userExpiry: json["user_expiry"],
        startDate: json["start_date"],
        featuredImage: json["featured_image"],
        instructor: MyCourseInstructorDTO.fromJson(json["instructor"]),
        sesiKonsultasi: json["sesi_konsultasi"],
        menuOrder: json["menu_order"],
      );
}
