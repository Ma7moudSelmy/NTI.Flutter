import '../models/task_model.dart';

class TasksRepo {
  // private named constructor
  // prevent anyone from taking objects outside the class
  TasksRepo._internal();
  // make it static to access it in factory
  static final TasksRepo _instance = TasksRepo._internal();
  // add factory to control what the constructors return every time it's used
  factory TasksRepo() {
    return _instance;
  }

  final List<TaskModel> _tasks = [];
  List<TaskModel> get tasks => _tasks;
  void addTask(TaskModel task) {
    _tasks.add(task);
  }
}
