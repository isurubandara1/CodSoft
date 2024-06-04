import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_data.dart';
import '../models/task.dart';

class EditTaskScreen extends StatelessWidget {
  final Task task;
  final int taskIndex;

  EditTaskScreen({required this.task, required this.taskIndex});

  @override
  Widget build(BuildContext context) {
    String editedTaskTitle = task.title;

    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextField(
            onChanged: (newText) {
              editedTaskTitle = newText;
            },
            controller: TextEditingController()..text = task.title,
            decoration: InputDecoration(
              labelText: 'Edit Task',
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              if (editedTaskTitle.isNotEmpty) {
                Provider.of<TaskData>(context, listen: false)
                    .editTask(taskIndex, editedTaskTitle);
                Navigator.pop(context);
              }
            },
            child: Text(
              'Save Changes',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.orange,
              elevation: 5,
            ),
          ),
        ],
      ),
    );
  }
}
