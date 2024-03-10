
import 'package:apple_shop/data/datasource/comment_datasource.dart';

import 'package:apple_shop/data/model/comment.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/util/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class ICommentRepository {
  Future<Either<String, List<Comment>>> getComments(String productId);
  Future<Either<String, String>> postComments(String productId,String comment);

}

class CommentRepository extends ICommentRepository {
  final ICommentDatasource _datasource = locator.get();

  @override
  Future<Either<String, List<Comment>>> getComments(String productId) async {
    try {
      var response = await _datasource.getComments(productId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message??'  خطا محتوای متنی ندارد ');
    }
  }
  
  @override
  Future<Either<String, String>> postComments(String productId, String comment) async{
     try {
      var response = await _datasource.postComments(productId,comment);
      return right('نظر شما اظافه شد');
    } on ApiException catch (ex) {
      return left(ex.message??'  خطا محتوای متنی ندارد ');
    }
  }
}
