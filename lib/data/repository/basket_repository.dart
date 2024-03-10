import 'package:apple_shop/data/datasource/basket_datasource.dart';
import 'package:dartz/dartz.dart';
import '../../di/di.dart';
import '../model/card_item.dart';

abstract class IBasketRepository {
  Future<Either<String, String>> addProductToBasket(BasketItem basketItem);
  Future<Either<String, List<BasketItem>>> getAllBasketItems();
  Future<int> getBasketFinalPrice();
  Future<void> removeProduct(int index);
}

class BasketRepoSitory extends IBasketRepository {
  final IBasketDatasource _datasource = locator.get();

  @override
  Future<Either<String, String>> addProductToBasket(
      BasketItem basketItem) async {
    try {
      await _datasource.addProduct(basketItem);

      return right('محصول به سبد خرید اضافه شد');
    } catch (ex) {
      return left('خطا در افزودن محصول به سبد خرید');
    }
  }

  @override
  Future<Either<String, List<BasketItem>>> getAllBasketItems() async {
    try {
      var basketItemList = await _datasource.getAllBasketItems();

      return right(basketItemList);
    } catch (ex) {
      return left('خطا در نمایش محصولات');
    }
  }

  @override
  Future<int> getBasketFinalPrice() async {
    return _datasource.getBasketFinalPrice();
  }

  @override
  Future<void> removeProduct(int index) async{
    _datasource.removeProduct(index);
  }
}
