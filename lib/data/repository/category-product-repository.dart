import 'package:apple_store/data/datasource/category-product-datasource.dart';
import 'package:apple_store/data/model/product.dart';
import 'package:apple_store/di/di.dart';
import 'package:apple_store/util/api-exception.dart';
import 'package:dartz/dartz.dart';


abstract class ICategoryProductRepository {
  Future<Either<String, List<Product>>> getProductsByCategoryId(String categoryId);
}

class CategotyProductRepository extends ICategoryProductRepository {
  @override
  Future<Either<String, List<Product>>> getProductsByCategoryId(String categoryId) async {
    final ICategotyProductDatasource _datasourse = locatore.get();
    try {
      var response = await _datasourse.getProductsByCategoryId(categoryId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطای نامشخص');
    }
  }
}
