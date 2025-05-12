import '../models/user_model.dart';

class UserRepo {
  UserRepo._internal();

  static final UserRepo _instance = UserRepo._internal();

  factory UserRepo() {
    return _instance;
  }

  final UserModel _userModel = UserModel();

  UserModel get userModel => _userModel;
}
