import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/core/utils/app_text_styles.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/restaurant_bloc/restaurant_bloc.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/restaurant_bloc/restaurant_state.dart';
import 'package:foodexpress_mobile/features/home/presentation/widgets/restaurant_widgets/restaurant_card_widget.dart';
import 'package:foodexpress_mobile/features/home/presentation/widgets/restaurant_widgets/restaurants_skleton_widget.dart';

class RestaurantSection extends StatelessWidget {
  const RestaurantSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantBloc, RestaurantState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const RestaurantsSkletonWidget();
        }
        if (state.error != null) {
          return Center(child: Text(state.error.toString()));
        }
        return Column(
          children: [
            const ListTile(
              title: Text("Restoranlar", style: AppTextStyles.h3),
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 10),

            SizedBox(
              height: 300,
              child: state.restaurants.isEmpty
                  ? const Center(
                      child: Text("Restoranlar topilmadi", style: AppTextStyles.titleMedium),
                    )
                  : ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: state.restaurants.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 16),
                      itemBuilder: (context, index) {
                        final restaurant = state.restaurants[index];

                        return RestaurantCardWidget(restaurant: restaurant);
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
}
