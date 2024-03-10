import 'package:apple_shop/data/model/category.dart';
import 'package:apple_shop/data/model/product_peroperty.dart';
import 'package:apple_shop/data/model/product_variant.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/util/api_exception.dart';
import 'package:dartz/dartz.dart';

import '../datasource/product_detail_datasource.dart';

import '../model/product_image.dart';
import '../model/variant_type.dart';

abstract class IDetailProductRepository {
  Future<Either<String, List<ProductImage>>> getProductImage(String productId);
  Future<Either<String, List<VarientType>>> getVarientType();
  Future<Either<String, List<ProductVarint>>> getProductVarients(String productId);
  Future<Either<String, Category>> getProductCategory(String categoryId);
  Future<Either<String, List<Property>>> getProductPropertise(String productId);
}

class DetailProductRepoSitory extends IDetailProductRepository {
  final IDeteilProductDatasource _datasource = locator.get();

  @override
  Future<Either<String, List<ProductImage>>> getProductImage(String productId) async {
    try {
      var response = await _datasource.getGallery(productId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? '  خطا محتوای متنی ندارد ');
    }
  }

  @override
  Future<Either<String, List<VarientType>>> getVarientType() async {
    try {
      var response = await _datasource.getVarientType();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? '  خطا محتوای متنی ندارد ');
    }
  }

  @override
  Future<Either<String, List<ProductVarint>>> getProductVarients(String productId) async {
    try {
      var response = await _datasource.getProductVarint(productId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? '  خطا محتوای متنی ندارد ');
    }
  }
  
  @override
  Future<Either<String, Category>> getProductCategory(String categoryId) async{
   try {
      var response = await _datasource.getProductCategory(categoryId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? '  خطا محتوای متنی ندارد ');
    }
  }
  
  @override
  Future<Either<String, List<Property>>> getProductPropertise(String productId) async{
     try {
      var response = await _datasource.getProductPropertise(productId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? '  خطا محتوای متنی ندارد ');
    }
  }
}
