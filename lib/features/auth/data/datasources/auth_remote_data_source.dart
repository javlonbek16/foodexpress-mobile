import 'package:dio/dio.dart';
import 'package:foodexpress_mobile/core/network/dio_client.dart';
import 'package:foodexpress_mobile/features/auth/data/models/user_model.dart';

class AuthRemoteDataSource {
  final DioClient dioClient;

  AuthRemoteDataSource(this.dioClient);

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await dioClient.dio.post(
        "/auth/login",
        data: {"email": email, "password": password},
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Login qilishda xatolik! \nError: $e");
    }
  }

  Future<void> sendOtp(String email) async {
    try {
      await dioClient.dio.post('/auth/sent-otp', data: {"email": email});
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? "OTP yuborishda xatolik!");
    }
  }

  Future<String> verifyOtp(String email, String code) async {
    try {
      final response = await dioClient.dio.post(
        '/auth/verify-otp',
        data: {"email": email, "code": code},
      );
      return response.data["otpToken"];
    } on DioException catch (e) {
      throw Exception("Kodni tasdiqlashda xatolik!-> $e");
    }
  }

  Future<void> register(Map<String, dynamic> data) async {
    try {
      await dioClient.dio.post('/auth/register', data: data);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Ro'yxatdan o'tishda xatolik!");
    }
  }

  Future<UserModel> getMe() async {
    try {
      final response = await dioClient.dio.get('/auth/me');

      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e);
    }
  }
}
