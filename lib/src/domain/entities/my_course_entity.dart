import 'package:ark_module_profile_prakerja/src/domain/entities/my_course_instructor_entity.dart';

class MyCourseEntity {
  MyCourseEntity({
    required this.id,
    required this.name,
    required this.courseSlug,
    required this.dateCreated,
    required this.userProgress,
    required this.userStatus,
    required this.userExpiry,
    required this.startDate,
    required this.featuredImage,
    required this.instructor,
    required this.sesiKonsultasi,
    required this.menuOrder,
  });

  final int id;
  final String name;
  final String courseSlug;
  final int dateCreated;
  final String userProgress;
  final String userStatus;
  final String userExpiry;
  final bool startDate;
  final String featuredImage;
  final MyCourseInstructorEntity instructor;
  final String sesiKonsultasi;
  final int menuOrder;

  MyCourseEntity copyWith({
    int? id,
    String? name,
    String? courseSlug,
    int? dateCreated,
    String? userProgress,
    String? userStatus,
    String? userExpiry,
    bool? startDate,
    String? featuredImage,
    MyCourseInstructorEntity? instructor,
    String? sesiKonsultasi,
    int? menuOrder,
  }) =>
      MyCourseEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        courseSlug: courseSlug ?? this.courseSlug,
        dateCreated: dateCreated ?? this.dateCreated,
        userProgress: userProgress ?? this.userProgress,
        userStatus: userStatus ?? this.userStatus,
        userExpiry: userExpiry ?? this.userExpiry,
        startDate: startDate ?? this.startDate,
        featuredImage: featuredImage ?? this.featuredImage,
        instructor: instructor ?? this.instructor,
        sesiKonsultasi: sesiKonsultasi ?? this.sesiKonsultasi,
        menuOrder: menuOrder ?? this.menuOrder,
      );
}
