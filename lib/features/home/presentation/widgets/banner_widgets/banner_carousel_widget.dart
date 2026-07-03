import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foodexpress_mobile/features/home/data/models/banner_model.dart';
import 'package:foodexpress_mobile/features/home/presentation/widgets/banner_widgets/banner_card_widget.dart';
import 'package:foodexpress_mobile/features/home/presentation/widgets/banner_widgets/banner_indicator_widget.dart';

class BannerCarouselWidget extends StatefulWidget {
  final List<BannerModel> banners;

  const BannerCarouselWidget({super.key, required this.banners});

  @override
  State<BannerCarouselWidget> createState() => _BannerCarouselWidgetState();
}

class _BannerCarouselWidgetState extends State<BannerCarouselWidget> {
  late final PageController pageController;
  late final Timer _timer;

  final ValueNotifier<int> _currentPage = ValueNotifier(0);

  @override
  void initState() {
    super.initState();

    pageController = PageController(viewportFraction: 0.96);
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (!pageController.hasClients || widget.banners.isEmpty) return;

      _currentPage.value++;

      if (_currentPage.value >= widget.banners.length) {
        _currentPage.value = 0;
      }

      pageController.animateToPage(
        _currentPage.value,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    pageController.dispose();
    _currentPage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            clipBehavior: Clip.none,
            controller: pageController,
            itemCount: widget.banners.length,
            onPageChanged: (index) => _currentPage.value = index,
            itemBuilder: (_, index) {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: BannerCardWidget(banner: widget.banners[index]),
              );
            },
          ),
        ),
        const SizedBox(height: 14),
        ValueListenableBuilder<int>(
          valueListenable: _currentPage,
          builder: (_, currentPage, _) {
            return BannerIndicatorWidget(pageController: pageController, banners: widget.banners);
          },
        ),
      ],
    );
  }
}
