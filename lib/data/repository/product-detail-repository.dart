import 'package:apple_store/data/datasource/product-detail-datasource.dart';
import 'package:apple_store/data/model/category.dart';
import 'package:apple_store/data/model/product-image.dart';
import 'package:apple_store/data/model/product-property.dart';
import 'package:apple_store/data/model/product-variant.dart';
import 'package:apple_store/data/model/variant-type.dart';
import 'package:apple_store/data/model/varint.dart';
import 'package:apple_store/di/di.dart';
import 'package:apple_store/util/api-exception.dart';
import 'package:dartz/dartz.dart';

abstract class IProductDetailRepository {
  Future<Either<String, List<ProductImage>>> getGallery(String productId);
  Future<Either<String, List<VariantType>>> getVariantTypes();
  Future<Either<String, List<Variant>>> getVariants(String productId);
  Future<Either<String, List<ProductVariant>>> getProductVariants(
      String productId);
  Future<Either<String, Category>> getCategory(String categoryId);
  Future<Either<String, List<ProductProperty>>> getProperties(String productId);
}

class ProductDetailRepository extends IProductDetailRepository {
  final IProductDetailDatasource _datasource = locatore.get();

  @override
  Future<Either<String, List<ProductImage>>> getGallery(
      String productId) async {
    try {
      var response = await _datasource.getGallery(productId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطای نامشخص');
    }
  }

  @override
  Future<Either<String, List<VariantType>>> getVariantTypes() async {
    try {
      var response = await _datasource.getVariantTypes();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطای نامشخص');
    }
  }

  @override
  Future<Either<String, List<Variant>>> getVariants(String productId) async {
    try {
      var response = await _datasource.getVariants(productId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطای نامشخص');
    }
  }

  @override
  Future<Either<String, List<ProductVariant>>> getProductVariants(
      String productId) async {
    try {
      var response = await _datasource.getProductVariants(productId);
      return right(response);
    } on ApiException catch (ex) {
      print(ex);
      return left(ex.message ?? 'خطای نامشخص');
    }
  }

  @override
  Future<Either<String, Category>> getCategory(String categoryId) async {
    try {
      var response = await _datasource.getCategory(categoryId);
      return right(response);
    } on ApiException catch (ex) {
      print(ex);
      return left(ex.message ?? 'خطای نامشخص');
    }
  }

  @override
  Future<Either<String, List<ProductProperty>>> getProperties(
      String productId) async {
    try {
      var response = await _datasource.getProperties(productId);
      return right(response);
    } on ApiException catch (ex) {
      print(ex);
      return left(ex.message ?? 'خطای نامشخص');
    }
  }

}
