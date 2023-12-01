import 'package:note_it/note_list_provider.dart';
import 'package:note_it/services/notes/notes_note.dart';
import 'package:note_it/widgets/create_note_fab.dart';
import 'package:note_it/widgets/notes_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Note>> listOfNotes;

  Future<void> _triggerRefresh() async {
    setState(() {
      listOfNotes = fetchNoteList();
    });
  }

  @override
  void initState() {
    super.initState();

    _triggerRefresh();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Notes"),
      ),
      body: Center(
          child: RefreshIndicator(
        onRefresh: _triggerRefresh,
        child: FutureBuilder<List<Note>>(
          future: listOfNotes,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return NotesList(triggerRefresh: _triggerRefresh, listOfNotes: snapshot.data!,);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      )),
      floatingActionButton: CreateNoteFAB(onSuccess: _triggerRefresh),
    );
  }
}
