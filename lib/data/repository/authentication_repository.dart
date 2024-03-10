import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/util/api_exception.dart';
import 'package:apple_shop/util/auth_manager.dart';
import 'package:dartz/dartz.dart';

import '../datasource/authentication_datasource.dart';

abstract class IAthRepository {
  Future<Either<String, String>> register(
      String username, String password, String passwordConfirm);

  Future<Either<String, String>> login(
    String username,
    String password,
  );
}

class AuthenticationRepository extends IAthRepository {
  final IAuthenticationDatasource _datasource = locator.get();

  @override
  Future<Either<String, String>> register(
      String username, String password, String passwordConfirm) async {
    try {
      await _datasource.register(username, password, passwordConfirm);
      return right('ثبت نام انجام شد');
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, String>> login(String username, String password) async {
    try {
      String token = await _datasource.login(username, password);
      if (token.isNotEmpty) {
        return right('شما وارد شدید');
      } else {
        return Left('خطایی در ورود پیش امده');
      }
    } on ApiException catch (ex) {
      return left('${ex.message}');
    }
  }
}
