class AppRoutes {
  AppRoutes._();

  static const splash = "/splash";
  static const login = "/login";
  static const register = "/register";
  static const home = "/home";
  static const cart = "/cart";
  
  static const restaurantDetail = "/detail/:id";

  static String restaurantDetailPath(String id) => "/detail/$id";
}
