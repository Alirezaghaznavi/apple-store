part of 'home-bloc.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeResponseState extends HomeState {
  Either<String, List<BannerCamping>> bannerList;
  Either<String, List<Category>> categoryList;
  Either<String, List<Product>> productList;
  Either<String, List<Product>> productBestSellerList;
  Either<String, List<Product>> productHotestList;
  HomeResponseState(this.bannerList, this.categoryList, this.productList,
      this.productBestSellerList, this.productHotestList);
}
