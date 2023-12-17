
import 'package:apple_store/data/datasource/product-datasourse.dart';
import 'package:apple_store/data/model/product.dart';
import 'package:apple_store/di/di.dart';
import 'package:apple_store/util/api-exception.dart';
import 'package:dartz/dartz.dart';

abstract class IProductRepository {
  Future<Either<String, List<Product>>> getProducts();
  Future<Either<String, List<Product>>> getBestSellerProducts();
  Future<Either<String, List<Product>>> getHotestProducts();
}

class ProductRepository extends IProductRepository {
  final IProductDatasoutce _datasource = locatore.get();

  @override
  Future<Either<String, List<Product>>> getProducts() async {
    try {
      var response = await _datasource.getProducts();
      return right(response);
    } on ApiException catch (ex) {
      print(ex);
      return left(ex.message ?? 'خطای نامشخص');
    }
  }

  @override
  Future<Either<String, List<Product>>> getBestSellerProducts() async {
    try {
      var response = await _datasource.getBestCellerProducts();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطای نامشخص');
    }
  }

  @override
  Future<Either<String, List<Product>>> getHotestProducts() async {
    try {
      var response = await _datasource.getHotestProducts();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطای نامشخص');
    }
  }
}
