part of 'basket_bloc.dart';

abstract class BasketState {}

class BasketInitialState extends BasketState {}

class BasketDataFetchedState extends BasketState {
  Either<String, List<BasketItem>> basketItem;
  int basketFinalPrice;
  BasketDataFetchedState(this.basketItem,this.basketFinalPrice);
}
