import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:studyng/model/note_model.dart';

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();

  Database? _database;

  NotesDatabase._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    // creating table      --->create as many tables as you want by adding more 'createTable' statements
    await db.execute('''
      CREATE TABLE $tableNotes(
        ${NoteFields.id} $idType,
        ${NoteFields.isImportant} $boolType,
        ${NoteFields.number} $integerType,
        ${NoteFields.title} $textType,
        ${NoteFields.description} $textType,
        ${NoteFields.time} $integerType
      )
    ''');
  }

  Future<Note> create(Note note) async {
    final db = await instance.database;

    // this below line to get id of note that is created similar to that id which is used
    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title},${NoteFields.description},${NoteFields.time}';
    // final values =
    //     '\'${json[NoteFields.title]}\',\'${json[NoteFields.description]}\',${json[NoteFields.time]}';

    // final id =
    //     await db.rawInsert('INSERT INTO table_name ($columns) VALUE ($values)');

    final id = await db.insert(tableNotes, note.toJson());
    return note.copy(id: id);
  }

  Future<Note> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableNotes,
      columns: NoteFields.values,
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );
    return maps.isNotEmpty
        ? Note.fromJson(maps.first)
        : throw Exception('Note ID$id not found');
  }

  Future<List<Note>> readAllNotes() async {
    final db = await instance.database;

    final result = await db.query(tableNotes,
        columns: NoteFields.values,
        orderBy:
            '${NoteFields.time} ASC'); // ASC for ascending and DESC for descending
    return result.isNotEmpty
        ? result.map((e) => Note.fromJson(e)).toList()
        : [];
  }

  Future<int> update(Note note) async {
    final db = await instance.database;

    return await db.update(tableNotes, note.toJson(),
        where: '${NoteFields.id} = ?', whereArgs: [note.id]);
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db
        .delete(tableNotes, where: '${NoteFields.id} = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    _database = null;
    return db.close();
  }
}
