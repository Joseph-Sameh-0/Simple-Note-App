import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NoteDatabase {
  static final NoteDatabase instance = NoteDatabase._init();

  static Database? _database;

  NoteDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1);
  }

  // Future _createDB(Database db, int version) async {
  //   await db.execute('''
  //     CREATE TABLE notes (
  //       id INTEGER PRIMARY KEY AUTOINCREMENT,
  //       title TEXT NOT NULL,
  //       description TEXT NOT NULL,
  //       dateCreated TEXT NOT NULL
  //     )
  //   ''');
  // }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}
