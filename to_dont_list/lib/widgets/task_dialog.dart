import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/task.dart';

typedef TaskDetailsSaveCallback = Function(int rating, String description, bool wouldDoAgain);

class TaskDialog extends StatefulWidget {
  const TaskDialog({
    super.key,
    required this.task,
    required this.onSave,
  });

  final Task task;
  final TaskDetailsSaveCallback onSave;

  @override
  State<TaskDialog> createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {
  int _rating = 0;
  String _description = '';
  bool _wouldDoAgain = false;

  final ButtonStyle yesStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.green);
  final ButtonStyle noStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.red);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('How was ${widget.task.name}?'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Rating input (e.g., using Slider)
          const Text('Rate this task:'),
          Slider(
            value: _rating.toDouble(),
            min: 0,
            max: 5,
            divisions: 5,
            label: '$_rating',
            onChanged: (value) {
              setState(() {
                _rating = value.toInt();
              });
            },
          ),
          // Description input
          TextField(
            decoration: const InputDecoration(labelText: 'Describe the task'),
            onChanged: (value) {
              setState(() {
                _description = value;
              });
            },
          ),
          // Checkbox for "Would do again"
          CheckboxListTile(
            title: const Text('Would you do this task again?'),
            value: _wouldDoAgain,
            onChanged: (value) {
              setState(() {
                _wouldDoAgain = value ?? false;
              });
            },
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          style: yesStyle,
          onPressed: () {
            widget.onSave(_rating, _description, _wouldDoAgain);
            Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
        ElevatedButton(
          style: noStyle,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
