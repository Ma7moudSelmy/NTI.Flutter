import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class GetTasksResponseModel {
  bool? status;
  List<TaskModelApi>? tasks;

  GetTasksResponseModel({this.status, this.tasks});

  GetTasksResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['tasks'] != null) {
      tasks = <TaskModelApi>[];
      json['tasks'].forEach((v) {
        tasks!.add(TaskModelApi.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (tasks != null) {
      data['tasks'] = tasks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TaskModelApi {
  String? createdAt;
  String? description;
  int? id;
  String? imagePath;
  String? title;
  XFile? image;

  TaskModelApi({
    this.createdAt,
    this.description,
    this.id,
    this.imagePath,
    this.title,
    this.image,
  });

  TaskModelApi.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    description = json['description'];
    id = json['id'];
    imagePath = json['image_path'];
    title = json['title'];
  }

  Future<Map<String, dynamic>> toJson() async {
    final Map<String, dynamic> data = {};
    data['description'] = description;
    data['title'] = title;
    data['image'] =
        image == null
            ? null
            : await MultipartFile.fromFile(image!.path, filename: image!.name);
    return data;
  }
}
