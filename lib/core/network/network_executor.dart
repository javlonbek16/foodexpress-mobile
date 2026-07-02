import 'package:dio/dio.dart';

import 'network_exception.dart';

class NetworkExecutor {
  static Future<T> execute<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on DioException catch (e, s) {
      print("============== DIO ERROR ==============");
      print("TYPE: ${e.type}");
      print("MESSAGE: ${e.message}");
      print("ERROR: ${e.error}");
      print("STATUS: ${e.response?.statusCode}");
      print("DATA: ${e.response?.data}");
      print("PATH: ${e.requestOptions.path}");
      print("STACK: $s");
      print("=======================================");

      throw NetworkException(_mapError(e));
    }
  }

  static String _mapError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return "Serverga ulanish vaqti tugadi.";

      case DioExceptionType.sendTimeout:
        return "So'rov yuborish vaqti tugadi.";

      case DioExceptionType.receiveTimeout:
        return "Server javobi kechikmoqda.";

      case DioExceptionType.connectionError:
        return "Internet bilan bog'lanib bo'lmadi.";

      case DioExceptionType.cancel:
        return "So'rov bekor qilindi.";

      case DioExceptionType.badCertificate:
        return "SSL sertifikatida xatolik.";

      case DioExceptionType.badResponse:
        return _statusMessage(e.response?.statusCode, e.response?.data);

      case DioExceptionType.unknown:
        return "Noma'lum tarmoq xatoligi.";
      case DioExceptionType.transformTimeout:
        throw UnimplementedError();
    }
  }

  static String _statusMessage(int? statusCode, dynamic data) {
    switch (statusCode) {
      case 400:
        return data?["message"] ?? "Noto'g'ri so'rov.";

      case 401:
        return "Sessiya tugagan.";

      case 403:
        return "Ruxsat yo'q.";

      case 404:
        return "Ma'lumot topilmadi.";

      case 409:
        return data?["message"] ?? "Konflikt.";

      case 422:
        return data?["message"] ?? "Validation xatoligi.";

      case 500:
        return "Serverda xatolik.";

      default:
        return data?["message"] ?? "Noma'lum server xatoligi.";
    }
  }
}
