import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract final class AppConstants {
  static final authBaseUrl = dotenv.env["AUTH_BASE_URL"]!;
  static final homeBaseUrl = dotenv.env["HOME_BASE_URL"]!;
  static final orderBaseUrl = dotenv.env["ORDER_BASE_URL"]!;
}
