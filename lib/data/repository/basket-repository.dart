import 'package:apple_store/data/datasource/basket-datasource.dart';
import 'package:apple_store/data/model/card-item.dart';
import 'package:apple_store/di/di.dart';
import 'package:dartz/dartz.dart';

abstract class IBasketRepository {
  Future<Either<String, String>> addProductsToBasket(BasketItem basketItem);
  Future<Either<String, List<BasketItem>>> getAllbasketItem();
  int getBasketFinalPrice();
}

class BasketRepository extends IBasketRepository {
  final IBasketDatasource _datasource = locatore.get();

  @override
  Future<Either<String, String>> addProductsToBasket(
      BasketItem basketItem) async {
    try {
      await _datasource.addProductsToBasket(basketItem);
      return right('محصول به سبد خرید اضافه شد');
    } catch (e) {
      return left('خطا در افرودن محصول به سبد خرید');
    }
  }

  @override
  Future<Either<String, List<BasketItem>>> getAllbasketItem() async {
    try {
      var bsketItemList = await _datasource.getAllBasketItem();
      return right(bsketItemList);
    } catch (e) {
      return left('خطا در افرودن محصول به سبد خرید');
    }
  }

  @override
  int getBasketFinalPrice() {
    return _datasource.getBasketFinalPrice();
  }
}
