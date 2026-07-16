import 'package:flutter/material.dart';
import 'package:foodexpress_mobile/core/router/app_routes.dart';
import 'package:go_router/go_router.dart';

class DialogsWidget {
  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 16),
              Text("Buyurtma yuborilmoqda..."),
            ],
          ),
        );
      },
    );
  }

  static void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.check_circle, color: Colors.green, size: 70),
              SizedBox(height: 16),
              Text("Buyurtma muvaffaqiyatli yaratildi!"),
            ],
          ),
        );
      },
    );

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context, rootNavigator: true).pop();

      context.go(AppRoutes.order);
    });
  }
}
