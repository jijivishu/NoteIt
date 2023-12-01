import 'package:note_it/widgets/create_note_sheet.dart';
import 'package:flutter/material.dart';

class CreateNoteFAB extends StatefulWidget {
  const CreateNoteFAB({Key? key, required Future<void> Function() onSuccess})
      : _onSuccess = onSuccess,
        super(key: key);

  final Future<void> Function() _onSuccess;

  @override
  State<CreateNoteFAB> createState() => _CreateNoteFABState();
}

class _CreateNoteFABState extends State<CreateNoteFAB> {
  Future<String> _createNewNote() async {
    late String response = "";
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) => const CreateNoteSheet(),
    );
    return response;
  }

  //   await showModalBottomSheet(
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        final String response = await _createNewNote();

        if (context.mounted && response.isNotEmpty) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(response)));
          widget._onSuccess();
        } else {
          print("OH no");
        }
      },
      child: const Icon(Icons.add),
    );
  }
}
