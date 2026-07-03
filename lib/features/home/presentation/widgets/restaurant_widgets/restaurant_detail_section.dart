import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/restaurant_detail_bloc/restaurant_detail_bloc.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/restaurant_detail_bloc/restaurant_detail_state.dart';
import 'package:foodexpress_mobile/features/home/presentation/widgets/image_widget.dart';

class RestaurantDetailSection extends StatelessWidget {
  const RestaurantDetailSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantDetailBloc, RestaurantDetailState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.error != null) {
          return Center(child: Text(state.error!));
        }

        if (state.restaurant == null) {
          return const SizedBox();
        }
        final restaurant = state.restaurant!;
        return Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                width: double.infinity,
                height: 220,
                child: ImageWidget(image: restaurant.restaurantImage),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(
                    restaurant.name,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.star, size: 18, color: Colors.orange),
                      SizedBox(width: 4),
                      Text("4.8"),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            Text(
              restaurant.description,
              style: TextStyle(color: Colors.grey.shade600, height: 1.5),
            ),
            const SizedBox(height: 25),
          ],
        );
      },
    );
  }
}
