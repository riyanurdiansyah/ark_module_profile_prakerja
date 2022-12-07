import 'my_nilai_quiz_entity.dart';

class MyNilaiEntity {
  MyNilaiEntity({
    required this.courseId,
    required this.courseTitle,
    required this.isCompleted,
    required this.studentMark,
    required this.totalMark,
    required this.featuredImage,
    required this.quizes,
  });

  final String courseId;
  final String courseTitle;
  final bool isCompleted;
  final int studentMark;
  final int totalMark;
  final String featuredImage;
  final List<MyNilaiQuizEntity> quizes;

  MyNilaiEntity copyWith({
    String? courseId,
    String? courseTitle,
    bool? isCompleted,
    int? studentMark,
    int? totalMark,
    String? featuredImage,
    List<MyNilaiQuizEntity>? quizes,
  }) =>
      MyNilaiEntity(
        courseId: courseId ?? this.courseId,
        courseTitle: courseTitle ?? this.courseTitle,
        isCompleted: isCompleted ?? this.isCompleted,
        studentMark: studentMark ?? this.studentMark,
        totalMark: totalMark ?? this.totalMark,
        featuredImage: featuredImage ?? this.featuredImage,
        quizes: quizes ?? this.quizes,
      );
}
