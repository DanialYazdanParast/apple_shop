part of 'category_product_bloc.dart';


abstract class CategoryProductState {}

 class CategoryProductLodingState extends CategoryProductState {}


class CategoryProductSuccessState extends CategoryProductState {

  Either<String, List<Product>> productByCategoryID;

  CategoryProductSuccessState(this.productByCategoryID);
}
