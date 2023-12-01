import 'dart:convert';

import 'package:note_it/services/notes/notes_note.dart';
import 'package:http/http.dart' as http;

Future<List<Note>> fetchNoteList() async {
  Uri baseUrl = Uri.parse('http://199.111.111.11:8000/notes/'); // Link where the rest framework is running

  final response = await http.get(
    baseUrl,
  );

  if (response.statusCode == 200) {
    final decodedData = jsonDecode(response.body) ;
    final List<Map<String, dynamic>> receivedNotes = List<Map<String, dynamic>>.from(decodedData);
    List<Note> allNotes = [];
    for (Map<String, dynamic> note in receivedNotes) {
      allNotes.add(Note.fromDRF(note));
    }
    return allNotes;
  }
  else {
    throw Exception('Failed to load list of notes');
  }
}