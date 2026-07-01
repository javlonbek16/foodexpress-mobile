import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:foodexpress_mobile/features/auth/presentation/blocs/auth_event.dart';
import 'package:foodexpress_mobile/features/auth/presentation/blocs/auth_state.dart';

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

  String? tempOtpToken;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is OtpSentState) {
          _showOtpDialog(context);
        } else if (state is OtpVerifiedState) {
          Navigator.pop(context);
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
          Navigator.pushReplacementNamed(context, '/home');
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("RO'YXATDAN O'TING!", style: TextStyle(fontSize: 26)),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: nameCtrl,
                      decoration: const InputDecoration(hintText: "Ism"),
                    ),
                    TextFormField(
                      controller: emailCtrl,
                      decoration: const InputDecoration(hintText: "Email"),
                    ),
                    TextFormField(
                      controller: phoneCtrl,
                      decoration: const InputDecoration(hintText: "Telefon raqam"),
                    ),
                    TextFormField(
                      controller: passCtrl,
                      decoration: const InputDecoration(hintText: "Parol"),
                    ),
                    const SizedBox(height: 50),

                    if (state is AuthLoading)
                      const CircularProgressIndicator()
                    else
                      FilledButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(SendOtpEvent(emailCtrl.text));
                        },
                        child: const Text("Kod jo'natish va Ro'yxatdan o'tish"),
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
