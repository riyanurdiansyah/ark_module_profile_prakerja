class MyNilaiQuizEntity {
  MyNilaiQuizEntity({
    required this.quiz,
    required this.title,
    required this.marks,
    required this.max,
  });

  final String quiz;
  final String title;
  final int marks;
  final int max;

  MyNilaiQuizEntity copyWith({
    String? quiz,
    String? title,
    int? marks,
    int? max,
  }) =>
      MyNilaiQuizEntity(
        quiz: quiz ?? this.quiz,
        title: title ?? this.title,
        marks: marks ?? this.marks,
        max: max ?? this.max,
      );
}
