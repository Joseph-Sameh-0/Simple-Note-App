import 'package:flutter/material.dart';
import '../../../models/note.dart';
import '../../db/note_database.dart';

class NoteProvider with ChangeNotifier {
  List<Note> _notes = [];

  List<Note> get notes => _notes;

  Future<void> fetchNotes() async {
    final db = await NoteDatabase.instance.database;
    final maps = await db.query('notes', orderBy: 'dateCreated DESC');

    _notes = maps.map((e) => Note.fromMap(e)).toList();
    notifyListeners();
  }

  Future<void> addNote(Note note) async {
    final db = await NoteDatabase.instance.database;
    await db.insert('notes', note.toMap());
    await fetchNotes();
  }

  Future<void> updateNote(Note note) async {
    final db = await NoteDatabase.instance.database;
    await db.update('notes', note.toMap(), where: 'id = ?', whereArgs: [note.id]);
    await fetchNotes();
  }

  Future<void> deleteNoteById(int id) async {
    final db = await NoteDatabase.instance.database;
    await db.delete('notes', where: 'id = ?', whereArgs: [id]);
    await fetchNotes();
  }
}
