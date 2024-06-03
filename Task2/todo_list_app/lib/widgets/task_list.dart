import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_data.dart';
import 'task_tile.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final task = taskData.tasks[index];
            return TaskTile(
              taskTitle: task.title,
              isChecked: task.isCompleted,
              checkboxCallback: (checkboxState) {
                taskData.updateTask(task);
              },
              longPressCallback: () {
                taskData.deleteTask(task);
              },
            );
          },
          itemCount: taskData.tasks.length,
        );
      },
    );
  }
}
