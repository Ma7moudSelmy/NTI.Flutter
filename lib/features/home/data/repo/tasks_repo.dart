import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nti_15_task/core/helper/my_logger.dart';
import 'package:nti_15_task/core/network/api_response.dart';

import '../../../../core/models/default_respons_model.dart';
import '../../../../core/network/api_helper.dart';
import '../../../../core/network/end_points.dart';
import '../models/get_tasks_respone_model.dart';
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
  List<TaskModel> tasks = [];
  // List<TaskModel> get tasks => _tasks;
  // void addTask(TaskModel task) {
  //   tasks.add(task);
  // }

  ApiHelper apiHelper = ApiHelper();

  Future<Either<String, String>> getTasks() async {
    try {
      var response = await apiHelper.getRequest(
        endPoint: EndPoints.getTasks,
        isProtected: true,
      );
      // MyLogger.bgBlue('GetTasks from Repo 2');
      GetTasksResponseModel responseModel = GetTasksResponseModel.fromJson(
        response.data,
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (apiResponse.status) {
        tasks.clear();
        for (TaskModelApi task in responseModel.tasks ?? []) {
          tasks.add(
            TaskModel(
              id: task.id!,
              title: task.title!,
              description: task.description!,
              imagePath: task.imagePath,
            ),
          );
        }
        return Right('tasks fetched successfully');
      } else {
        throw Exception("Something went wrong");
      }
    } catch (e) {
      ApiResponse apiResponse = ApiResponse.fromError(e);
      return Left(apiResponse.message);
    }
  }

  Future<Either<String, String>> addTask({required TaskModel task}) async {
    try {
      TaskModelApi taskModelApi = TaskModelApi(
        title: task.title,
        description: task.description,
        image: task.imageFile,
      );
      var response = await apiHelper.postRequest(
        endPoint: EndPoints.newTask,
        isProtected: true,
        data: await taskModelApi.toJson(),
      );
      DefaultResponseModel responseModel = DefaultResponseModel.fromJson(
        response.data,
      );

      if (responseModel.status != null && responseModel.status == true) {
        return Right(responseModel.message ?? "Task added successfully");
      } else {
        throw Exception("Something went wrong");
      }
    } catch (e) {
      ApiResponse apiResponse = ApiResponse.fromError(e);
      return Left(apiResponse.message);
    }
  }

  Future<Either<String, String>> deleteTask({required int id}) async {
    try {
      var response = await apiHelper.deleteRequest(
        endPoint: '${EndPoints.deleteTask}$id',
        isProtected: true,
      );
      ApiResponse responseModel = ApiResponse.fromResponse(response);

      if (responseModel.status == true) {
        return Right(responseModel.message);
      } else {
        throw Exception("Something went wrong");
      }
    } catch (e) {
      ApiResponse apiResponse = ApiResponse.fromError(e);
      return Left(apiResponse.message);
    }
  }

  Future<Either<String, String>> editTask({
    required int id,
    required String title,
    required String description,
  }) async {
    try {
      var response = await apiHelper.putRequest(
        endPoint: '${EndPoints.updateTask}$id',
        isProtected: true,
        data: {'title': title, 'description': description},
      );
      ApiResponse responseModel = ApiResponse.fromResponse(response);

      if (responseModel.status == true) {
        return Right(responseModel.message);
      } else {
        throw Exception("Something went wrong");
      }
    } catch (e) {
      ApiResponse apiResponse = ApiResponse.fromError(e);
      return Left(apiResponse.message);
    }
  }
}
