import 'package:dio/dio.dart';
import 'package:foodexpress_mobile/infrastructure/constants/app_endpoints.dart';
import 'package:foodexpress_mobile/infrastructure/network/dio_client.dart';
import 'package:foodexpress_mobile/infrastructure/models/user/user_model.dart';

class AuthApiService {
  final DioClient dioClient;

  AuthApiService(this.dioClient);

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await dioClient.dio.post(AppEndpoints.loginApi, data: {"email": email, "password": password});
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Login qilishda xatolik! \nError: $e");
    }
  }

  Future<void> sendOtp(String email) async {
    try {
      await dioClient.dio.post(AppEndpoints.sentOtpApi, data: {"email": email});
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? "OTP yuborishda xatolik!");
    }
  }

  Future<String> verifyOtp(String email, String code) async {
    try {
      final response = await dioClient.dio.post(AppEndpoints.verifyOtpApi, data: {"email": email, "code": code});
      return response.data["otpToken"];
    } on DioException catch (e) {
      throw Exception("Kodni tasdiqlashda xatolik!-> $e");
    }
  }

  Future<void> register(Map<String, dynamic> data) async {
    try {
      await dioClient.dio.post(AppEndpoints.registerApi, data: data);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Ro'yxatdan o'tishda xatolik!");
    }
  }

  Future<UserModel> getMe() async {
    try {
      final response = await dioClient.dio.get(AppEndpoints.getMeApi, options: Options(extra: {'requiresToken': true}));

      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e);
    }
  }
}
