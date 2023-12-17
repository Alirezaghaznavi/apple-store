part of 'product-bloc.dart';

abstract class ProductEvent {}

class ProductDetailRequsetEvent extends ProductEvent {
  String productId;
  String categoryID;
  ProductDetailRequsetEvent(this.productId, this.categoryID);
}

class ProductAddToBasket extends ProductEvent {
  Product product;
  ProductAddToBasket(this.product);
}
