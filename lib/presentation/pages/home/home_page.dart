import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/infrastructure/di/injection_container.dart';
import 'package:foodexpress_mobile/application/banner/banner_bloc.dart';
import 'package:foodexpress_mobile/application/banner/banner_event.dart';
import 'package:foodexpress_mobile/application/category/category_bloc.dart';
import 'package:foodexpress_mobile/application/category/category_event.dart';
import 'package:foodexpress_mobile/application/restaurant/restaurant_bloc.dart';
import 'package:foodexpress_mobile/application/restaurant/restaurant_event.dart';
import 'package:foodexpress_mobile/presentation/pages/home/components/banner_widgets/banner_section.dart';
import 'package:foodexpress_mobile/presentation/pages/home/components/category_widgets/category_section.dart';
import 'package:foodexpress_mobile/presentation/pages/home/components/restaurant_widgets/restaurant_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
