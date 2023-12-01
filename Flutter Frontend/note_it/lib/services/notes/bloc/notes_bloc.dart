import 'package:bloc/bloc.dart';
import 'package:note_it/services/notes/bloc/notes_event.dart';
import 'package:note_it/services/notes/bloc/notes_state.dart';
import 'package:note_it/services/notes/drf_note_provider.dart';
import 'package:note_it/services/notes/notes_note.dart';
import 'package:note_it/services/notifications/task_result.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteBloc(DRFNoteProvider provider) : super(NotesLoadingState()) {
    
    // Fetch complete list of notes
    on<NoteEventInitialize>((event, emit) async {
      TaskResult fetchAllNotesResult = await provider.fetchAllNotes();
      if (!fetchAllNotesResult.success) {
        emit(NotesErrorState(errorMessage: fetchAllNotesResult.message, listOfNotes: []));
      } else {
        emit(NotesLoadedState(notes: provider.listOfNotes));
      }
    });

    // Create new note
    on<NoteEventCreate>((event, emit) async {
      TaskResult createNoteResult =
          await provider.createNote(content: event.content);
      if (!createNoteResult.success) {
        emit(NotesErrorState(errorMessage: createNoteResult.message, listOfNotes: provider.listOfNotes));
      } else {
        add(const NoteEventInitialize()); // To re-fetch notes after every new note creation
        emit(TaskOnNoteSuccessfulState(
            successMessage: createNoteResult.message, 
            listOfNotes: provider.listOfNotes,));
      }
    });

    // Update existing note
    on<NoteEventUpdate>((event, emit) async {
      TaskResult updateNoteResult = await provider.updateNote(
        oldNote: event.oldNote,
        updatedNote: event.updatedNote,
      );
      if (!updateNoteResult.success) {
        emit(NotesErrorState(errorMessage: updateNoteResult.message, listOfNotes: provider.listOfNotes));
      } else {
        final List<Note> updatedListOfNotes = List.from(provider.listOfNotes)..remove(event.oldNote)..add(event.updatedNote);
        provider.listOfNotes = updatedListOfNotes;
        emit(NotesLoadedState(notes: updatedListOfNotes));
        emit(TaskOnNoteSuccessfulState(
            successMessage: updateNoteResult.message,
            listOfNotes: updatedListOfNotes,));
      }
    });

    // Delete existing note
    on<NoteEventDelete>((event, emit) async {
      TaskResult deleteNoteResult = await provider.deleteNote(note: event.note);
      if (!deleteNoteResult.success) {
        emit(NotesErrorState(errorMessage: deleteNoteResult.message, listOfNotes: provider.listOfNotes));
      } else {
        final List<Note> updatedListOfNotes = List.from(provider.listOfNotes)..remove(event.note);
        provider.listOfNotes = updatedListOfNotes;
        emit(NotesLoadedState(notes: updatedListOfNotes));
        emit(TaskOnNoteSuccessfulState(
            successMessage: deleteNoteResult.message,
            listOfNotes: updatedListOfNotes,));
      }
    });
  }
}
