import 'package:flutter/material.dart';
import 'package:foodexpress_mobile/infrastructure/utils/app_colors.dart';
import 'package:foodexpress_mobile/infrastructure/models/banner_model/banner_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerIndicatorWidget extends StatelessWidget {
  final PageController pageController;
  final List<BannerModel> banners;

  const BannerIndicatorWidget({super.key, required this.pageController, required this.banners});

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: pageController,
      count: banners.length,
      effect: ExpandingDotsEffect(
        activeDotColor: AppColors.primary,
        dotColor: Colors.grey.shade300,
        dotHeight: 8,
        dotWidth: 8,
        expansionFactor: 4,
        spacing: 6,
      ),
      onDotClicked: (index) {
        pageController.animateToPage(index, duration: const Duration(milliseconds: 400), curve: Curves.ease);
      },
    );
  }
}
