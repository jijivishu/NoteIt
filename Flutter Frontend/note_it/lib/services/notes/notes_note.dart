import 'package:equatable/equatable.dart';
import 'package:note_it/services/notes/notes_exceptions.dart';

class Note extends Equatable {
  final String content;
  final String url;

  Note({required this.content, required this.url});

  factory Note.fromDRF(Map<String, dynamic> jsonNote) {
    return switch (jsonNote) {
      // TODO: Handle this case.
      {
        'note': String content,
        'url': String url,
      } =>
        Note(
          content: content,
          url: url,
        ),
      _ => throw InvalidFormatNoteFromDRFException(),
    };
  }

  factory Note.updatedNote(
    Note note,
    String content,
  ) =>
      Note(
        url: note.url,
        content: content,
      );

  @override
  List<Object?> get props => [content, url];
}
