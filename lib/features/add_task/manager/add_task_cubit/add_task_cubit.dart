import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'add_task_state.dart';
import '../../../home/data/my_tasks.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../home/data/models/task_model.dart';
import '../../../home/manager/user_cubit/user_cubit.dart';
import '../../data/models/group_model.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  AddTaskCubit() : super(AddTaskInitial());
  static AddTaskCubit get(context) => BlocProvider.of(context);

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController groupController = TextEditingController();
  DateTime? endDate;
  GroupModel? group;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<GroupModel> groups = [
    GroupModel(name: 'Work', iconPath: AppAssets.work),
    GroupModel(name: 'Personal', iconPath: AppAssets.personal),
    GroupModel(name: 'Home', iconPath: AppAssets.home),
  ];

  void changeGroup(GroupModel group) {
    this.group = group;
    emit(AddTaskChangeGroup());
  }

  void changeDate(DateTime endDate) {
    this.endDate = endDate;
    emit(AddTaskChangeDate());
  }

  XFile? imageFile;
  void changeImage() async {
    final ImagePicker picker = ImagePicker();
    imageFile = await picker.pickImage(source: ImageSource.gallery);
    emit(AddTaskChangeImage());
  }

  void addTask(UserCubit userCubit) {
    emit(AddTaskLoading());
    Future.delayed(const Duration(seconds: 1), () {
      if (formKey.currentState!.validate()) {
        TaskGroup taskGroup = () {
          if (group!.name == 'Work') {
            return TaskGroup.work;
          } else if (group!.name == 'Personal') {
            return TaskGroup.personal;
          } else {
            return TaskGroup.home;
          }
        }();
        userCubit.addTask(
          TaskModel(
            title: titleController.text,
            description: descriptionController.text,
            id: MyTasks.myTasks.length,
            taskState: TaskStatus.inProgress,
            taskType: taskGroup,
            endTime: endDate,
            imageFile: imageFile,
          ),
        );
        log(
          'message from add task cubit: ${userCubit.userModel?.tasks.length}',
        );
        emit(AddTaskSuccess());
      } else {
        emit(AddTaskError(errorMessage: 'please fill all fields'));
      }
    });
  }
}
