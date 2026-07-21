import 'package:foodexpress_mobile/presentation/routes/app_coordinate.dart';

class AppRoutes implements AppCoordinate {
  const AppRoutes._({required this.name, required this.path});

  final String name;
  final String path;

  static const splash = AppRoutes._(name: "splash", path: "/splash");
  static const login = AppRoutes._(name: "login", path: "/login");
  static const register = AppRoutes._(name: "register", path: "/register");
  static const home = AppRoutes._(name: "home", path: "/home");
  static const cart = AppRoutes._(name: "cart", path: "/cart");
  static const order = AppRoutes._(name: "order", path: "/order");
  static const profile = AppRoutes._(name: "profile", path: "/profile");

  static const restaurantDetail = "/detail/:id";

  static String restaurantDetailPath(String id) => "/detail/$id";
}
