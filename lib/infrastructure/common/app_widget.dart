import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/application/app_manager/app_manager_cubit.dart';
import 'package:foodexpress_mobile/application/app_manager/app_manager_state.dart';
import 'package:foodexpress_mobile/presentation/assets/res/app_colors.dart';
import 'package:foodexpress_mobile/presentation/assets/res/app_text_styles.dart';
import 'package:foodexpress_mobile/presentation/assets/theme/app_theme.dart';
import 'package:foodexpress_mobile/presentation/routes/app_router.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppManagerCubit, AppManagerState>(
      builder: (context, state) {
        if (state is AppManagerLoading) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(body: Center(child: CircularProgressIndicator())),
          );
        } else if (state is AppManagerError) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              backgroundColor: AppColors.scaffold,
              body: Center(
                child: Text(state.error, style: AppTextStyles.bodyMedium, textAlign: TextAlign.center),
              ),
            ),
          );
        } else {
          return MaterialApp.router(
            title: "Food Express",
            theme: appTheme,
            debugShowCheckedModeBanner: false,
            routerConfig: router,
          );
        }
      },
    );
  }
}
