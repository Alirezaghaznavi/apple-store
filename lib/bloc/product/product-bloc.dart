import 'package:apple_store/data/model/card-item.dart';
import 'package:apple_store/data/model/category.dart';
import 'package:apple_store/data/model/product-image.dart';
import 'package:apple_store/data/model/product-property.dart';
import 'package:apple_store/data/model/product-variant.dart';
import 'package:apple_store/data/model/product.dart';
import 'package:apple_store/data/repository/basket-repository.dart';
import 'package:apple_store/data/repository/product-detail-repository.dart';
import 'package:apple_store/di/di.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

part 'product-event.dart';
part 'product-state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final IProductDetailRepository _productDetailRepository = locatore.get();
  final IBasketRepository _basketRepository = locatore.get();
  ProductBloc() : super(ProductLoadingState()) {
    on<ProductDetailRequsetEvent>((event, emit) async {
      var productImages =
          await _productDetailRepository.getGallery(event.productId);
      var productVariants =
          await _productDetailRepository.getProductVariants(event.productId);
      var productCategoty =
          await _productDetailRepository.getCategory(event.categoryID);
      var productProperties =
          await _productDetailRepository.getProperties(event.productId);
      emit(ProductDetailResponseState(
          productImages, productVariants, productCategoty, productProperties));
    });
    on<ProductAddToBasket>((event, emit) async {
      var basketItem = BasketItem(
          event.product.id,
          event.product.collectionId,
          event.product.thumbnail,
          event.product.discountPrice,
          event.product.price,
          event.product.name,
          event.product.categoryId);
      await _basketRepository.addProductsToBasket(basketItem);
    });
  }
}
