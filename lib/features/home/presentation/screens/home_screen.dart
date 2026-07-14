import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/core/di/injection_container.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/banner_bloc/banner_bloc.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/banner_bloc/banner_event.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/general_category_bloc/category_bloc.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/general_category_bloc/category_event.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/restaurant_bloc/restaurant_bloc.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/restaurant_bloc/restaurant_event.dart';
import 'package:foodexpress_mobile/features/home/presentation/widgets/banner_widgets/banner_section.dart';
import 'package:foodexpress_mobile/features/home/presentation/widgets/category_widgets/category_section.dart';
import 'package:foodexpress_mobile/features/home/presentation/widgets/restaurant_widgets/restaurant_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<BannerBloc>()..add(BannerFetched())),
        BlocProvider(create: (context) => sl<CategoryBloc>()..add(CategoryFetched())),
        BlocProvider(create: (context) => sl<RestaurantBloc>()..add(RestaurantFetched())),
      ],
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("FOOD EXPRESS"),
          centerTitle: true,
          surfaceTintColor: Colors.white,
        ),

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BannerSection(),
                const SizedBox(height: 20),
                CategorySection(),
                const SizedBox(height: 20),
                RestaurantSection(),
                SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
