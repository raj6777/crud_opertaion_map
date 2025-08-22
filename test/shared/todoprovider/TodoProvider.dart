import 'package:flutter_test/flutter_test.dart';
import 'package:googlemap/src/features/todo/bloc/objectboxwrapper/ObjectBox.dart';
import 'package:googlemap/src/features/todo/provider/TaskProvider.dart';
import 'package:mockito/mockito.dart';
import 'package:googlemap/src/features/todo/bloc/objectbox/ObjectBox.dart';

// Mock class to simulate the ObjectBox behavior
class MockObjectBox extends Mock implements ObjectBox {}

void main() {
  // Grouping tests related to TaskProvider
  group('TaskProvider Test', () {

    // Test case to check loadTasks behavior when ObjectBox returns null
    test('should load tasks and fall back to an empty list if null', () {
      final mockObjectBox = MockObjectBox();

      // Mock getAllTasks() to return null
      when(mockObjectBox.getAllTasks()).thenReturn(null);  // Simulate empty state

      final taskProvider = TaskProvider();
      taskProvider.objectBox = mockObjectBox;

      // Load tasks, which should fall back to an empty list
      taskProvider.loadTasks();

      // Verify that tasks is an empty list after load
      expect(taskProvider.tasks, isEmpty);

      // Verify that getAllTasks was called once
      verify(mockObjectBox.getAllTasks()).called(1);
    });

    // Test case to check toggleTaskCompletion behavior
    test('should toggle task completion status', () {
      final mockObjectBox = MockObjectBox();
      final mockTask = Task(id: 1, description: 'Test Task', isCompleted: false);

      // Mock getAllTasks() to return an empty list initially
      when(mockObjectBox.getAllTasks()).thenReturn([]);

      final taskProvider = TaskProvider();
      taskProvider.objectBox = mockObjectBox;

      // Add task to the provider
      taskProvider.addTask(mockTask);

      // Toggle task completion status
      taskProvider.toggleTaskCompletion(mockTask.id);

      // Verify that the completion status was toggled
      expect(taskProvider.tasks[0].isCompleted, true);

      // Verify that the updated task was persisted in the ObjectBox database
      verify(mockObjectBox.updateTask(mockTask)).called(1);
    });

  });
}
