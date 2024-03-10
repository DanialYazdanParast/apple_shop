import 'package:apple_shop/data/model/category.dart';
import 'package:apple_shop/data/model/product_image.dart';
import 'package:apple_shop/data/model/product_peroperty.dart';
import 'package:apple_shop/data/model/product_variant.dart';
import 'package:dartz/dartz.dart';



abstract class ProductState {}

class ProductInitialState extends ProductState {}

class ProductDetailLodingState extends ProductState {}

class ProductDetailResponseState extends ProductState {
  Either<String, List<ProductImage>> productImage;
  Either<String, List<ProductVarint>> productvarient;
  Either<String, Category> productCategory;
    Either<String, List<Property>> productProperty;
  
  ProductDetailResponseState(this.productImage, this.productvarient ,this.productCategory,this.productProperty,);
}
