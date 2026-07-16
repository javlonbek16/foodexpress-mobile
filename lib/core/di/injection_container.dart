import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foodexpress_mobile/core/constants/app_constants.dart';
import 'package:foodexpress_mobile/core/local/secure_storage_service.dart';
import 'package:foodexpress_mobile/core/network/dio_client.dart';
import 'package:foodexpress_mobile/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:foodexpress_mobile/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:foodexpress_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:foodexpress_mobile/features/auth/domain/usecases/auth_use_cases.dart';
import 'package:foodexpress_mobile/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:foodexpress_mobile/features/cart/data/datasources/cart_local_datasource.dart';
import 'package:foodexpress_mobile/features/cart/data/datasources/cart_local_datasource_impl.dart';
import 'package:foodexpress_mobile/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:foodexpress_mobile/features/cart/domain/repositories/cart_repository.dart';
import 'package:foodexpress_mobile/features/cart/presentation/blocs/cart_bloc/cart_bloc.dart';
import 'package:foodexpress_mobile/features/home/data/datasources/home_remote_data_source.dart';
import 'package:foodexpress_mobile/features/home/data/repositories/home_repository_impl.dart';
import 'package:foodexpress_mobile/features/home/domain/repositories/home_repository.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/banner_bloc/banner_bloc.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/general_category_bloc/category_bloc.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/restaurant_bloc/restaurant_bloc.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/restaurant_detail_bloc/restaurant_detail_bloc.dart';
import 'package:foodexpress_mobile/features/home/presentation/blocs/restaurant_menu_bloc/restaurant_menu_bloc.dart';
import 'package:foodexpress_mobile/features/order/data/datasources/order_remote_datasource.dart';
import 'package:foodexpress_mobile/features/order/data/repositories/order_repository_impl.dart';
import 'package:foodexpress_mobile/features/order/domain/repositories/order_repository.dart';
import 'package:foodexpress_mobile/features/order/presentation/blocs/order_bloc/order_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  final prefs = await SharedPreferences.getInstance();

  //packages
  sl.registerLazySingleton(() => const FlutterSecureStorage());
  sl.registerLazySingleton(() => SecureStorageService(sl()));
  sl.registerLazySingleton(() => prefs);

  //dio
  sl.registerLazySingleton<DioClient>(
    () => DioClient(baseUrl: AppConstants.authBaseUrl, storageService: sl()),
    instanceName: 'auth_dio',
  );
  sl.registerLazySingleton<DioClient>(
    () => DioClient(baseUrl: AppConstants.homeBaseUrl, storageService: sl()),
    instanceName: 'home_dio',
  );
  sl.registerLazySingleton<DioClient>(
    () => DioClient(baseUrl: AppConstants.orderBaseUrl, storageService: sl()),
    instanceName: 'order_dio',
  );

  //datasources
  sl.registerLazySingleton(() => AuthRemoteDataSource(sl<DioClient>(instanceName: 'auth_dio')));
  sl.registerLazySingleton(() => HomeRemoteDataSource(sl<DioClient>(instanceName: "home_dio")));
  sl.registerLazySingleton<CartLocalDatasource>(() => CartLocalDatasourceImpl(sl()));
  sl.registerLazySingleton<CartLocalDatasourceImpl>(() => CartLocalDatasourceImpl(sl()));
  sl.registerLazySingleton(() => OrderRemoteDatasource(sl<DioClient>(instanceName: "order_dio")));

  //repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(sl<HomeRemoteDataSource>()));
  sl.registerLazySingleton<CartRepository>(() => CartRepositoryImpl(sl()));
  sl.registerLazySingleton<OrderRepository>(() => OrderRepositoryImpl(sl()));

  //usecases
  sl.registerLazySingleton(() => AuthUseCases(sl()));

  //blocs
  sl.registerFactory(() => AuthBloc(sl(), sl()));
  sl.registerFactory(() => BannerBloc(sl()));
  sl.registerFactory(() => CategoryBloc(sl()));
  sl.registerFactory(() => RestaurantBloc(sl()));
  sl.registerFactory(() => RestaurantDetailBloc(sl()));
  sl.registerFactory(() => RestaurantMenuBloc(sl()));
  sl.registerFactory(() => CartBloc(sl()));
  sl.registerFactory(() => OrderBloc(sl()));
}
