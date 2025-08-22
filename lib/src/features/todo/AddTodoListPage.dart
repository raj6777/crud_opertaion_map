import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:googlemap/src/features/todo/provider/TaskProvider.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';
import 'bloc/objectbox/ObjectBox.dart';

@RoutePage()
class AddTodoListPage extends StatelessWidget {
  final Task? taskToEdit;
  final TextEditingController _taskController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  AddTodoListPage({super.key, this.taskToEdit}) {
    if (taskToEdit != null) {
      _taskController.text = taskToEdit!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(taskToEdit == null ? "Add Task" : "Edit Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(taskToEdit == null ? "Add your Task here" : "Edit your Task"),
              const SizedBox(height: 20),
              TextFormField(
                controller: _taskController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: "Task",
                  hintText: "Enter your task",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Task is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final taskDescription = _taskController.text.trim();
                    if (taskToEdit == null) {
                      final task = Task(description: taskDescription);
                      objectBox.addTask(task);
                      context.read<TaskProvider>().addTask(task);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Task Added!')),
                      );
                    } else {
                      taskToEdit!.description = taskDescription;
                      objectBox.updateTask(taskToEdit!);
                      context.read<TaskProvider>().updateTask(taskToEdit!);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Task Updated!')),
                      );
                    }
                    Navigator.of(context).pop();
                  }
                },
                child: Text(taskToEdit == null ? "Add" : "Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
