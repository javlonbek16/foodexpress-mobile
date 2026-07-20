import 'package:dio/dio.dart';
import 'package:foodexpress_mobile/domain/failure/app_failures.dart';
import 'package:fpdart/fpdart.dart';

class NetworkExecutor {
  const NetworkExecutor._();

  static Future<Either<AppFailures, T>> execute<T>(Future<T> Function() request) async {
    try {
      final result = await request();
      return right(result);
    } on DioException catch (e, stackTrace) {
      _logError(e, stackTrace);
      return left(_mapFailure(e));
    } catch (e) {
      return left(UnknownFailure(e.toString()));
    }
  }

  static AppFailures _mapFailure(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeoutFailure("So'rov vaqti tugadi.");

      case DioExceptionType.connectionError:
        return const NoInternetFailure("Internet bilan bog'lanib bo'lmadi.");

      case DioExceptionType.badCertificate:
        return const ServerFailure("SSL sertifikatida xatolik.");

      case DioExceptionType.cancel:
        return const UnknownFailure("So'rov bekor qilindi.");

      case DioExceptionType.badResponse:
        return _mapStatusCode(e.response?.statusCode, e.response?.data);

      case DioExceptionType.unknown:
      case DioExceptionType.transformTimeout:
        return const UnknownFailure("Noma'lum xatolik yuz berdi.");
    }
  }

  static AppFailures _mapStatusCode(int? statusCode, dynamic data) {
    final message = data is Map<String, dynamic> ? data["message"]?.toString() : null;

    switch (statusCode) {
      case 400:
        return ValidationFailure(message ?? "Noto'g'ri so'rov.");

      case 401:
        return const UnauthorizedFailure("Sessiya tugagan.");

      case 403:
        return const UnauthorizedFailure("Ruxsat yo'q.");

      case 404:
        return ServerFailure(message ?? "Ma'lumot topilmadi.");

      case 409:
        return ValidationFailure(message ?? "Konflikt yuz berdi.");

      case 422:
        return ValidationFailure(message ?? "Validation xatoligi.");

      case 500:
      case 502:
      case 503:
        return const ServerFailure("Serverda xatolik.");

      default:
        return ServerFailure(message ?? "Noma'lum server xatoligi.");
    }
  }

  static void _logError(DioException e, StackTrace stackTrace) {
    print("============== DIO ERROR ==============");
    print("TYPE: ${e.type}");
    print("STATUS: ${e.response?.statusCode}");
    print("MESSAGE: ${e.message}");
    print("DATA: ${e.response?.data}");
    print("PATH: ${e.requestOptions.path}");
    print(stackTrace);
    print("=======================================");
  }
}
