part of 'category-product-bloc.dart';

class CategotyProductEvent {}

class CategoryProductRequestEvent extends CategotyProductEvent {
  String categoryId;
  CategoryProductRequestEvent(this.categoryId);
}
