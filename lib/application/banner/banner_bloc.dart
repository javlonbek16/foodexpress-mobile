import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/domain/services/banner/repository/banner_repository.dart';
import 'package:foodexpress_mobile/application/banner/banner_event.dart';
import 'package:foodexpress_mobile/application/banner/banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  final BannerRepository repository;

  BannerBloc(this.repository) : super(const BannerState()) {
    on<BannerFetched>(_onFetched);
  }

  Future<void> _onFetched(BannerFetched event, Emitter<BannerState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final result = await repository.getBanners();
      result.fold(
        (error) => emit(state.copyWith(isLoading: false, error: error.message)),
        (banners) => emit(state.copyWith(isLoading: false, banners: banners)),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
