import 'package:objectbox/objectbox.dart';
import '../../../../../objectbox.g.dart';
import '../objectbox/ObjectBox.dart';

class ObjectBox {
  late final Store store;
  late final Box<Task> taskBox;

  ObjectBox._create(this.store) {
    taskBox = Box<Task>(store);
  }

  static Future<ObjectBox> create() async {
    final store = await openStore();
    return ObjectBox._create(store);
  }

  void addTask(Task task) {
    taskBox.put(task);
  }

  void updateTask(Task task) {
    taskBox.put(task);
  }

  void deleteTask(Task task){
    taskBox.remove(task.id);
  }
  List<Task>? getAllTasks() {
    // Safely handle null and return an empty list if taskBox.getAll() returns null
    final tasks = taskBox.getAll();
    return tasks ?? null;  // Ensure no null value is returned
  }
}
