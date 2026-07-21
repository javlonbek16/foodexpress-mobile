import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/application/auth/login/login_bloc.dart';
import 'package:foodexpress_mobile/application/auth/register/register_bloc.dart';
import 'package:foodexpress_mobile/infrastructure/di/injection_container.dart';
import 'package:foodexpress_mobile/presentation/routes/app_routes.dart';
import 'package:foodexpress_mobile/presentation/pages/auth/login/login_page.dart';
import 'package:foodexpress_mobile/presentation/pages/auth/register/register_page.dart';
import 'package:foodexpress_mobile/presentation/pages/cart/cart_page.dart';
import 'package:foodexpress_mobile/application/restaurant/restaurant_bloc.dart';
import 'package:foodexpress_mobile/presentation/pages/home/home_page.dart';
import 'package:foodexpress_mobile/presentation/pages/home/restaurant_details_page.dart';
import 'package:foodexpress_mobile/presentation/pages/main/main_page.dart';
import 'package:foodexpress_mobile/application/order/order_bloc.dart';
import 'package:foodexpress_mobile/application/order/order_event.dart';
import 'package:foodexpress_mobile/presentation/pages/order/order_page.dart';
import 'package:foodexpress_mobile/presentation/pages/profile/profile_page.dart';
import 'package:foodexpress_mobile/presentation/pages/splash/splash_page.dart';
import 'package:go_router/go_router.dart';

final _routerKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _routerKey,
  initialLocation: AppRoutes.splash.path,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => MainPage(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(name: AppRoutes.home.name, path: AppRoutes.home.path, builder: (context, state) => HomePage()),
          ],
        ),
        StatefulShellBranch(
          routes: [GoRoute(path: AppRoutes.profile.path, builder: (context, state) => ProfilePage())],
        ),
      ],
    ),
    GoRoute(
      name: AppRoutes.splash.name,
      path: AppRoutes.splash.path,
      builder: (context, state) {
        return const SplashPage();
      },
    ),
    GoRoute(
      name: AppRoutes.login.name,
      path: AppRoutes.login.path,
      builder: (context, state) {
        return BlocProvider(create: (context) => sl<LoginBloc>(), child: const LoginPage());
      },
    ),
    GoRoute(
      name: AppRoutes.register.name,
      path: AppRoutes.register.path,
      builder: (context, state) {
        return BlocProvider(create: (context) => sl<RegisterBloc>(), child: const RegisterPage());
      },
    ),
    GoRoute(
      path: AppRoutes.restaurantDetail,
      builder: (context, state) {
        final id = state.pathParameters["id"]!;
        return RestaurantDetailsPage(restaurantId: id);
      },
    ),
    GoRoute(
      name: AppRoutes.cart.name,
      path: AppRoutes.cart.path,
      builder: (context, state) {
        return BlocProvider.value(value: sl<RestaurantBloc>(), child: const CartPage());
      },
    ),
    GoRoute(
      name: AppRoutes.order.name,
      path: AppRoutes.order.path,
      builder: (context, state) {
        return BlocProvider(create: (context) => OrderBloc(sl())..add(LoadOrders()), child: const OrderPage());
      },
    ),
  ],
);
