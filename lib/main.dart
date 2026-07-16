import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:foodexpress_mobile/core/di/injection_container.dart';
import 'package:foodexpress_mobile/core/router/app_router.dart';
import 'package:foodexpress_mobile/core/utils/app_themes.dart';
import 'package:foodexpress_mobile/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:foodexpress_mobile/features/cart/presentation/blocs/cart_bloc/cart_bloc.dart';
import 'package:foodexpress_mobile/features/cart/presentation/blocs/cart_bloc/cart_event.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/restaurant_bloc/restaurant_bloc.dart';
import 'package:foodexpress_mobile/features/order/presentation/blocs/order_bloc/order_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  await dotenv.load(fileName: ".env");
  // Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => sl<AuthBloc>())],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sl<RestaurantBloc>()),
          BlocProvider(create: (context) => sl<CartBloc>()..add(CartLoadRequested())),
          BlocProvider(create: (context) => sl<OrderBloc>()),
        ],
        child: MaterialApp.router(
          routerConfig: router,
          debugShowCheckedModeBanner: false,
          title: "Food Express",
          theme: appTheme,
        ),
      ),
    );
  }
}

class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    print('${bloc.runtimeType}: $event');
    super.onEvent(bloc, event);
  }
}
