part of 'basket_bloc.dart';

abstract class BasketEvent {}

class BasketFetchFromHiveEvent extends BasketEvent {}

class BasketPaymentInitEvent extends BasketEvent {}

class BasketPaymentRequestEvent extends BasketEvent {}

class BasketremoveproductEvent extends BasketEvent {
  int index;
  BasketremoveproductEvent(this.index);
}
