import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/features/home/domain/repositories/home_repository.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/banner_bloc/banner_event.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/banner_bloc/banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  final HomeRepository repository;
  BannerBloc(this.repository) : super(const BannerState()) {
    on<BannerFetched>(_onFetched);
  }

  Future<void> _onFetched(BannerFetched event, Emitter<BannerState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final banners = await repository.getBanners();

      emit(state.copyWith(isLoading: false, banners: banners));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
