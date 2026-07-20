import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/application/app_manager/app_manager_cubit.dart';
import 'package:foodexpress_mobile/infrastructure/common/app_init.dart';
import 'package:foodexpress_mobile/infrastructure/common/app_widget.dart';
import 'package:foodexpress_mobile/infrastructure/common/restart_widget.dart';
import 'package:foodexpress_mobile/infrastructure/di/injection_container.dart';
import 'package:foodexpress_mobile/application/auth/auth_bloc.dart';
import 'package:foodexpress_mobile/application/cart/cart_bloc.dart';
import 'package:foodexpress_mobile/application/cart/cart_event.dart';
import 'package:foodexpress_mobile/application/restaurant/restaurant_bloc.dart';
import 'package:foodexpress_mobile/application/order/order_bloc.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  await runZonedGuarded(
    () async {
      await initializeApp();
      runApp(RestartWidget(child: MyApp()));
    },
    (error, stack) {
      debugPrint("Global error: $error\nStack trace: $stack");
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => sl<AuthBloc>())],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthBloc(sl(), sl())),
          BlocProvider<AppManagerCubit>(create: (context) => AppManagerCubit()..init()),
          BlocProvider(create: (context) => sl<RestaurantBloc>()),
          BlocProvider(create: (context) => sl<CartBloc>()..add(CartLoadRequested())),
          BlocProvider(create: (context) => sl<OrderBloc>()),
        ],
        child: const AppWidget(),
      ),
    );
  }
}

class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    debugPrint('${bloc.runtimeType}: $event');
    super.onEvent(bloc, event);
  }
}
