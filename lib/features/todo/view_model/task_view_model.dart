import 'package:dio/dio.dart';
import 'package:nti/core/services/api_endpoints.dart';
import 'package:nti/core/services/dio_client.dart';
import 'package:nti/features/todo/model/task_model.dart';


class TaskViewModel {
  Future<List<TaskModel>> myTasks() async {
    try {
      final response = await DioClient.dio.get(ApiEndpoints.myTasks);
      final list = response.data is List
          ? response.data as List
          : (response.data['tasks'] ?? response.data['data'] ?? []) as List;
      return list
          .map((e) => TaskModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _errorMessage(e);
    }
  }

  Future<void> createTask({
    required String title,
    required String description,
    String? imagePath,
  }) async {
    try {
      final formData = FormData.fromMap({
        'title': title,
        'description': description,
        if (imagePath != null)
          'image': await MultipartFile.fromFile(imagePath),
      });
      await DioClient.dio.post(ApiEndpoints.newTask, data: formData);
    } on DioException catch (e) {
      throw _errorMessage(e);
    }
  }

  Future<void> updateTask({
    required int id,
    required String title,
    required String description,
    String? imagePath,
  }) async {
    try {
      final formData = FormData.fromMap({
        'title': title,
        'description': description,
        if (imagePath != null)
          'image': await MultipartFile.fromFile(imagePath),
      });
      await DioClient.dio.put(ApiEndpoints.task(id), data: formData);
    } on DioException catch (e) {
      throw _errorMessage(e);
    }
  }

  Future<void> deleteTask(int id) async {
    try {
      await DioClient.dio.delete(ApiEndpoints.task(id));
    } on DioException catch (e) {
      throw _errorMessage(e);
    }
  }

  String _errorMessage(DioException e) {
    final data = e.response?.data;
    if (data is Map && data['message'] != null) return data['message'].toString();
    if (data is Map && data['msg'] != null) return data['msg'].toString();
    return e.message ?? 'Something went wrong';
  }
}
