import 'package:dio/dio.dart';

import '../../di/di.dart';
import '../../util/api_exception.dart';
import '../model/banner.dart';

abstract class IBannerDatasource {
  Future<List<BannerCampin>> getBanners();
}

class BannerRemoteDatasource extends IBannerDatasource {
  final Dio _dio = locator.get();
  @override
  Future<List<BannerCampin>> getBanners() async {
    try {
      var response = await _dio.get('collections/banner/records');

      return response.data['items']
          .map<BannerCampin>((jsonObject) => BannerCampin.fromJsone(jsonObject))
          .toList();
    } on DioError catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown erorr');
    }
  }
}
