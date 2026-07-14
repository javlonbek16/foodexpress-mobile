import 'package:foodexpress_mobile/core/router/app_routes.dart';
import 'package:foodexpress_mobile/features/auth/presentation/screens/login_screen.dart';
import 'package:foodexpress_mobile/features/auth/presentation/screens/register_screen.dart';
import 'package:foodexpress_mobile/features/cart/presentation/screens/cart_screen.dart';
import 'package:foodexpress_mobile/features/home/presentation/screens/home_screen.dart';
import 'package:foodexpress_mobile/features/home/presentation/screens/restaurant_details_screen.dart';
import 'package:foodexpress_mobile/splash_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
      path: AppRoutes.register,
      builder: (context, state) {
        return const RegisterScreen();
      },
    ),
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
      path: AppRoutes.restaurantDetail,
      builder: (context, state) {
        final id = state.pathParameters["id"]!;
        return RestaurantDetailsScreen(restaurantId: id);
      },
    ),
    GoRoute(
      path: AppRoutes.cart,
      builder: (context, state) {
        return const CartScreen();
      },
    ),
  ],
);
