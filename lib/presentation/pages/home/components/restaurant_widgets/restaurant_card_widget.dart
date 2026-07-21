import 'package:flutter/material.dart';
import 'package:foodexpress_mobile/presentation/routes/app_routes.dart';
import 'package:foodexpress_mobile/presentation/assets/res/app_colors.dart';
import 'package:foodexpress_mobile/presentation/assets/res/app_text_styles.dart';
import 'package:foodexpress_mobile/infrastructure/models/restaurant/restaurant_model.dart';
import 'package:foodexpress_mobile/presentation/pages/home/components/image_widget.dart';
import 'package:go_router/go_router.dart';

class RestaurantCardWidget extends StatelessWidget {
  final RestaurantModel restaurant;

  const RestaurantCardWidget({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () {
        context.push(AppRoutes.restaurantDetailPath(restaurant.restaurantId));
      },
      child: Container(
        width: 285,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: ImageWidget(image: restaurant.restaurantImage),
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.restaurantName,
                    ),

                    const SizedBox(height: 8),

                    Text(
                      restaurant.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.restaurantInfo,
                    ),

                    const Spacer(),

                    Row(
                      children: [
                        Text("Menyuni ko'rish", style: AppTextStyles.titleSmall.copyWith(color: AppColors.primary)),
                        const SizedBox(width: 4),
                        Icon(Icons.arrow_forward_rounded, size: 18, color: Theme.of(context).colorScheme.primary),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
