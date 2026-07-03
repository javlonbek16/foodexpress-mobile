import 'package:flutter/material.dart';
import 'package:foodexpress_mobile/features/home/data/models/banner_model.dart';
import 'package:foodexpress_mobile/features/home/presentation/widgets/image_widget.dart';

class BannerCardWidget extends StatelessWidget {
  final BannerModel banner;
  const BannerCardWidget({super.key, required this.banner});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: ImageWidget(image: banner.imageUrl),
    );
  }
}
