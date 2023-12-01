import 'package:flutter/material.dart';

class CreateNoteSheet extends StatefulWidget {
  const CreateNoteSheet({super.key, required this.onCreation});
  final void Function({required String content}) onCreation;

  @override
  State<CreateNoteSheet> createState() => _CreateNoteSheetState();
}

class _CreateNoteSheetState extends State<CreateNoteSheet> {
  late TextEditingController _newNoteContent;

  @override
  void initState() {
    super.initState();

    _newNoteContent = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _newNoteContent.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SizedBox(
              height: 240,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text('Add a note'),
                      TextField(
                        controller: _newNoteContent,
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        maxLength: 200,
                        autofocus: true,
                        decoration: const InputDecoration(
                          hintText: "Write your note here...",
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: FilledButton(
                              child: const Text('Create'),
                              onPressed: () async {
                                if (_newNoteContent.text.isNotEmpty) {
                                  widget.onCreation(content: _newNoteContent.text);
                                } 
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: ElevatedButton(
                              child: const Text('Cancel'),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}