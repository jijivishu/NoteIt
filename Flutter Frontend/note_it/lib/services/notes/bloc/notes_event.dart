import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show immutable;
import 'package:note_it/services/notes/notes_note.dart' show Note;

@immutable
abstract class NoteEvent extends Equatable {
  const NoteEvent();
}

class NoteEventInitialize extends NoteEvent {
  const NoteEventInitialize();
  
  @override
  List<Object?> get props => [];

}

class NoteEventCreate extends NoteEvent {
  final String content;

  const NoteEventCreate({required this.content});
  
  @override
  List<Object?> get props => [content];
}

class NoteEventFetch extends NoteEvent {
  final Uri url;

  const NoteEventFetch({required this.url});
  
  @override
  List<Object?> get props => [url];
}

class NoteEventUpdate extends NoteEvent {
  final Note oldNote;
  final Note updatedNote;

  const NoteEventUpdate({
    required this.oldNote,
    required this.updatedNote,
  });
  
  @override
  List<Object?> get props => [oldNote, updatedNote];
}

class NoteEventDelete extends NoteEvent {
  final Note note;

  const NoteEventDelete({required this.note});
  
  @override
  List<Object?> get props => [note];
}
