class MyCourseInstructorEntity {
  MyCourseInstructorEntity({
    required this.id,
    required this.name,
    required this.avatar,
    required this.sub,
  });

  final String id;
  final String name;
  final String avatar;
  final String sub;

  MyCourseInstructorEntity copyWith({
    String? id,
    String? name,
    String? avatar,
    String? sub,
  }) =>
      MyCourseInstructorEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        avatar: avatar ?? this.avatar,
        sub: sub ?? this.sub,
      );
}
