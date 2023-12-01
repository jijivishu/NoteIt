import 'package:note_it/services/notes/drf_note_provider.dart';
import 'package:note_it/services/notes/notes_note.dart';
import 'package:note_it/services/notes/notes_provider.dart';
import 'package:note_it/services/notifications/task_result.dart';

class NoteService implements NoteProvider {
  final NoteProvider provider;
  NoteService({required this.provider});

  factory NoteService.fromDRF() => NoteService(provider: DRFNoteProvider());

  @override
  Future<TaskResult> createNote({
    required String content,
  }) =>
      provider.createNote(content: content);

  @override
  Future<TaskResult> deleteNote({
    required Note note,
  }) => provider.deleteNote(note: note);

  @override
  Future<Note> fetchNote({
    required Uri url,
  }) => provider.fetchNote(url: url);

  @override
  Future<TaskResult> updateNote({
    required Note oldNote,
    required Note updatedNote,
  }) => provider.updateNote(oldNote: oldNote, updatedNote: updatedNote);
  
  @override
  List<Note> listOfNotes = [];
}
