// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';
// import 'package:get/get_connect/http/src/utils/utils.dart';

// import '../../../../core/models/default_respons_model.dart';
// import '../../../../core/network/api_helper.dart';
// import '../../../../core/network/end_points.dart';
// import '../../../home/data/models/get_tasks_respone_model.dart';
// import '../../../home/data/models/task_model.dart';

// class TasksRepo {
//   // singletone
//   TasksRepo._internal();
//   static final TasksRepo _repo = TasksRepo._internal();
//   factory TasksRepo() => _repo;

//   ApiHelper apiHelper = ApiHelper();
//   // Future<Either<String, String>> addTask({required TaskModel task}) async {
//   //   try {
//   //     var response = await apiHelper.postRequest(
//   //       endPoint: EndPoints.newTask,
//   //       isProtected: true,
//   //       data: await task.toJson(),
//   //     );
//   //     DefaultResponseModel responseModel = DefaultResponseModel.fromJson(
//   //       response.data,
//   //     );

//   //     if (responseModel.status != null && responseModel.status == true) {
//   //       return Right(responseModel.message ?? "Task added successfully");
//   //     } else {
//   //       throw Exception("Something went wrong");
//   //     }
//   //   } catch (e) {
//   //     if (e is DioException) {
//   //       if (e.response != null && e.response?.data['message'] != null) {
//   //         return Left(e.response?.data['message']);
//   //       }
//   //     }

//   //     print("Error ${e.toString()}");
//   //     return Left(e.toString());
//   //   }
//   // }

//   Future<Either<String, List<TaskModel>>> getTasks() async {
//     try {
//       var response = await apiHelper.getRequest(
//         endPoint: EndPoints.getTasks,
//         isProtected: true,
//       );
//       GetTasksResponseModel responseModel = GetTasksResponseModel.fromJson(
//         response.data,
//       );

//       if (responseModel.status != null && responseModel.status == true) {
//         List<TaskModel> tasks = [];
//         for (TaskModelApi task in responseModel.tasks ?? []) {
//           tasks.add(
//             TaskModel(
//               id: task.id!,
//               title: task.title!,
//               description: task.description!,
//             ),
//           );
//         }

//         return Right(tasks);
//       } else {
//         throw Exception("Something went wrong");
//       }
//     } catch (e) {
//       if (e is DioException) {
//         if (e.response != null && e.response?.data['message'] != null) {
//           return Left(e.response?.data['message']);
//         }
//       }

//       print("Error ${e.toString()}");
//       return Left(e.toString());
//     }
//   }
// }
