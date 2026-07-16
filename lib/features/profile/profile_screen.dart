import 'package:flutter/material.dart';
import 'package:foodexpress_mobile/core/router/app_routes.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile Screen")),
      body: Column(
        children: [
          ListTile(
            title: const Text("Mening buyurtmalarim"),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => context.push(AppRoutes.order),
          ),
        ],
      ),
    );
  }
}
