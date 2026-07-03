import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/restaurant_bloc/restaurant_bloc.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/restaurant_bloc/restaurant_state.dart';
import 'package:foodexpress_mobile/features/home/presentation/widgets/restaurant_widgets/restaurant_card_widget.dart';

class RestaurantSection extends StatelessWidget {
  const RestaurantSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantBloc, RestaurantState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const CircularProgressIndicator();
        }
        if (state.error != null) {
          return Center(child: Text(state.error.toString()));
        }
        return Column(
          children: [
            const ListTile(
              title: Text(
                "Restoranlar",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              // trailing: Icon(Icons.arrow_forward_ios),
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 10),

            SizedBox(
              height: 300,
              child: state.restaurants.isEmpty
                  ? const Center(child: Text("Restoranlar topilmadi"))
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
