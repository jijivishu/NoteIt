import 'package:note_it/services/notes/notes_note.dart';
import 'package:note_it/services/notifications/task_result.dart';

abstract class NoteProvider {
  List<Note> listOfNotes = [];
  
  Future<TaskResult> createNote({
    required String content,
  });

  Future<TaskResult> updateNote({
    required Note oldNote,
    required Note updatedNote,
  });

  Future<TaskResult> deleteNote({
    required Note note,
  });

  Future<Note> fetchNote({
    required Uri url,
  });
}
