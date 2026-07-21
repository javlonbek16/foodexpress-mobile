import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/presentation/routes/app_routes.dart';
import 'package:foodexpress_mobile/presentation/assets/res/app_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:foodexpress_mobile/application/auth/auth_bloc.dart';
import 'package:foodexpress_mobile/application/auth/auth_event.dart';
import 'package:foodexpress_mobile/application/auth/register/register_bloc.dart';
import 'package:foodexpress_mobile/application/auth/register/register_event.dart';
import 'package:foodexpress_mobile/application/auth/register/register_state.dart';
import 'package:foodexpress_mobile/application/auth/otp/otp_bloc.dart';
import 'package:foodexpress_mobile/application/auth/otp/otp_event.dart';
import 'package:foodexpress_mobile/application/auth/otp/otp_state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final otpCtrl = TextEditingController();
  final confirmPassCtrl = TextEditingController();

  bool isObscure = true;
  bool isObscureConfirm = true;
  final _formKey = GlobalKey<FormState>();

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) return "Parolni kiriting";
    if (value.length < 8) return "Parol kamida 8ta belgidan iborat bo'lishi kerak";
    return null;
  }

  String? confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) return "Parolni kiriting";
    if (value != passCtrl.text) return "Parol mos kelmadi";
    return null;
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    phoneCtrl.dispose();
    passCtrl.dispose();
    otpCtrl.dispose();
    confirmPassCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<OtpBloc, OtpState>(
          listener: (context, state) {
            if (state is OtpFailure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.failure)));
            } else if (state is OtpSentSuccess) {
              _showOtpDialog(context);
            } else if (state is OtpVerifiedSuccess) {
              context.pop();

              context.read<RegisterBloc>().add(
                RegisterButtonPressed(
                  name: nameCtrl.text,
                  email: emailCtrl.text,
                  password: passCtrl.text,
                  phone: phoneCtrl.text,
                  otpToken: state.otpToken,
                ),
              );
            }
          },
        ),

        BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state is RegisterFailure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.failure)));
            } else if (state is RegisterSuccess) {
              context.read<AuthBloc>().add(AuthLoggedIn(state.user));
              context.pushReplacement(AppRoutes.home.path);
            }
          },
        ),
      ],
      child: Scaffold(
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
                          onPressed: () => setState(() => isObscure = !isObscure),
                          icon: Icon(isObscure ? Icons.visibility_off : Icons.visibility, color: AppColors.disabled),
                        ),
                      ),
                      validator: passwordValidator,
                      obscureText: isObscure,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: confirmPassCtrl,
                      decoration: InputDecoration(
                        hintText: "Parolni tasdiqlash ...",
                        suffixIcon: IconButton(
                          onPressed: () => setState(() => isObscureConfirm = !isObscureConfirm),
                          icon: Icon(
                            isObscureConfirm ? Icons.visibility_off : Icons.visibility,
                            color: AppColors.disabled,
                          ),
                        ),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: confirmPasswordValidator,
                      obscureText: isObscureConfirm,
                    ),
                    const SizedBox(height: 50),

                    BlocBuilder<OtpBloc, OtpState>(
                      builder: (context, otpState) {
                        return BlocBuilder<RegisterBloc, RegisterState>(
                          builder: (context, registerState) {
                            final isLoading = otpState is OtpLoading || registerState is RegisterLoading;

                            if (isLoading) {
                              return const CircularProgressIndicator();
                            }

                            return FilledButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<OtpBloc>().add(SendOtpEvent(emailCtrl.text));
                                }
                              },
                              child: const Text("Kod jo'natish"),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
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
              context.read<OtpBloc>().add(VerifyOtpEvent(email: emailCtrl.text, code: otpCtrl.text));
            },
            child: const Text("Tasdiqlash"),
          ),
        ],
      ),
    );
  }
}
