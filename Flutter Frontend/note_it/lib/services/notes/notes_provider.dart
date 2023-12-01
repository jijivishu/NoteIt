import 'package:note_it/services/notes/notes_note.dart';
import 'package:note_it/services/notifications/task_result.dart';

abstract class NoteProvider {
  Future<TaskResult> createNote({
    required String content,
  });

  Future<TaskResult> updateNote({
    required Note oldNote,
    required String newNoteContent,
  });

  Future<TaskResult> deleteNote({
    required Note note,
  });

  Future<Note> fetchNote({
    required Uri url,
  });
}
