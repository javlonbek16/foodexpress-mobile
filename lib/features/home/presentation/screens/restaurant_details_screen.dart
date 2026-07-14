import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/core/di/injection_container.dart';
import 'package:foodexpress_mobile/core/router/app_routes.dart';
import 'package:foodexpress_mobile/features/cart/presentation/widgets/cart_fab.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/restaurant_detail_bloc/restaurant_detail_bloc.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/restaurant_detail_bloc/restaurant_detail_event.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/restaurant_menu_bloc/restaurant_menu_bloc.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/restaurant_menu_bloc/restaurant_menu_event.dart';
import 'package:foodexpress_mobile/features/home/presentation/widgets/restaurant_widgets/restaurant_detail_section.dart';
import 'package:foodexpress_mobile/features/home/presentation/widgets/restaurant_widgets/restaurant_menu_category_widget.dart';
import 'package:foodexpress_mobile/features/home/presentation/widgets/restaurant_widgets/restaurant_menu_section.dart';
import 'package:go_router/go_router.dart';

class RestaurantDetailsScreen extends StatelessWidget {
  final String restaurantId;
  const RestaurantDetailsScreen({super.key, required this.restaurantId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              sl<RestaurantDetailBloc>()..add(RestaurantDetailFetched(restaurantId)),
        ),
        BlocProvider(
          create: (context) => sl<RestaurantMenuBloc>()..add(RestaurantMenuFetched(restaurantId)),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text("Details"), surfaceTintColor: Colors.white),
        floatingActionButton: CartFab(
          onPressed: () {
            context.push(AppRoutes.cart);
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
