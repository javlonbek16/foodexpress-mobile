import 'package:foodexpress_mobile/domain/failure/app_failures.dart';
import 'package:foodexpress_mobile/domain/services/banner/banner_api_service.dart';
import 'package:foodexpress_mobile/domain/services/banner/repository/banner_repository.dart';
import 'package:foodexpress_mobile/infrastructure/models/banner_model/banner_model.dart';
import 'package:fpdart/fpdart.dart';

class BannerRepositoryImpl implements BannerRepository {
  final BannerApiService apiService;

  BannerRepositoryImpl(this.apiService);

  @override
  Future<Either<AppFailures, List<BannerModel>>> getBanners() => apiService.getBanners();
}
