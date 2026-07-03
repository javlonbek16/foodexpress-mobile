import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/banner_bloc/banner_bloc.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/banner_bloc/banner_state.dart';
import 'package:foodexpress_mobile/features/home/presentation/widgets/banner_widgets/banner_carousel_widget.dart';

class BannerSection extends StatelessWidget {
  const BannerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannerBloc, BannerState>(
      builder: (_, state) {
        if (state.isLoading) {
          return const CircularProgressIndicator();
        }
        if (state.error != null) {
          return Center(child: Text(state.error.toString()));
        }

        return BannerCarouselWidget(banners: state.banners);
      },
    );
  }
}
