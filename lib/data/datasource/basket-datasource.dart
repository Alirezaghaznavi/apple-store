import 'package:apple_store/data/model/card-item.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class IBasketDatasource {
  Future<void> addProductsToBasket(BasketItem basketItem);
  Future<List<BasketItem>> getAllBasketItem();
  int getBasketFinalPrice();
}

class BasketDatasourceLocal extends IBasketDatasource {
  final Box<BasketItem> box = Hive.box<BasketItem>('CardBox');

  @override
  Future<void> addProductsToBasket(BasketItem basketItem) async {
    await box.add(basketItem);
  }

  @override
  Future<List<BasketItem>> getAllBasketItem() async {
    return box.values.toList();
  }

  @override
  int getBasketFinalPrice() {
    var productList = box.values.toList();
    var finalPrice = productList.fold(
        0, (previousValue, element) => previousValue + element.realPrice!);
    return finalPrice;
  }
}
