import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/presentation/routes/app_routes.dart';
import 'package:foodexpress_mobile/application/auth/auth_bloc.dart';
import 'package:foodexpress_mobile/application/auth/auth_event.dart';
import 'package:foodexpress_mobile/application/auth/auth_state.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<AuthBloc>()..add(AppStarted()),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            print("Home ga o'tishdagi print: ${state.runtimeType}");
            context.pushReplacement(AppRoutes.home.path);
          }

          if (state is Unauthenticated) {
            print("Loginga o'tishdagi print: ${state.runtimeType}");
            context.pushReplacement(AppRoutes.login.path);
          }
        },
        child: const Scaffold(body: Center(child: CircularProgressIndicator())),
      ),
    );
  }
}
