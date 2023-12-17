import 'package:apple_store/data/datasource/category-datasource.dart';
import 'package:apple_store/data/model/category.dart';
import 'package:apple_store/di/di.dart';
import 'package:apple_store/util/api-exception.dart';
import 'package:dartz/dartz.dart';

abstract class ICategoryRepository {
  Future<Either<String, List<Category>>> getCategories();
}

class CategoryRepository extends ICategoryRepository {
  final ICategoryDatasource _datasource = locatore.get();

  @override
  Future<Either<String, List<Category>>> getCategories() async {
    try {
      var response = await _datasource.getCategories();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطای نامشخص');
    }
  }
}
