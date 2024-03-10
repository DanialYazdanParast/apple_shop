import 'package:apple_shop/data/repository/banner_repository.dart';
import 'package:apple_shop/data/repository/category_repository.dart';
import 'package:apple_shop/data/repository/product_repository.dart';
import 'package:apple_shop/di/di.dart';
import 'package:bloc/bloc.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IBannerRepository _bannerRepository = locator.get();
  final ICategoryRepository _categoryRepository = locator.get();
  final IProductRepository _productRepository = locator.get();

  HomeBloc() : super(HomeInitialState()) {
    on<HomeGetInitilzeData>((event, emit) async {
      emit(HomeLodingState());
      var bannerList = await _bannerRepository.getBanners();
      var categoryList = await _categoryRepository.getCategories();
      var productList = await _productRepository.getProductss();
      var bestsellerproductList = await _productRepository.getBestSeller();
      var hotestproductList = await _productRepository.getHotest();

      emit(HomeRequesSuccessState(bannerList, categoryList, productList,
          hotestproductList, bestsellerproductList ));
    });

  }
}
