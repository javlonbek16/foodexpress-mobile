import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/core/di/injection_container.dart';
import 'package:foodexpress_mobile/core/router/app_routes.dart';
import 'package:foodexpress_mobile/features/auth/presentation/screens/login_screen.dart';
import 'package:foodexpress_mobile/features/auth/presentation/screens/register_screen.dart';
import 'package:foodexpress_mobile/features/cart/presentation/screens/cart_screen.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/restaurant_bloc/restaurant_bloc.dart';
import 'package:foodexpress_mobile/features/home/presentation/screens/home_screen.dart';
import 'package:foodexpress_mobile/features/home/presentation/screens/restaurant_details_screen.dart';
import 'package:foodexpress_mobile/features/main/main_screen.dart';
import 'package:foodexpress_mobile/features/order/presentation/blocs/order_bloc/order_bloc.dart';
import 'package:foodexpress_mobile/features/order/presentation/blocs/order_bloc/order_event.dart';
import 'package:foodexpress_mobile/features/order/presentation/screens/orders_screen.dart';
import 'package:foodexpress_mobile/features/profile/profile_screen.dart';
import 'package:foodexpress_mobile/splash_screen.dart';
import 'package:go_router/go_router.dart';

final _routerKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _routerKey,
  initialLocation: AppRoutes.splash,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => MainScreen(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [GoRoute(path: AppRoutes.home, builder: (context, state) => HomeScreen())],
        ),
        StatefulShellBranch(
          routes: [GoRoute(path: AppRoutes.profile, builder: (context, state) => ProfileScreen())],
        ),
      ],
    ),
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
      path: AppRoutes.restaurantDetail,
      builder: (context, state) {
        final id = state.pathParameters["id"]!;
        return RestaurantDetailsScreen(restaurantId: id);
      },
    ),
    GoRoute(
      path: AppRoutes.cart,
      builder: (context, state) {
        return BlocProvider.value(value: sl<RestaurantBloc>(), child: const CartScreen());
      },
    ),
    GoRoute(
      path: AppRoutes.order,
      builder: (context, state) {
        return BlocProvider(
          create: (context) => OrderBloc(sl())..add(LoadOrders()),
          child: const OrdersScreen(),
        );
      },
    ),
  ],
);
