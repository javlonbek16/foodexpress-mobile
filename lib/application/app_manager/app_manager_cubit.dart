import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/application/app_manager/app_manager_state.dart';

class AppManagerCubit extends Cubit<AppManagerState> {
  AppManagerCubit() : super(AppManagerLoading());

  Future<void> init() async {
    try {
      emit(AppManagerInitial());
    } catch (e) {
      emit(AppManagerError(e.toString()));
    }
  }
}
