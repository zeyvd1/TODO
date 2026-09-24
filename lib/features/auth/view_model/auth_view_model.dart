import 'package:dio/dio.dart';
import 'package:nti/core/services/api_endpoints.dart';
import 'package:nti/core/services/dio_client.dart';
import 'package:nti/core/services/token_manager.dart';
import 'package:nti/features/auth/model/user_model.dart';


class AuthViewModel {
  Future<void> register({
    required String username,
    required String password,
    String? imagePath,
  }) async {
    try {
      final formData = FormData.fromMap({
        'username': username,
        'password': password,
        if (imagePath != null)
          'image': await MultipartFile.fromFile(imagePath),
      });
      await DioClient.dio.post(ApiEndpoints.register, data: formData);
    } on DioException catch (e) {
      throw _errorMessage(e);
    }
  }

  Future<void> login({
    required String username,
    required String password,
  }) async {
    try {
      final formData = FormData.fromMap({
        'username': username,
        'password': password,
      });
      final response = await DioClient.dio.post(
        ApiEndpoints.login,
        data: formData,
      );
      final data = response.data as Map<String, dynamic>;
      TokenManager.save(
        access: data['access_token'],
        refresh: data['refresh_token'],
      );
    } on DioException catch (e) {
      throw _errorMessage(e);
    }
  }

  Future<void> refreshAccessToken() async {
    try {
      final response = await DioClient.dio.post(ApiEndpoints.refreshToken);
      final data = response.data as Map<String, dynamic>;
      TokenManager.save(access: data['access_token']);
    } on DioException catch (e) {
      throw _errorMessage(e);
    }
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirm,
  }) async {
    try {
      final formData = FormData.fromMap({
        'current_password': currentPassword,
        'new_password': newPassword,
        'new_password_confirm': newPasswordConfirm,
      });
      await DioClient.dio.post(ApiEndpoints.changePassword, data: formData);
    } on DioException catch (e) {
      throw _errorMessage(e);
    }
  }

  Future<void> updateProfile({String? username, String? imagePath}) async {
    try {
      final formData = FormData.fromMap({
        if (username != null) 'username': username,
        if (imagePath != null)
          'image': await MultipartFile.fromFile(imagePath),
      });
      await DioClient.dio.put(ApiEndpoints.updateProfile, data: formData);
    } on DioException catch (e) {
      throw _errorMessage(e);
    }
  }

  Future<UserModel> getUserData() async {
    try {
      final response = await DioClient.dio.get(ApiEndpoints.getUserData);
      return UserModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _errorMessage(e);
    }
  }

  Future<void> deleteUser() async {
    try {
      await DioClient.dio.delete(ApiEndpoints.deleteUser);
    } on DioException catch (e) {
      throw _errorMessage(e);
    }
  }

  void logout() => TokenManager.clear();

  String _errorMessage(DioException e) {
    final data = e.response?.data;
    if (data is Map && data['message'] != null) return data['message'].toString();
    if (data is Map && data['msg'] != null) return data['msg'].toString();
    return e.message ?? 'Something went wrong';
  }
}
