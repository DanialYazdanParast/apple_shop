import 'package:apple_shop/data/model/card_item.dart';
import 'package:apple_shop/util/pyament_handler.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import '../../data/repository/basket_repository.dart';

part 'basket_event.dart';
part 'basket_state.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  final IBasketRepository _basketRepository;
  final PaymentHandler _paymentHandler;

  BasketBloc(this._paymentHandler, this._basketRepository)
      : super(BasketInitialState()) {
    on<BasketFetchFromHiveEvent>((event, emit) async {
      var basketItemList = await _basketRepository.getAllBasketItems();
      var finalPrice = await _basketRepository.getBasketFinalPrice();

      emit(BasketDataFetchedState(basketItemList, finalPrice));
    });
    on<BasketPaymentInitEvent>((event, emit) async {
      var finalPrice = await _basketRepository.getBasketFinalPrice();
      _paymentHandler.initPaymantRequest(finalPrice);
    });
    on<BasketPaymentRequestEvent>((event, emit) async {
      _paymentHandler.sendPaymantRequest();
    });

    on<BasketremoveproductEvent>((event, emit) async {
      _basketRepository.removeProduct(event.index);

      var basketItemList = await _basketRepository.getAllBasketItems();
      var finalPrice = await _basketRepository.getBasketFinalPrice();
      emit(BasketDataFetchedState(basketItemList, finalPrice));
    });
  }
}
