// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:note_it/services/notes/bloc/notes_bloc.dart';
// import 'package:note_it/services/notes/bloc/notes_event.dart';
// import 'package:note_it/services/notes/bloc/notes_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_it/services/notes/bloc/notes_bloc.dart';
import 'package:note_it/services/notes/drf_note_provider.dart';
import 'package:note_it/views/note_display_view.dart';
import 'package:note_it/views/landing_page_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Home(),
      debugShowCheckedModeBanner: false,
      routes: {
        NoteDisplayView.noteRouteName: (context) => const NoteDisplayView(),
      },
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NoteBloc>(
      create: (context) => NoteBloc(DRFNoteProvider()),
      child: const LandingPage(),
    );
  }
}
