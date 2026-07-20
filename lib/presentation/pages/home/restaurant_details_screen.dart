import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/application/category/category_bloc.dart';
import 'package:foodexpress_mobile/application/category/category_event.dart';
import 'package:foodexpress_mobile/infrastructure/di/injection_container.dart';
import 'package:foodexpress_mobile/presentation/routes/app_routes.dart';
import 'package:foodexpress_mobile/presentation/pages/cart/cart_widgets/cart_fab.dart';
import 'package:foodexpress_mobile/application/restaurant_detail/restaurant_detail_bloc.dart';
import 'package:foodexpress_mobile/application/restaurant_detail/restaurant_detail_event.dart';
import 'package:foodexpress_mobile/application/restaurant_menu/restaurant_menu_bloc.dart';
import 'package:foodexpress_mobile/application/restaurant_menu/restaurant_menu_event.dart';
import 'package:foodexpress_mobile/presentation/pages/home/components/restaurant_widgets/restaurant_detail_section.dart';
import 'package:foodexpress_mobile/presentation/pages/home/components/restaurant_widgets/restaurant_menu_category_widget.dart';
import 'package:foodexpress_mobile/presentation/pages/home/components/restaurant_widgets/restaurant_menu_section.dart';
import 'package:go_router/go_router.dart';

class RestaurantDetailsScreen extends StatelessWidget {
  final String restaurantId;

  const RestaurantDetailsScreen({super.key, required this.restaurantId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<RestaurantDetailBloc>()..add(RestaurantDetailFetched(restaurantId))),
        BlocProvider(create: (context) => sl<RestaurantMenuBloc>()..add(RestaurantMenuFetched(restaurantId))),
        BlocProvider(create: (context) => sl<CategoryBloc>()..add(MenuCategoryFetched(restaurantId))),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text("Details"), surfaceTintColor: Colors.white),
        floatingActionButton: CartFab(
          onPressed: () {
            context.push(AppRoutes.cart.path);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                RestaurantDetailSection(),
                const SizedBox(height: 10),
                RestaurantMenuCategoryWidget(restaurantId: restaurantId),
                const SizedBox(height: 10),
                RestaurantMenuSection(restaurantId: restaurantId),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
