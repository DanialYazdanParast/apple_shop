import 'package:apple_shop/bloc/basket/basket_bloc.dart';
import 'package:apple_shop/data/datasource/basket_datasource.dart';
import 'package:apple_shop/data/datasource/comment_datasource.dart';
import 'package:apple_shop/data/repository/basket_repository.dart';
import 'package:apple_shop/data/repository/category_repository.dart';
import 'package:apple_shop/data/repository/comment_repository.dart';
import 'package:apple_shop/util/dio_provider.dart';
import 'package:apple_shop/util/pyament_handler.dart';
import 'package:apple_shop/util/url_handler.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/datasource/authentication_datasource.dart';
import '../data/datasource/banner_datasource.dart';
import '../data/datasource/category_datasource.dart';
import '../data/datasource/category_product_datasource.dart';
import '../data/datasource/product_datasource.dart';
import '../data/datasource/product_detail_datasource.dart';
import '../data/repository/authentication_repository.dart';
import '../data/repository/banner_repository.dart';
import '../data/repository/category_product_repository.dart';
import '../data/repository/product_detail_repository.dart';
import '../data/repository/product_repository.dart';

var locator = GetIt.instance;
Future<void> getItInit() async {
  //componets
  await _initcomponets();
  //datasources
  _inidatasources();
  //repositories
  _initRepositories();
  //bloc
  locator
      .registerSingleton<BasketBloc>(BasketBloc(locator.get(), locator.get()));
}
/////////////////////
Future<void> _initcomponets() async {
  //util
  locator.registerSingleton<UrlHandler>(UrlLauncher());
  locator.registerSingleton<PaymentHandler>(ZarinpalPayment(locator.get()));
  //componets
  locator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());
  locator.registerSingleton<Dio>(DioProvider.createDio());
}
//////////////////
void _inidatasources() {
  locator
      .registerFactory<IAuthenticationDatasource>(() => AuthenticationRemote());
  locator
      .registerFactory<ICategoryDatasource>(() => GategoryRemoteDatasource());
  locator.registerFactory<IBannerDatasource>(() => BannerRemoteDatasource());
  locator.registerFactory<IProductDatasource>(() => ProductRemoteDatasource());
  locator.registerFactory<IDeteilProductDatasource>(
      () => DeteilProductRemotDatasource());
  locator.registerFactory<ICategoryProductDatasource>(
      () => CategoryProductRemoteDatasource());

  locator.registerFactory<IBasketDatasource>(() => IBasketLocalDatasource());
  locator.registerFactory<ICommentDatasource>(() => CommentRemoteDatasource());
}
///////////////////
void _initRepositories() {
  locator.registerFactory<IAthRepository>(() => AuthenticationRepository());
  locator.registerFactory<ICategoryRepository>(() => CategoryRepoSitory());
  locator.registerFactory<IBannerRepository>(() => BaneerRepoSitory());
  locator.registerFactory<IProductRepository>(() => ProductRepoSitory());
  locator.registerFactory<IDetailProductRepository>(
      () => DetailProductRepoSitory());
  locator.registerFactory<ICategoryProductRepository>(
      () => CategoryProductRepoSitory());

  locator.registerFactory<IBasketRepository>(() => BasketRepoSitory());
  locator.registerFactory<ICommentRepository>(() => CommentRepository());
}
