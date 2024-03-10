import 'package:dartz/dartz.dart';

import '../../di/di.dart';
import '../../util/api_exception.dart';
import '../datasource/category_product_datasource.dart';

import '../model/product.dart';

abstract class ICategoryProductRepository {

  Future<Either<String, List<Product>>> getProductByCategoryID(String categoryID);
}

class CategoryProductRepoSitory extends ICategoryProductRepository {
  final ICategoryProductDatasource _datasource = locator.get();

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
