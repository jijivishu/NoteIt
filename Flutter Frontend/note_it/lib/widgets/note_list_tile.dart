import 'package:note_it/views/note_display_view.dart';
import 'package:note_it/services/notes/notes_note.dart';
import 'package:flutter/material.dart';


class NoteListTile extends StatelessWidget {
  const NoteListTile({super.key, required this.currentNote});
  final Note currentNote;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, NoteDisplayView.noteRouteName,
            arguments: currentNote);
      },
      title: Text(
        currentNote.content,
        maxLines: 1,
      ),
      subtitle: Text(currentNote.content),
    );
  }
}
