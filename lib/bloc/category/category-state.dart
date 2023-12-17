import 'package:apple_store/data/model/category.dart';
import 'package:dartz/dartz.dart';

abstract class CategoryState {}



class CategoryLoadingState extends CategoryState {}

class CategoryResponseState extends CategoryState {
  Either<String, List<Category>> categories;

  CategoryResponseState(this.categories);
}
