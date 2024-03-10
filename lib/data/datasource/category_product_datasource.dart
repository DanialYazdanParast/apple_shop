import 'package:dio/dio.dart';

import '../../di/di.dart';
import '../../util/api_exception.dart';
import '../model/product.dart';

abstract class ICategoryProductDatasource {
  Future<List<Product>> getProductByCategoryID(String categoryID);
}

class CategoryProductRemoteDatasource extends ICategoryProductDatasource {
  final Dio _dio = locator.get();

  @override
  Future<List<Product>> getProductByCategoryID(String categoryID) async {
    try {
      Map<String, String> qParams = {'filter': 'category="$categoryID"'};

     Response<dynamic> response;
      if (categoryID == '78q8w901e6iipuk') {
       response = await _dio.get('collections/products/records');
      } else {
         response = await _dio.get('collections/products/records',
            queryParameters: qParams);
      }

      return response.data['items']
          .map<Product>((jsonObject) => Product.fromJson(jsonObject))
          .toList();
    } on DioError catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown erorr');
    }
  }
}
