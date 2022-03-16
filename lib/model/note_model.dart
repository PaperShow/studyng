final String tableNotes = 'notes';

class NoteFields {
  static final List<String> values = <String>[
    id,
    title,
    number,
    description,
    time,
    isImportant
  ];

  static final String id = '_id';
  static final String isImportant = 'isImportant';
  static final String number = 'number';
  static final String title = 'title';
  static final String description = 'description';
  static final String time = 'time';
}

class Note {
  final int? id;
  final isImportant; //bool
  final int? number;
  final title;
  final String? description;
  final createdTime;

  const Note({
    this.id,
    this.isImportant,
    this.number,
    this.title,
    this.description,
    this.createdTime,
  });

  Map<String, dynamic> toJson() {
    return {
      NoteFields.id: id,
      NoteFields.isImportant: isImportant ? 1 : 0,
      NoteFields.number: number,
      NoteFields.title: title,
      NoteFields.description: description,
      NoteFields.time: createdTime!.toIso8601String(),
    };
  }

  static Note fromJson(Map<String, dynamic> json) {
    return Note(
      id: json[NoteFields.id] as int?,
      isImportant: json[NoteFields.isImportant] == 1,
      number: json[NoteFields.number] as int,
      title: json[NoteFields.title] as String,
      description: json[NoteFields.description] as String,
      createdTime: DateTime.parse(json[NoteFields.time] as String),
    );
  }

  Note copy({
    int? id,
    bool? isImportant,
    int? number,
    String? title,
    String? description,
    DateTime? createdTime,
  }) =>
      Note(
        id: id ?? this.id,
        isImportant: isImportant ?? this.isImportant,
        number: number ?? this.number,
        title: title ?? this.title,
        description: description ?? this.description,
        createdTime: createdTime ?? this.createdTime,
      );
}
