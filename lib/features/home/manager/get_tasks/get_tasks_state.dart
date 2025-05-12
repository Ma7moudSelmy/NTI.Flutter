import '../../data/models/task_model.dart';

abstract class GetTasksState {}

class GetTasksInitialState extends GetTasksState {}

class GetTasksSuccess extends GetTasksState {
  final List<TaskModel> tasks;
  GetTasksSuccess({required this.tasks});
}
