import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/application/auth/login/login_bloc.dart';
import 'package:foodexpress_mobile/application/auth/login/login_event.dart';
import 'package:foodexpress_mobile/application/auth/login/login_state.dart';
import 'package:foodexpress_mobile/presentation/routes/app_routes.dart';
import 'package:foodexpress_mobile/presentation/assets/res/app_colors.dart';
import 'package:foodexpress_mobile/application/auth/auth_state.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isObscure = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.failure), backgroundColor: Colors.red));
        } else if (state is Authenticated) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Tizimga muvaffaqiyatli kirdingiz!"), backgroundColor: Colors.green),
          );
          context.push(AppRoutes.home.path);
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
                      decoration: InputDecoration(
                        hintText: "Parolni kiriting ... ",
                        suffixIcon: IconButton(
                          onPressed: () {
                            isObscure = !isObscure;
                            setState(() {});
                          },
                          icon: Icon(isObscure ? Icons.visibility_off : Icons.visibility, color: AppColors.disabled),
                        ),
                      ),
                      obscureText: isObscure,
                    ),
                    const SizedBox(height: 50),

                    if (state is LoginLoading)
                      const CircularProgressIndicator()
                    else
                      FilledButton(
                        onPressed: () {
                          final email = _emailController.text.trim();
                          final password = _passwordController.text.trim();

                          if (email.isNotEmpty && password.isNotEmpty) {
                            context.read<LoginBloc>().add(LoginButtonPressed(email: email, password: password));
                          } else {
                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(const SnackBar(content: Text("Email va parolni to'ldiring!")));
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
