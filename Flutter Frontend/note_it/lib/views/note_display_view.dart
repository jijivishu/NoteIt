import 'package:note_it/services/notes/notes_note.dart';
import 'package:flutter/material.dart';

class NoteDisplayView extends StatefulWidget {
  const NoteDisplayView({
    super.key,
  });
  static const noteRouteName = '/note/';

  @override
  State<NoteDisplayView> createState() => _NoteDisplayViewState();
}

class _NoteDisplayViewState extends State<NoteDisplayView> {
  late final TextEditingController _newNoteContent;

  Future<bool?> _shouldUpdateNote(BuildContext context) async {
    bool? saveChanges = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('This note has unsaved changes?'),
          content: const Text('Do you want to save new changes?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Save changes
              },
              child: const Text('Yes, save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Discard changes
              },
              child: const Text("Don't save"),
            ),
          ],
        );
      },
    );

    return saveChanges;
  }

  @override
  void initState() {
    _newNoteContent = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _newNoteContent.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final Note note = arguments['currentNote'];
    final void Function({required Note oldNote, required Note updatedNote})
        onUpdation = arguments['onUpdation'];
    final oldNoteContent = note.content;
    _newNoteContent.text = oldNoteContent;

    return PopScope(
      canPop: false,
      onPopInvoked: (_) async {
        if (_newNoteContent.text == oldNoteContent) {
          Navigator.of(context).pop();
        } else {
          final bool? mustUpdateNote = await _shouldUpdateNote(context);
          print(mustUpdateNote);
          if (mustUpdateNote ?? false) {
            final updatedNote = Note.updatedNote(note, _newNoteContent.text);
            onUpdation(oldNote: note, updatedNote: updatedNote);
          }
          if (context.mounted && mustUpdateNote != null) {
            Navigator.of(context).pop();
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(note.content),
        ),
        body: TextField(
          maxLines: 30,
          maxLength: 200,
          controller: _newNoteContent,
        ),
      ),
    );
  }
}
