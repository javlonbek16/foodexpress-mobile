import 'package:foodexpress_mobile/infrastructure/models/banner_model/banner_model.dart';

class BannerState {
  final bool isLoading;
  final List<BannerModel> banners;
  final String? error;

  const BannerState({this.isLoading = false, this.banners = const [], this.error});

  BannerState copyWith({bool? isLoading, List<BannerModel>? banners, String? error}) {
    return BannerState(isLoading: isLoading ?? this.isLoading, banners: banners ?? this.banners, error: error);
  }
}
