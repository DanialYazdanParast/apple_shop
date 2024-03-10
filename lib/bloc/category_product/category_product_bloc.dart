import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';


import '../../data/model/product.dart';
import '../../data/repository/category_product_repository.dart';
import '../../di/di.dart';

part 'category_product_event.dart';
part 'category_product_state.dart';

class CategoryProductBloc extends Bloc<CategoryProductEvent, CategoryProductState> {

   final ICategoryProductRepository _repository = locator.get();

  CategoryProductBloc() : super(CategoryProductLodingState())  {
    on<CategoryProductGetInitilze>((event, emit) async{

      emit(CategoryProductLodingState());

      var productByCategoryID =
    await _repository.getProductByCategoryID(event.categoryID);
      emit(CategoryProductSuccessState(productByCategoryID));
    
      
    });
  }
}
