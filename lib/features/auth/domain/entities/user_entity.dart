class UserEntity {
  final int id;
  final String email;
  final String name;
  final String role;
  final String? phoneNumber;

  UserEntity({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    this.phoneNumber,
  });
}