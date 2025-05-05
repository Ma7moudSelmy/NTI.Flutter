import '../../features/home/data/models/user_model.dart';

abstract class CacheData {
  static bool? firstTime;
  static UserModel? userModel;
}
