import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foodexpress_mobile/core/constants/app_constants.dart';
import 'package:foodexpress_mobile/core/local/secure_storage_service.dart';
import 'package:foodexpress_mobile/core/network/dio_client.dart';
import 'package:foodexpress_mobile/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:foodexpress_mobile/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:foodexpress_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:foodexpress_mobile/features/auth/domain/usecases/auth_use_cases.dart';
import 'package:foodexpress_mobile/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  sl.registerLazySingleton(() => const FlutterSecureStorage());

  sl.registerLazySingleton(() => SecureStorageService(sl()));

  sl.registerLazySingleton<DioClient>(
    () => DioClient(baseUrl: AppConstants.authBaseUrl, storageService: sl()),
    instanceName: 'auth_dio',
  );

  sl.registerLazySingleton<DioClient>(
    () => DioClient(baseUrl: AppConstants.homeBaseUrl, storageService: sl()),
    instanceName: 'home_dio',
  );

  sl.registerLazySingleton(() => AuthRemoteDataSource(sl<DioClient>(instanceName: 'auth_dio')));

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl(), sl()));

  sl.registerLazySingleton(() => AuthUseCases(sl()));

  sl.registerFactory(() => AuthBloc(sl(), sl()));
}
