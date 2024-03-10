part of 'category_product_bloc.dart';


abstract class CategoryProductEvent {}

class CategoryProductGetInitilze extends CategoryProductEvent {
   final String categoryID;
   CategoryProductGetInitilze(this.categoryID);
 
}
