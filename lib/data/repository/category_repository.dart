import 'package:apple_shop/data/datasource/category_datasource.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/util/api_exception.dart';
import 'package:dartz/dartz.dart';

import '../model/category.dart';


abstract class ICategoryRepository {
  Future<Either<String, List<Category>>> getCategories();

}

class CategoryRepoSitory extends ICategoryRepository {
  final ICategoryDatasource _datasource = locator.get();

  @override
  Future<Either<String, List<Category>>> getCategories() async {
    try {
      var response = await _datasource.getCategories();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message??'  خطا محتوای متنی ندارد ');
    }
  }
}
