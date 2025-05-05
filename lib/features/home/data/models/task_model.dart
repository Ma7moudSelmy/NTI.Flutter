import 'package:image_picker/image_picker.dart';

class TaskModel {
  int id;
  String title;
  String description;
  TaskStatus taskState;
  TaskGroup taskType;
  DateTime? endTime;
  XFile? imageFile;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.taskState,
    required this.taskType,
    this.endTime,
    this.imageFile,
  });
}

enum TaskStatus { all, inProgress, done, missed }

enum TaskGroup { all, personal, work, home }
