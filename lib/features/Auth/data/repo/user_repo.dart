import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/models/default_respons_model.dart';
import '../../../../core/network/api_helper.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/network/end_points.dart';

import '../../../../core/cache/cache_helper.dart';
import '../../../../core/cache/cache_keys.dart';
import '../../../../core/network/api_keys.dart';
import '../models/user_model.dart';

class UserRepo {
  UserRepo._internal();

  static final UserRepo _instance = UserRepo._internal();

  factory UserRepo() {
    return _instance;
  }

  ApiHelper apiHelper = ApiHelper();

  Future<Either<String, void>> register(
    String username,
    String password,
    XFile? image,
  ) async {
    try {
      await apiHelper.postRequest(
        endPoint: EndPoints.register,
        data: {
          'username': username,
          'password': password,
          'image':
              image != null ? await MultipartFile.fromFile(image.path) : null,
        },
      );
      return const Right(null);
    } catch (e) {
      ApiResponse response = ApiResponse.fromError(e);
      return Left(response.message);
    }
  }

  Future<Either<String, UserModel>> login({
    required String username,
    required String password,
  }) async {
    try {
      ApiResponse response = await apiHelper.postRequest(
        endPoint: EndPoints.login,
        data: {'username': username, 'password': password},
      );
      LoginResponseModel loginResponseModel = LoginResponseModel.fromJson(
        response.data,
      );
      if (loginResponseModel.status != null &&
          loginResponseModel.status == true) {
        // store tokens
        await CacheHelper.saveData(
          key: CacheKeys.accessToken,
          value: loginResponseModel.accessToken,
        );
        await CacheHelper.saveData(
          key: CacheKeys.refreshToken,
          value: loginResponseModel.refreshToken,
        );

        // return user model
        if (loginResponseModel.user != null) {
          return Right(loginResponseModel.user!);
        } else {
          throw Exception("Login Failed\nTry Again later");
        }
      } else {
        throw Exception("Login Failed\nTry Again later");
      }
    } catch (e) {
      ApiResponse response = ApiResponse.fromError(e);
      return Left(response.message);
    }
  }

  Future<Either<String, UserModel>> getUserData() async {
    try {
      Response response = await apiHelper.getRequest(
        endPoint: EndPoints.getUserData,
        isProtected: true,
      );
      UserModel userModel = UserModel.fromJson(response.data['user']);
      return Right(userModel);
    } catch (e) {
      ApiResponse response = ApiResponse.fromError(e);
      return Left(response.message);
    }
  }

  Future<Either<String, String>> updateProfile(
    String newUsername,
    XFile? newImage,
  ) async {
    try {
      Response response = await apiHelper.putRequest(
        endPoint: EndPoints.updateProfile,
        data: {
          ApiKeys.username: newUsername,
          ApiKeys.image:
              newImage != null
                  ? await MultipartFile.fromFile(newImage.path)
                  : null,
        },
        isProtected: true,
      );
      ApiResponse responseModel = ApiResponse.fromResponse(response);
      if (responseModel.status) {
        return Right(responseModel.message);
      } else {
        throw Exception(responseModel.message);
      }
    } catch (e) {
      ApiResponse response = ApiResponse.fromError(e);
      return Left(response.message);
    }
  }

  Future<Either<String, String>> changePassword(
    String currentPassword,
    String newPassword,
    String confirmPassword,
  ) async {
    try {
      ApiResponse response = await apiHelper.postRequest(
        endPoint: EndPoints.changePassword,
        data: {
          ApiKeys.currentPassword: currentPassword,
          ApiKeys.newPassword: newPassword,
          ApiKeys.newPasswordConfirm: confirmPassword,
        },
        isProtected: true,
      );

      if (response.status) {
        return Right(response.message);
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      ApiResponse response = ApiResponse.fromError(e);
      return Left(response.message);
    }
  }

  // Future<Either<String, String>> refreshToken() async {
  //   try {
  //     ApiResponse response = await apiHelper.postRequest(
  //       endPoint: EndPoints.refreshToken,

  //       sendRefreshToken: true,
  //     );

  //     if (response.statusCode == 200) {
  //       return Right('Refresh Success');
  //     } else {
  //       throw Exception("Refresh Failed\nTry Again later");
  //     }
  //   } catch (e) {
  //     if (e is DioException) {
  //       if (e.response != null && e.response?.data['message'] != null) {
  //         return Left(e.response?.data['message']);
  //       }
  //     }
  //     print("Error ${e.toString()}");

  //     return Left(e.toString());
  //   }
  // }
}
