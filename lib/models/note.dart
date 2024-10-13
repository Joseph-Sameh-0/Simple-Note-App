class Note {
  final int? id;
  final String title;
  final String description;
  final DateTime dateCreated;

  Note({
    this.id,
    required this.title,
    required this.description,
    required this.dateCreated,
  });

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      dateCreated: DateTime.parse(map['dateCreated']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateCreated': dateCreated.toIso8601String(),
    };
  }
}
