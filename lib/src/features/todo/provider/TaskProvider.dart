import 'package:flutter/material.dart';
import 'package:googlemap/src/features/todo/bloc/objectbox/ObjectBox.dart';

import '../../../../main.dart';
import '../bloc/objectboxwrapper/ObjectBox.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> tasks = [];
  late ObjectBox objectBox;
  List<Task> get taskss => tasks;
  void loadTasks() {
    // Safely load tasks, ensuring we never get a null value
    tasks = objectBox.getAllTasks() ?? [];  // Fallback to an empty list if null
    notifyListeners();
  }

  void removeTask(int taskId) {
    tasks.removeWhere((task) => task.id == taskId);
    notifyListeners();
  }

  void updateTask(Task updatedTask) {
    final index = tasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      tasks[index] = updatedTask;
      notifyListeners();
    }
  }

  void addTask(Task newTask) {
    tasks.add(newTask);
    notifyListeners();
  }

  void toggleTaskCompletion(int taskId) {
    final index = tasks.indexWhere((task) => task.id == taskId);
    if (index != -1) {
      final task = tasks[index];
      task.isCompleted = !task.isCompleted; // Toggle completion status
      objectBox.updateTask(task); // Persist the change to the database
      notifyListeners();
    }
  }

  void refreshTasks() {
    loadTasks(); // Could add debounce or async logic later
  }
}
