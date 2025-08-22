import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:googlemap/src/core/route/router.gr.dart';
import 'package:googlemap/src/features/todo/provider/TaskProvider.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';
@RoutePage()
class TodoListPage extends StatelessWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TaskProvider>().loadTasks();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Todo List",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, _) {
          if (taskProvider.tasks.isEmpty) {
            return const Center(child: Text("Data is not available"));
          }
          return ListView.builder(
            itemCount: taskProvider.tasks.length,
            itemBuilder: (context, index) {
              final task = taskProvider.tasks[index];
              return Card(
                color: Colors.white,
                child: InkWell(
                  onTap: () async {
                    await context.pushRoute(AddTodoListRoute(taskToEdit: task));
                  },
                  child: ListTile(
                    title: Text(task.description),
                    leading: Checkbox(
                      value: task.isCompleted,
                      onChanged: (value) {
                        task.isCompleted = value ?? false;
                        taskProvider.toggleTaskCompletion(task.id);
                        context.read<TaskProvider>().toggleTaskCompletion(task.id);
                      },
                    ),
                    trailing: IconButton(
                      iconSize: 24,
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        objectBox.deleteTask(task);
                        context.read<TaskProvider>().removeTask(task.id);
                      },
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await context.pushRoute(AddTodoListRoute());
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
    );
  }
}
