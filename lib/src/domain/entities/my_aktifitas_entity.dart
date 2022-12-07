class MyAktifitasEntity {
  MyAktifitasEntity({
    required this.id,
    required this.date,
    required this.content,
  });

  final int id;
  final int date;
  final String content;

  MyAktifitasEntity copyWith({
    int? id,
    int? date,
    String? content,
  }) =>
      MyAktifitasEntity(
        id: id ?? this.id,
        date: date ?? this.date,
        content: content ?? this.content,
      );
}
