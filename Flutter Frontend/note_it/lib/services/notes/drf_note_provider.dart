import 'dart:convert' show jsonDecode, jsonEncode;
import 'dart:io' show SocketException;

import 'package:note_it/services/notes/notes_exceptions.dart';
import 'package:note_it/services/notes/notes_note.dart';
import 'package:note_it/services/notes/notes_provider.dart';
import 'package:note_it/services/notifications/task_result.dart';
import 'package:http/http.dart' as http;

class DRFNoteProvider implements NoteProvider {
  // Constants
  static const String allNotesAPIlocation = 'http://199.111.111.11:8000/notes/'; // Link where the rest framework is running
  static final Uri allNotesAPIURL = Uri.parse(allNotesAPIlocation);

  static const Map<int, String> statusMessages = {
    200: 'OK',
    201: 'Created',
    204: 'No Content returned',
    400: 'Please check your input.',
    401: "You're unauthorized for this task",
    403: 'You don\'t have permission for this',
    404: 'Resource not found.',
    409: 'Conflict detected.',
    500: 'Server Failure',
  };


  @override
  Future<TaskResult> createNote({required String content}) async {
    try {
      final response = await http.post(
        allNotesAPIURL,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'note': content}),
      );
      final int statusCode = response.statusCode;

      if (statusCode == 201) {
        return TaskResult.success(message: 'Note Created');
      }
      return TaskResult.failure(
          message: statusMessages[statusCode] ?? "Failed to update Note");
    } catch (error) {
      if (error is SocketException) {
        return TaskResult.failure(
            message:
                'Failed to connect to the internet. Please check your connection.');
      }
      return TaskResult.failure(message: 'Failed to update Note');
    }
  }


  @override
  Future<TaskResult> deleteNote({required Note note}) async {
    final url = Uri.parse(note.url);
    try {
      final response = await http.delete(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      final int statusCode = response.statusCode;

      if (statusCode == 204) {
        return TaskResult.success(message: 'Note Deleted');
      }
      return TaskResult.failure(
          message: statusMessages[statusCode] ?? "Failed to update Note");
    } catch (error) {
      if (error is SocketException) {
        return TaskResult.failure(
            message:
                'Failed to connect to the internet. Please check your connection.');
      }
      return TaskResult.failure(message: 'Failed to update Note');
    }
  }


  @override
  Future<Note> fetchNote({required Uri url}) async {
    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return Note.fromDRF(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw FailedToLoadNoteFromDRFException();
    }
  }


  @override
  Future<TaskResult> updateNote(
      {required Note oldNote, required String newNoteContent}) async {
    final url = Uri.parse(oldNote.url);
    try {
      final response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'note': newNoteContent}),
      );
      final int statusCode = response.statusCode;

      if (statusCode == 200) {
        return TaskResult.success(message: 'Note Updated');
      }
      return TaskResult.failure(
          message: statusMessages[statusCode] ?? "Failed to update Note");
    } catch (error) {
      if (error is SocketException) {
        return TaskResult.failure(
            message:
                'Failed to connect to the internet. Please check your connection.');
      }
      return TaskResult.failure(message: 'Failed to update Note');
    }
  }
}
