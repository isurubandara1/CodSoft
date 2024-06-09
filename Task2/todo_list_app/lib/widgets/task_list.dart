import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/providers/task_data.dart';
import 'package:todo_list_app/widgets/task_tile.dart';

import '../screens/edit_task_screen.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final task = taskData.tasks[index];
            return Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                TaskTile(
                  taskTitle: task.title,
                  isChecked: task.isCompleted,
                  checkboxCallback: (checkboxState) {
                    taskData.updateTask(task);
                  },
                  longPressCallback: () {
                    taskData.deleteTask(task);
                  },
                  editCallback: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => EditTaskScreen(
                        task: task,
                        taskIndex: index,
                      ),
                    );
                  },
                ),
                if (index < taskData.tasks.length - 1)
                  Container(
                    height: 2,
                    color: Colors.orange,
                  ),
              ],
            );
          },
          itemCount: taskData.tasks.length,
        );
      },
    );
  }
}
