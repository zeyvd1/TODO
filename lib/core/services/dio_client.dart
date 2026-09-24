import 'package:dio/dio.dart';
import 'package:nti/core/services/token_manager.dart';


const String kBaseUrl = 'https://ntitodo-production-cddf.up.railway.app/api/';

class DioClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: kBaseUrl
      )
      )
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = TokenManager.accessToken;
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
      ),
    );
}
