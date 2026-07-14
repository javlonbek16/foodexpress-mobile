import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/core/router/app_routes.dart';
import 'package:foodexpress_mobile/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:foodexpress_mobile/features/auth/presentation/blocs/auth_event.dart';
import 'package:foodexpress_mobile/features/auth/presentation/blocs/auth_state.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<AuthBloc>()..add(AppStarted()),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            print("Home ga o'tishdagi print: ${state.runtimeType}");
            context.pushReplacement(AppRoutes.home);
          }

          if (state is Unauthenticated) {
            print("Loginga o'tishdagi print: ${state.runtimeType}");
            context.pushReplacement(AppRoutes.login);
          }
        },
        child: const Scaffold(body: Center(child: CircularProgressIndicator())),
      ),
    );
  }
}
