import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../home/data/repo/tasks_repo.dart';

import '../../data/models/group_model.dart';
import 'edit_task_state.dart';

class EditTaskCubit extends Cubit<EditTaskState> {
  EditTaskCubit() : super(EditTaskInitialState());
  EditTaskCubit get(context) => BlocProvider.of(context);

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController groupController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  GroupModel? group;
  String? imagePath;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void displayTask(int id) {
    var task = TasksRepo().tasks.firstWhere((element) => element.id == id);
    imagePath = task.imagePath;
    log('task: ${task.title}');
    titleController.text = task.title;
    descriptionController.text = task.description;
    groupController.text = task.taskType.name;
    dateController.text = task.createdAt.toString();
    emit(EditTaskDisplayState());
  }

  void editTask(int id) async {
    emit(EditTaskLoadingState());

    Future.delayed(const Duration(seconds: 1), () async {
      if (formKey.currentState!.validate()) {
        try {
          var result = await TasksRepo().editTask(
            id: id,
            title: titleController.text,
            description: descriptionController.text,
          );
          result.fold(
            (error) {
              emit(EditTaskErrorState(error));
            },
            (message) {
              emit(EditTaskSuccessState(message));
            },
          );
        } catch (e) {
          emit(EditTaskErrorState("Failed to edit task"));
        }
      }
    });
  }

  void deleteTask(int id) async {
    emit(EditTaskLoadingState());
    try {
      var result = await TasksRepo().deleteTask(id: id);
      result.fold(
        (error) {
          emit(EditTaskErrorState(error));
        },
        (message) {
          emit(DeleteTaskSuccessState(message));
        },
      );
    } catch (e) {
      emit(EditTaskErrorState("Failed to delete task"));
    }
  }
}
