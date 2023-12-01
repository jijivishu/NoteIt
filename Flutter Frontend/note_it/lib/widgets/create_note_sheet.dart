import 'package:note_it/services/notes/notes_service.dart';
import 'package:note_it/services/notifications/task_result.dart';
import 'package:flutter/material.dart';

class CreateNoteSheet extends StatefulWidget {
  const CreateNoteSheet({super.key});

  @override
  State<CreateNoteSheet> createState() => _CreateNoteSheetState();
}

class _CreateNoteSheetState extends State<CreateNoteSheet> {
  late TextEditingController _newNoteContent;
  final NoteService _notesService = NoteService.fromDRF();
  TaskResult? creationResponse;

  @override
  void initState() {
    super.initState();

    _newNoteContent = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _newNoteContent.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SizedBox(
              height: 240,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text('Add a note'),
                      TextField(
                        controller: _newNoteContent,
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        maxLength: 200,
                        autofocus: true,
                        decoration: const InputDecoration(
                          hintText: "Write your note here...",
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: FilledButton(
                              child: const Text('Create'),
                              onPressed: () async {
                                if (_newNoteContent.text.isNotEmpty) {
                                  creationResponse = await _notesService.createNote (
                                      content: _newNoteContent.text);
                                } else {
                                  creationResponse = TaskResult.failure(message: "Cannot create empty notes");
                                }
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: ElevatedButton(
                              child: const Text('Cancel'),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}