import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:foodexpress_mobile/features/auth/presentation/blocs/auth_event.dart';
import 'package:foodexpress_mobile/features/auth/presentation/blocs/auth_state.dart';
import 'package:foodexpress_mobile/features/auth/presentation/screens/login_screen.dart';
import 'package:foodexpress_mobile/features/home/presentation/screens/home_screen.dart';

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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
            );
          }

          if (state is Unauthenticated) {
            print("Loginga o'tishdagi print: ${state.runtimeType}");
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
            );
          }
        },
        child: const Scaffold(body: Center(child: CircularProgressIndicator())),
      ),
    );
  }
}
