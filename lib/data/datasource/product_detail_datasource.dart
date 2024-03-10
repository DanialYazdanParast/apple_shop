import 'package:apple_shop/data/model/category.dart';
import 'package:apple_shop/data/model/product_image.dart';
import 'package:apple_shop/data/model/variant.dart';
import 'package:dio/dio.dart';

import '../../di/di.dart';
import '../../util/api_exception.dart';
import '../model/product_peroperty.dart';
import '../model/product_variant.dart';
import '../model/variant_type.dart';

abstract class IDeteilProductDatasource {
  Future<List<ProductImage>> getGallery(String productId);
  Future<List<VarientType>> getVarientType();
  Future<List<Variant>> getVariants(String productId);
  Future<List<ProductVarint>> getProductVarint(String productId);
  Future<Category> getProductCategory(String categoryId);
  Future<List<Property>> getProductPropertise(String productId);
}

class DeteilProductRemotDatasource extends IDeteilProductDatasource {
  final Dio _dio = locator.get();
  @override
  Future<List<ProductImage>> getGallery(String productId) async {
    try {
      Map<String, String> qParams = {'filter': 'product_id="$productId"'};
      var response = await _dio.get('collections/gallery/records',
          queryParameters: qParams);

      return response.data['items']
          .map<ProductImage>((jsonObject) => ProductImage.fromJson(jsonObject))
          .toList();
    } on DioError catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown erorr');
    }
  }

  @override
  Future<List<VarientType>> getVarientType() async {
    try {
      var response = await _dio.get('collections/variants_type/records');

      return response.data['items']
          .map<VarientType>((jsonObject) => VarientType.fromJson(jsonObject))
          .toList();
    } on DioError catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown erorr');
    }
  }

  @override
  Future<List<Variant>> getVariants(String productId) async {
    try {
      Map<String, String> qParams = {'filter': 'product_id="$productId"'};
      var response = await _dio.get('collections/variants/records',
          queryParameters: qParams);

      return response.data['items']
          .map<Variant>((jsonObject) => Variant.fromJson(jsonObject))
          .toList();
    } on DioError catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown erorr');
    }
  }

  @override
  Future<List<ProductVarint>> getProductVarint(String productId) async {
    var variantTypeList = await getVarientType();
    var variantList = await getVariants(productId);
    List<ProductVarint> productVarintList = [];

    try {
      for (var varientType in variantTypeList) {
        var varint = variantList
            .where((element) => element.typeId == varientType.id)
            .toList();
        productVarintList.add(ProductVarint(varientType, varint));
      }
      return productVarintList;
    } on DioError catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown erorr');
    }
  }

  @override
  Future<Category> getProductCategory(String categoryId) async {
    try {
      Map<String, String> qParams = {'filter': 'id="$categoryId"'};
      var response = await _dio.get('collections/category/records',
          queryParameters: qParams);

      return Category.fromMapJson(response.data['items'][0]);
    } on DioError catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown erorr');
    }
  }
  
  @override
  Future<List<Property>> getProductPropertise(String productId) async{
   try {
      Map<String, String> qParams = {'filter': 'product_id="$productId"'};
      var response = await _dio.get('collections/properties/records',
          queryParameters: qParams);

      return response.data['items']
          .map<Property>((jsonObject) => Property.fromjson(jsonObject))
          .toList();
    } on DioError catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown erorr');
    }
  }
}
