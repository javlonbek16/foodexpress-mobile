import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:foodexpress_mobile/features/auth/presentation/blocs/auth_event.dart';
import 'package:foodexpress_mobile/features/auth/presentation/blocs/auth_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message), backgroundColor: Colors.red));
        } else if (state is Authenticated) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Tizimga muvaffaqiyatli kirdingiz!"),
              backgroundColor: Colors.green,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "FOOD EXPRESSGA KIRING!",
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 50),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(hintText: "Email kiriting ... "),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(hintText: "Parolni kiriting ... "),
                      obscureText: true,
                    ),
                    const SizedBox(height: 50),

                    if (state is AuthLoading)
                      const CircularProgressIndicator()
                    else
                      FilledButton(
                        onPressed: () {
                          final email = _emailController.text.trim();
                          final password = _passwordController.text.trim();

                          if (email.isNotEmpty && password.isNotEmpty) {
                            context.read<AuthBloc>().add(LoginEvent(email, password));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Email va parolni to'ldiring!")),
                            );
                          }
                        },
                        style: FilledButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
                        child: const Text("Kirish", style: TextStyle(fontSize: 18)),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
