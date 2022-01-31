//@dart=2.8
import 'package:flutter/material.dart';

class NoteAlertDialog extends StatelessWidget {

  final String contentText;
  final Function confirmFunction;
  final Function declineFunction;

  const NoteAlertDialog({this.contentText, this.confirmFunction,
    this.declineFunction});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(contentText),
      actions: [
        TextButton(onPressed: confirmFunction, child: const Text("Yes")),
        TextButton(onPressed: declineFunction, child: const Text("No")),
      ],
    );
  }
}
