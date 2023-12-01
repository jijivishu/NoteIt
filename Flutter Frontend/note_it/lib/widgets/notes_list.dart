import 'package:note_it/services/notes/notes_note.dart';
import 'package:note_it/widgets/note_list_tile.dart';
import 'package:flutter/material.dart';

class NotesList extends StatelessWidget {
  NotesList({
    super.key,
    required this.listOfNotes,
    required this.onDeletion,
    required this.onUpdation,
  });
  final List<Note> listOfNotes;
  final void Function({required Note note}) onDeletion;
  final void Function({
    required Note oldNote,
    required Note updatedNote,
  }) onUpdation;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listOfNotes.length,
        itemBuilder: (context, index) {
          return Dismissible(
              key: UniqueKey(),
              onDismissed: (DismissDirection dismissDirection) async {
                listOfNotes.removeAt(index);
              },
              confirmDismiss: (DismissDirection direction) async {
                bool confirmed = await showDialog<bool>(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Are you sure you want to delete?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('No'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text('Yes'),
                            )
                          ],
                        );
                      },
                    ) ??
                    false;

                print('Deletion confirmed by user: $confirmed');

                if (confirmed) {
                  onDeletion(note: listOfNotes[index]);
                }
                return confirmed;
              },
              child: NoteListTile(
                currentNote: listOfNotes[index],
                onUpdation: onUpdation,
              ));
        });
  }
}
