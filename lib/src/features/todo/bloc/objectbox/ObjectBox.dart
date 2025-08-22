import 'package:objectbox/objectbox.dart';

@Entity()
class Task {
  int id;

  String description;

  bool isCompleted;

  Task({this.id = 0, required this.description, this.isCompleted = false});
}