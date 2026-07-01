import 'package:dio/dio.dart';
import 'package:foodexpress_mobile/core/constants/app_constants.dart';
import 'package:foodexpress_mobile/core/local/secure_storage_service.dart';

class DioClient {
  final SecureStorageService storageService;
  final String baseUrl;
  late final Dio _dio;

  DioClient({required this.storageService, required this.baseUrl}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {"Content-Type": "application/json"},
      ),
    );

    _dio.interceptors.add(
      QueuedInterceptorsWrapper(
        onRequest: (options, handler) async {
          final accessToken = await storageService.getAccessToken();

          if (accessToken != null) {
            options.headers["Authorization"] = "Bearer $accessToken";
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            final isRefreshed = await _refreshToken();

            if (isRefreshed) {
              final newAccessToken = await storageService.getAccessToken();
              error.requestOptions.headers["Authorization"] = "Bearer $newAccessToken";

              try {
                final response = await _dio.fetch(error.requestOptions);
                return handler.resolve(response);
              } on DioException catch (e) {
                return handler.next(e);
              }
            } else {
              throw Exception("SESSION_EXPIRED");
            }
          }
          return handler.next(error);
        },
      ),
    );
  }

  Dio get dio => _dio;

  Future<bool> _refreshToken() async {
    try {
      final refreshToken = await storageService.getRefreshToken();
      final String? idString = await storageService.getUserId();

      final int userId = int.tryParse(idString ?? '') ?? 0;

      if (refreshToken == null) return false;

      final refreshDio = Dio(BaseOptions(baseUrl: AppConstants.authBaseUrl));

      final response = await refreshDio.post(
        "/auth/refresh",
        data: {"user_id": userId, "refresh_token": refreshToken},
      );

      if (response.statusCode == 200) {
        final newAccessToken = response.data["access_token"];
        final newRefreshToken = response.data["refresh_token"];

        await storageService.saveAccessToken(newAccessToken);
        await storageService.saveRefreshToken(newRefreshToken);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
