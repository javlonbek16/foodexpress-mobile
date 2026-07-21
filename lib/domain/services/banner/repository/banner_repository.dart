import 'package:foodexpress_mobile/domain/failure/app_failures.dart';
import 'package:foodexpress_mobile/infrastructure/models/banner_model/banner_model.dart';
import 'package:fpdart/fpdart.dart';

abstract class BannerRepository {
  Future<Either<AppFailures, List<BannerModel>>> getBanners();
}
