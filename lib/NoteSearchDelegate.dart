import 'package:flutter/material.dart';
import 'package:p4/screens/note_screen.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';
import '../providers/note_provider.dart';

class NoteSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildNoteList(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildNoteList(context);
  }

  Widget _buildNoteList(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context, listen: false);
    final filteredNotes = noteProvider.notes
        .where((note) => note.title.contains(query) || note.description.contains(query))
        .toList();

    return ListView.builder(
      itemCount: filteredNotes.length,
      itemBuilder: (context, index) {
        final note = filteredNotes[index];
        return ListTile(
          title: Text(note.title),
          subtitle: Text(note.description),
          onTap: () {
            close(context, null);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => NoteScreen(note: note),
              ),
            );
          },
        );
      },
    );
  }
}
