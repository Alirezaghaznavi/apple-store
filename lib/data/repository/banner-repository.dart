import 'package:apple_store/data/datasource/banner-datasourse.dart';
import 'package:apple_store/data/model/banner.dart';
import 'package:apple_store/di/di.dart';
import 'package:apple_store/util/api-exception.dart';
import 'package:dartz/dartz.dart';

abstract class IBannerRepository {
  Future<Either<String, List<BannerCamping>>> getBanners();
}

class BannerRepository extends IBannerRepository {
  final IBannerDatasourse _datasourse = locatore.get();

  @override
  Future<Either<String, List<BannerCamping>>> getBanners() async {
    try {
      var response = await _datasourse.getBanners();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطای نامشخص');
    }
  }
}
