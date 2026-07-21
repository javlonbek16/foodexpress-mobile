import 'package:dio/dio.dart';
import 'package:foodexpress_mobile/infrastructure/constants/app_endpoints.dart';
import 'package:foodexpress_mobile/infrastructure/network/dio_client.dart';
import 'package:foodexpress_mobile/infrastructure/network/network_executor.dart';
import 'package:foodexpress_mobile/domain/failure/app_failures.dart';
import 'package:foodexpress_mobile/infrastructure/models/banner_model/banner_model.dart';
import 'package:fpdart/fpdart.dart';

class BannerApiService {
  final Dio dio;

  BannerApiService(DioClient client) : dio = client.dio;

  Future<Either<AppFailures, List<BannerModel>>> getBanners() async {
    return NetworkExecutor.execute(() async {
      final response = await dio.get(AppEndpoints.bannerApi);
      final data = response.data as List<dynamic>;
      return data.map((e) => BannerModel.fromJson(e)).toList();
    });
  }
}
