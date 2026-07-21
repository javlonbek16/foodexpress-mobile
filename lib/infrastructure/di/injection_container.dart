import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foodexpress_mobile/application/auth/login/login_bloc.dart';
import 'package:foodexpress_mobile/application/auth/otp/otp_bloc.dart';
import 'package:foodexpress_mobile/application/auth/register/register_bloc.dart';
import 'package:foodexpress_mobile/infrastructure/constants/app_constants.dart';
import 'package:foodexpress_mobile/domain/services/banner/banner_api_service.dart';
import 'package:foodexpress_mobile/domain/services/banner/repository/banner_repository.dart';
import 'package:foodexpress_mobile/domain/services/banner/repository/banner_repository_impl.dart';
import 'package:foodexpress_mobile/domain/services/category/category_api_service.dart';
import 'package:foodexpress_mobile/domain/services/category/repository/category_repository.dart';
import 'package:foodexpress_mobile/domain/services/category/repository/category_repository_impl.dart';
import 'package:foodexpress_mobile/domain/services/restaurant/repository/restaurant_repository.dart';
import 'package:foodexpress_mobile/domain/services/restaurant/repository/restaurant_repository_impl.dart';
import 'package:foodexpress_mobile/domain/services/restaurant/restaurant_api_service.dart';
import 'package:foodexpress_mobile/domain/services/restaurant_menu/repository/restaurant_menu_repository.dart';
import 'package:foodexpress_mobile/domain/services/restaurant_menu/repository/restaurant_menu_repository_impl.dart';
import 'package:foodexpress_mobile/domain/services/restaurant_menu/restaurant_menu_api_service.dart';
import 'package:foodexpress_mobile/infrastructure/datasource/local/secure_storage_service.dart';
import 'package:foodexpress_mobile/infrastructure/network/dio_client.dart';
import 'package:foodexpress_mobile/domain/services/auth/auth_api_service.dart';
import 'package:foodexpress_mobile/domain/services/auth/repository/auth_repository_impl.dart';
import 'package:foodexpress_mobile/domain/services/auth/repository/auth_repository.dart';
import 'package:foodexpress_mobile/domain/use_cases/auth_use_cases.dart';
import 'package:foodexpress_mobile/application/auth/auth_bloc.dart';
import 'package:foodexpress_mobile/domain/services/cart/cart_local_datasource.dart';
import 'package:foodexpress_mobile/domain/services/cart/cart_local_datasource_impl.dart';
import 'package:foodexpress_mobile/domain/services/cart/repository/cart_repository_impl.dart';
import 'package:foodexpress_mobile/domain/services/cart/repository/cart_repository.dart';
import 'package:foodexpress_mobile/application/cart/cart_bloc.dart';
import 'package:foodexpress_mobile/application/banner/banner_bloc.dart';
import 'package:foodexpress_mobile/application/category/category_bloc.dart';
import 'package:foodexpress_mobile/application/restaurant/restaurant_bloc.dart';
import 'package:foodexpress_mobile/application/restaurant_detail/restaurant_detail_bloc.dart';
import 'package:foodexpress_mobile/application/restaurant_menu/restaurant_menu_bloc.dart';
import 'package:foodexpress_mobile/domain/services/order/order_api_service.dart';
import 'package:foodexpress_mobile/domain/services/order/repository/order_repository_impl.dart';
import 'package:foodexpress_mobile/domain/services/order/repository/order_repository.dart';
import 'package:foodexpress_mobile/application/order/order_bloc.dart';
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
  sl.registerLazySingleton(() => AuthApiService(sl<DioClient>(instanceName: 'auth_dio')));
  sl.registerLazySingleton(() => BannerApiService(sl<DioClient>(instanceName: "home_dio")));
  sl.registerLazySingleton(() => CategoryApiService(sl<DioClient>(instanceName: "home_dio")));
  sl.registerLazySingleton(() => RestaurantApiService(sl<DioClient>(instanceName: "home_dio")));
  sl.registerLazySingleton(() => RestaurantMenuApiService(sl<DioClient>(instanceName: "home_dio")));
  sl.registerLazySingleton<CartLocalDatasource>(() => CartLocalDatasourceImpl(sl()));
  sl.registerLazySingleton<CartLocalDatasourceImpl>(() => CartLocalDatasourceImpl(sl()));
  sl.registerLazySingleton(() => OrderApiService(sl<DioClient>(instanceName: "order_dio")));

  //repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<BannerRepository>(() => BannerRepositoryImpl(sl()));
  sl.registerLazySingleton<CategoryRepository>(() => CategoryRepositoryImpl(sl()));
  sl.registerLazySingleton<RestaurantRepository>(() => RestaurantRepositoryImpl(sl()));
  sl.registerLazySingleton<RestaurantMenuRepository>(() => RestaurantMenuRepositoryImpl(sl()));
  sl.registerLazySingleton<CartRepository>(() => CartRepositoryImpl(sl()));
  sl.registerLazySingleton<OrderRepository>(() => OrderRepositoryImpl(sl()));

  //usecases
  sl.registerLazySingleton(() => AuthUseCases(sl()));

  //blocs
  sl.registerFactory(() => AuthBloc(sl(), sl()));
  sl.registerFactory(() => LoginBloc(sl()));
  sl.registerFactory(() => RegisterBloc(sl()));
  sl.registerFactory(() => OtpBloc(sl()));
  sl.registerFactory(() => BannerBloc(sl()));
  sl.registerFactory(() => CategoryBloc(sl()));
  sl.registerFactory(() => RestaurantBloc(sl()));
  sl.registerFactory(() => RestaurantDetailBloc(sl()));
  sl.registerFactory(() => RestaurantMenuBloc(sl<CategoryRepository>(), sl<RestaurantMenuRepository>()));
  sl.registerFactory(() => CartBloc(sl()));
  sl.registerFactory(() => OrderBloc(sl()));
}
