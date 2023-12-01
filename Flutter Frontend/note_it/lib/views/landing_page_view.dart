import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_it/services/notes/bloc/notes_bloc.dart';
import 'package:note_it/services/notes/bloc/notes_event.dart';
import 'package:note_it/services/notes/bloc/notes_state.dart';
import 'package:note_it/services/notes/notes_note.dart';
import 'package:note_it/widgets/create_note_sheet.dart';
import 'package:note_it/widgets/custom_snackbar.dart';
import 'package:note_it/widgets/notes_list.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late Future<List<Note>> listOfNotes;

  Future<void> _triggerRefresh() async {
    print('Being called');
    context.read<NoteBloc>().add(const NoteEventInitialize());
  }

  void _onCreation({required String content}) {
    context.read<NoteBloc>().add(NoteEventCreate(content: content));
  }

  void _onDeletion({required Note note}) {
    context.read<NoteBloc>().add(NoteEventDelete(note: note));
  }

  void _onUpdation({required Note oldNote, required Note updatedNote}) {
    context
        .read<NoteBloc>()
        .add(NoteEventUpdate(oldNote: oldNote, updatedNote: updatedNote));
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
        child: BlocBuilder<NoteBloc, NoteState>(
          builder: (context, state) {
            if (state is NotesLoadingState) {
              return const CircularProgressIndicator();
            } else if (state is NotesLoadedState) {
              print("Reacjed here");
              return NotesList(
                  onDeletion: ({required Note note}) {
                    _onDeletion(note: note);
                  },
                  onUpdation: ({
                    required Note oldNote,
                    required Note updatedNote,
                  }) {
                    _onUpdation(
                      oldNote: oldNote,
                      updatedNote: updatedNote,
                    );
                  },
                  listOfNotes: state.notes);
            } else if (state is NotesErrorState) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                CustomSnackBar.showFailure(context,
                    message: state.errorMessage);
              });
              return NotesList(
                  onDeletion: ({required Note note}) {
                    _onDeletion(note: note);
                  },
                  onUpdation: ({
                    required Note oldNote,
                    required Note updatedNote,
                  }) {
                    _onUpdation(
                      oldNote: oldNote,
                      updatedNote: updatedNote,
                    );
                  },
                  listOfNotes: state.listOfNotes);
            } else if (state is TaskOnNoteSuccessfulState) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                CustomSnackBar.showSuccess(context,
                    message: state.successMessage);
              });
              return NotesList(
                  onDeletion: ({required Note note}) {
                    _onDeletion(note: note);
                  },
                  onUpdation: ({
                    required Note oldNote,
                    required Note updatedNote,
                  }) {
                    _onUpdation(
                      oldNote: oldNote,
                      updatedNote: updatedNote,
                    );
                  },
                  listOfNotes: state.listOfNotes);
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (_) =>
                CreateNoteSheet(onCreation: ({required String content}) {
              _onCreation(content: content);
            }),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
