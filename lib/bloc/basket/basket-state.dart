part of 'basket-bloc.dart';

class BasketState {}

class BasketInitState extends BasketState {}

class BasketDataFechedState extends BasketState {
  Either<String, List<BasketItem>> basketItemList;
  int getBasketFinalPrice;
  BasketDataFechedState(this.basketItemList,this.getBasketFinalPrice);
}
