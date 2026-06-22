class LoginModel {
  final String userId;
  final String role;
  final String accessToken;
  final String refreshToken;

  LoginModel({
    required this.userId,
    required this.role,
    required this.accessToken,
    required this.refreshToken,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      userId: json["user_id"],
      role: json["role"],
      accessToken: json["accessToken"],
      refreshToken: json["refreshToken"],
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {

  //   };
  // }
}
