import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/core/router/app_routes.dart';
import 'package:foodexpress_mobile/core/utils/app_colors.dart';
import 'package:foodexpress_mobile/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:foodexpress_mobile/features/auth/presentation/blocs/auth_event.dart';
import 'package:foodexpress_mobile/features/auth/presentation/blocs/auth_state.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final otpCtrl = TextEditingController();
  final confirmPassCtrl = TextEditingController();
  bool isObscure = true;
  bool isObscureConfirm = true;

  String? tempOtpToken;
  final _formKey = GlobalKey<FormState>();

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Parolni kiriting";
    }
    if (value.length < 8) {
      return "Parol kamida 8ta belgidan iborat bo'lishi kerak";
    }
    return null;
  }

  String? confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Parolni kiriting";
    }

    if (value != passCtrl.text) {
      return "Parol mos kelmadi";
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is OtpSentState) {
          _showOtpDialog(context);
        } else if (state is OtpVerifiedState) {
          context.pop();
          context.read<AuthBloc>().add(
            RegisterEvent(
              name: nameCtrl.text,
              email: emailCtrl.text,
              password: passCtrl.text,
              phone: phoneCtrl.text,
              otpToken: state.otpToken,
            ),
          );
        } else if (state is Authenticated) {
          context.pushReplacement(AppRoutes.home);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "FOOD EXPRESSDA RO'YXATDAN O'TING!",
                        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: nameCtrl,
                        decoration: const InputDecoration(hintText: "Ism kiriting ..."),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: emailCtrl,
                        decoration: const InputDecoration(hintText: "Email kiriting ..."),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: phoneCtrl,
                        decoration: const InputDecoration(hintText: "Telefon raqam kiriting ..."),
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: passCtrl,
                        decoration: InputDecoration(
                          hintText: "Parol kiriting ...",
                          suffixIcon: IconButton(
                            onPressed: () {
                              isObscure = !isObscure;
                              setState(() {});
                            },
                            icon: Icon(
                              isObscure ? Icons.visibility_off : Icons.visibility,
                              color: AppColors.disabled,
                            ),
                          ),
                        ),
                        validator: (value) => passwordValidator(value),

                        obscureText: isObscure,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: confirmPassCtrl,
                        decoration: InputDecoration(
                          hintText: "Parolni tasdiqlash ...",
                          suffixIcon: IconButton(
                            onPressed: () {
                              isObscureConfirm = !isObscureConfirm;
                              setState(() {});
                            },
                            icon: Icon(
                              isObscureConfirm ? Icons.visibility_off : Icons.visibility,
                              color: AppColors.disabled,
                            ),
                          ),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => confirmPasswordValidator(value),
                        obscureText: isObscureConfirm,
                      ),
                      const SizedBox(height: 50),

                      if (state is AuthLoading)
                        const CircularProgressIndicator()
                      else
                        FilledButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(SendOtpEvent(emailCtrl.text));
                            }
                          },
                          child: const Text("Kod jo'natish"),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showOtpDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text("Kodni tasdiqlang"),
        content: TextFormField(
          controller: otpCtrl,
          decoration: const InputDecoration(hintText: "Emailga kelgan kod"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.read<AuthBloc>().add(VerifyOtpEvent(emailCtrl.text, otpCtrl.text));
            },
            child: const Text("Tasdiqlash"),
          ),
        ],
      ),
    );
  }
}
