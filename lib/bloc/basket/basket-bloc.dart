import 'package:apple_store/data/model/card-item.dart';
import 'package:apple_store/data/repository/basket-repository.dart';
import 'package:apple_store/di/di.dart';
import 'package:apple_store/util/payment-handler.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'basket-event.dart';
part 'basket-state.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  final IBasketRepository _basketRepository = locatore.get();
  final PaymentHandler _paymentHandler = locatore.get();
  BasketBloc() : super(BasketInitState()) {
    on<BasketFechedFromHiveEvent>((event, emit) async {
      var basketItemList = await _basketRepository.getAllbasketItem();
      var basketFinalPrice = _basketRepository.getBasketFinalPrice();
      emit(BasketDataFechedState(basketItemList, basketFinalPrice));
    });

    on<BasketPaymentInitEvent>((event, emit) async {
      _paymentHandler.initPaymentRequest();
    });

    on<BasketPaymentRequestEvent>((event, emit) async {
      _paymentHandler.sendPaymentRequest();
    });
  }
}
