import 'package:note_it/views/note_display_view.dart';
import 'package:note_it/views/home_page_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
      routes: {
        NoteDisplayView.noteRouteName: (context) => const NoteDisplayView(),
      },
    );
  }
}
