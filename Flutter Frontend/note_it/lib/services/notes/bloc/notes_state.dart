import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show immutable;
import 'package:note_it/services/notes/notes_note.dart' show Note;

@immutable
abstract class NoteState extends Equatable {
  const NoteState();
}

class NotesLoadingState extends NoteState {
  @override
  List<Object?> get props => [];
}

class NotesLoadedState extends NoteState {
  final List<Note> notes;

  const NotesLoadedState({required this.notes});
  @override
  List<Object?> get props => [];
}

class NotesErrorState extends NoteState {
  final String errorMessage;

  const NotesErrorState({required this.errorMessage});
  
  @override
  List<Object?> get props => [];
}

class TaskOnNoteSuccessfulState extends NoteState {
  final String successMessage;

  const TaskOnNoteSuccessfulState({required this.successMessage});
  
  @override
  List<Object?> get props => [successMessage];
}