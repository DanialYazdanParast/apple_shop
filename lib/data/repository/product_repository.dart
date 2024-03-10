import 'package:dartz/dartz.dart';

import '../../di/di.dart';
import '../../util/api_exception.dart';
import '../datasource/product_datasource.dart';
import '../model/product.dart';

abstract class IProductRepository {
  Future<Either<String, List<Product>>> getProductss();
  Future<Either<String, List<Product>>> getHotest();
  Future<Either<String, List<Product>>> getBestSeller();
  Future<Either<String, List<Product>>> getProductByCategoryID(String categoryID);
}

class ProductRepoSitory extends IProductRepository {
  final IProductDatasource _datasource = locator.get();

  @override
  Future<Either<String, List<Product>>> getProductss() async {
    try {
      var response = await _datasource.getProducts();

      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? '  خطا محتوای متنی ندارد ');
    }
  }

  @override
  Future<Either<String, List<Product>>> getBestSeller() async {
    try {
      var response = await _datasource.getBestSeller();

      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? '  خطا محتوای متنی ندارد ');
    }
  }

  @override
  Future<Either<String, List<Product>>> getHotest() async {
    try {
      var response = await _datasource.getHotest();

      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? '  خطا محتوای متنی ندارد ');
    }
  }
  
  @override
  Future<Either<String, List<Product>>> getProductByCategoryID(String categoryID) async{
     try {
      var response = await _datasource.getProductByCategoryID(categoryID);

      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? '  خطا محتوای متنی ندارد ');
    }
  }
}
