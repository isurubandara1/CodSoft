import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_data.dart';
import '../widgets/task_list.dart';

class TaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String newTaskTitle;

    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: TaskList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) => Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        TextField(
                          onChanged: (newText) {
                            newTaskTitle = newText;
                          },
                          decoration: InputDecoration(
                            labelText: 'New Task',
                          ),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            Provider.of<TaskData>(context, listen: false)
                                .addTask(newTaskTitle);
                            Navigator.pop(context);
                          },
                          child: Text('Add Task'),
                        ),
                      ],
                    ),
                  ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
