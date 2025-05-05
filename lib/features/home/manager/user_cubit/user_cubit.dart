import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/models/task_model.dart';

import '../../data/models/user_model.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitialState());
  static UserCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;

  void getUser(UserModel userModel) {
    this.userModel = userModel;
    emit(UserDataSuccessState());
  }

  void updateUserName(String name) {
    log('name from UserCubit: $name');
    if (userModel == null) {
      userModel = UserModel(name: name);
    } else {
      userModel?.name = name;
    }

    emit(UpdateUserNameState());
  }

  void updateUserImage(XFile image) {
    if (userModel == null) {
      userModel = UserModel(image: image);
    } else {
      userModel?.image = image;
    }
    emit(UpdateUserImageState());
  }

  void addTask(TaskModel task) {
    if (userModel == null) {
      userModel = UserModel(tasks: [task]);
    } else {
      userModel?.tasks.add(task);
    }
    emit((UserAddTaskState()));
  }

  void editTask(TaskModel task) {
    if (userModel == null) {
      userModel = UserModel(tasks: [task]);
    } else {
      userModel?.tasks.add(task);
    }
    emit((UserEditTaskState()));
  }
}
