import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/application/banner/banner_bloc.dart';
import 'package:foodexpress_mobile/application/banner/banner_state.dart';
import 'package:foodexpress_mobile/presentation/pages/home/components/banner_widgets/banner_carousel_widget.dart';
import 'package:foodexpress_mobile/presentation/pages/home/components/banner_widgets/banner_skleton_widget.dart';

class BannerSection extends StatelessWidget {
  const BannerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannerBloc, BannerState>(
      builder: (_, state) {
        if (state.isLoading) {
          return const BannerSkeletonWidget();
        }
        if (state.error != null) {
          return Center(child: Text(state.error.toString()));
        }

        return BannerCarouselWidget(banners: state.banners);
      },
    );
  }
}
