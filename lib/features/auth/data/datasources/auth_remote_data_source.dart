import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthRemoteDataSource {
  final String baseUrl = "http://13.63.45.70:3001/";

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Login qilishda xatolik!");
    }
  }

  Future<Map<String, dynamic>> register(
    String name,
    String email,
    String password,
    int roleId,
    String otpToken,
  ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
        "role_id": roleId,
        "otpToken": otpToken,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Register qilishda xatolik!");
    }
  }
}
