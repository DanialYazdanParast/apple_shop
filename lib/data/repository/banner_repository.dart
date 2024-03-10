import 'package:apple_shop/data/model/banner.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/util/api_exception.dart';
import 'package:dartz/dartz.dart';

import '../datasource/banner_datasource.dart';

abstract class IBannerRepository {
  Future<Either<String, List<BannerCampin>>> getBanners();
}

class BaneerRepoSitory extends IBannerRepository {
  final IBannerDatasource _datasource = locator.get();

  @override
  Future<Either<String, List<BannerCampin>>> getBanners() async {
    try {
      var response = await _datasource.getBanners();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? '  خطا محتوای متنی ندارد ');
    }
  }
}
