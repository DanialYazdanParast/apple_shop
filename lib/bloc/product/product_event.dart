import 'package:apple_shop/data/model/product.dart';

abstract class ProductEvent {}

class ProductInitializeEvent extends ProductEvent {
  final String productId;
  final String categoryID;
  ProductInitializeEvent(this.productId, this.categoryID);
}

class ProductAddToBasket extends ProductEvent {
  Product product;

  ProductAddToBasket(this.product);
}
