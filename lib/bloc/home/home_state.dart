import 'package:apple_shop/data/model/banner.dart';
import 'package:apple_shop/data/model/category.dart';

import 'package:dartz/dartz.dart';

import '../../data/model/product.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLodingState extends HomeState {}

class HomeRequesSuccessState extends HomeState {
  Either<String, List<BannerCampin>> bannerList;
  Either<String, List<Category>> categoryList;
  Either<String, List<Product>> productList;
  Either<String, List<Product>> hotestproductList;
  Either<String, List<Product>> bestsellerproductList;
 

  HomeRequesSuccessState(this.bannerList, this.categoryList, this.productList,
      this.hotestproductList, this.bestsellerproductList,);
}


