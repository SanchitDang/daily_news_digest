import 'package:flutter/material.dart';

class QuitConfirmationDialog extends StatefulWidget {
  const QuitConfirmationDialog({super.key});

  @override
  _QuitConfirmationDialogState createState() => _QuitConfirmationDialogState();
}

class _QuitConfirmationDialogState extends State<QuitConfirmationDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirm'),
      content: const Text('Do you really want to quit the app?'),
      actions: [
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
            MaterialStateProperty.all<
                Color>(
              Colors.black),
          ),
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
            MaterialStateProperty.all<
                Color>(
              Colors.black,),
          ),
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Quit'),
        ),
      ],
    );
  }
}
