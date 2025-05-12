import '../../../auth/data/models/user_model.dart';

abstract class UserState {}

class UserInitialState extends UserState {}

class UserDataSuccessState extends UserState {
  final UserModel userModel;

  UserDataSuccessState({required this.userModel});
}

class UpdateUserNameState extends UserState {}

class UpdateUserImageState extends UserState {}

class UserAddTaskState extends UserState {}

class UserEditTaskState extends UserState {}
