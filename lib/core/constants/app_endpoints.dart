class AppEndpoints {
  //auth endpoints
  static const String loginApi = "/auth/login";
  static const String sentOtpApi = "/auth/sent-otp";
  static const String verifyOtpApi = "/auth/verify-otp";
  static const String registerApi = "/auth/register";
  static const String getMeApi = "/auth/me";

  //banner endpoint
  static const String bannerApi = "/api/ads";

  //category endpoints
  static const String generalCategoryApi = "/api/general-category";
  static String menuCategoryApi(String restaurantId) =>
      "/api/restaurants/$restaurantId/menucategory";

  //restaurant endpoints
  static const String restaurantsApi = "/api/restaurants";
  static String restaurantByIdApi(String id) => "/api/restaurant/$id";
  static String restaurantByCategoryApi(String categoryName) =>
      "/api/category/restaurants/$categoryName";

  //restaurant menu item endpoints
  static const String menuItemsApi = "/api/menu-items";
  static String menuItemsByRestaurantApi(String id) => "/api/restaurants/$id/menu";
  static String menuItemsByCategoryApi(String restaurantId, String categoryName) =>
      "/api/restaurants/$restaurantId/menu_categories/$categoryName/items";

  //order endpoints
  static const String orderApi = "/orders";
  static String orderByIdApi(String id) => "/orders/$id";
}
