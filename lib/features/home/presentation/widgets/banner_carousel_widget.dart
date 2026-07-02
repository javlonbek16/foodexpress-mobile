import 'package:flutter/material.dart';
import 'package:foodexpress_mobile/features/home/data/models/banner_model.dart';
import 'package:foodexpress_mobile/features/home/presentation/widgets/banner_card_widget.dart';
import 'package:foodexpress_mobile/features/home/presentation/widgets/banner_indicator_widget.dart';

class BannerCarouselWidget extends StatefulWidget {
  final List<BannerModel> banners;
  final PageController pageController;

  const BannerCarouselWidget({super.key, required this.banners, required this.pageController});

  @override
  State<BannerCarouselWidget> createState() => _BannerCarouselWidgetState();
}

class _BannerCarouselWidgetState extends State<BannerCarouselWidget> {
  final ValueNotifier<int> _currentPage = ValueNotifier(0);

  @override
  void dispose() {
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
            controller: widget.pageController,
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
            return BannerIndicatorWidget(
              pageController: widget.pageController,
              banners: widget.banners,
            );
          },
        ),
      ],
    );
  }
}
