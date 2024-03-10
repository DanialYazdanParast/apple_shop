import 'package:apple_shop/bloc/product/product_event.dart';
import 'package:apple_shop/bloc/product/product_state.dart';
import 'package:apple_shop/data/repository/basket_repository.dart';
import 'package:apple_shop/data/repository/product_detail_repository.dart';
import 'package:bloc/bloc.dart';

import '../../data/model/card_item.dart';
import '../../di/di.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final IDetailProductRepository _productRepository = locator.get();
  final IBasketRepository _basketRepository = locator.get();
  ProductBloc() : super(ProductInitialState()) {
    on<ProductInitializeEvent>((event, emit) async {
      emit(ProductDetailLodingState());
      var productImage =
          await _productRepository.getProductImage(event.productId);
      var productVarient =
          await _productRepository.getProductVarients(event.productId);
      var productCategory =
          await _productRepository.getProductCategory(event.categoryID);
      var productPropertise =
          await _productRepository.getProductPropertise(event.productId);

      emit(ProductDetailResponseState(
          productImage, productVarient, productCategory, productPropertise));
    });

    on<ProductAddToBasket>((event, emit) async {
      var basketItem = BasketItem(
          event.product.categoryId,
          event.product.collectionId,
          event.product.discountprice,
          event.product.id,
          event.product.name,
          event.product.price,
          event.product.thumbnail);

      _basketRepository.addProductToBasket(basketItem);
    });
  }
}
