import 'package:apple_store/data/model/banner.dart';
import 'package:apple_store/data/model/category.dart';
import 'package:apple_store/data/model/product.dart';
import 'package:apple_store/data/repository/banner-repository.dart';
import 'package:apple_store/data/repository/category-repository.dart';
import 'package:apple_store/data/repository/product-repository.dart';
import 'package:apple_store/di/di.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

part 'home-event.dart';
part 'home-state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IBannerRepository _bannerRepository = locatore.get();
  final ICategoryRepository _categoryRepository = locatore.get();
  final IProductRepository _productRepository = locatore.get();
  HomeBloc() : super(HomeInitialState()) {
    on<HomeInitializeRequestEvent>(
      (event, emit) async {
        emit(HomeLoadingState());
        var bannerList = await _bannerRepository.getBanners();
        var categoryList = await _categoryRepository.getCategories();
        var productList = await _productRepository.getProducts();
        var productBestSellerList =
            await _productRepository.getBestSellerProducts();
        var productHotestList = await _productRepository.getHotestProducts();

        emit(HomeResponseState(
          bannerList,
          categoryList,
          productList,
          productBestSellerList,
          productHotestList,
        ));
      },
    );
  }
}
