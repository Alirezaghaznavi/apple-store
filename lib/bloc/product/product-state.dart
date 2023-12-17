part of 'product-bloc.dart';

abstract class ProductState {}

class ProductDetailInitState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductDetailResponseState extends ProductState {
  Either<String, List<ProductImage>> productImages;
  Either<String, List<ProductVariant>> productVariants;
  Either<String, Category> productCategory;
  Either<String, List<ProductProperty>> productProperties;
  ProductDetailResponseState(this.productImages, this.productVariants,
      this.productCategory, this.productProperties);
}
