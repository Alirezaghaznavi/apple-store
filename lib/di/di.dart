import 'package:apple_store/bloc/basket/basket-bloc.dart';
import 'package:apple_store/data/datasource/authentication-datasource.dart';
import 'package:apple_store/data/datasource/banner-datasourse.dart';
import 'package:apple_store/data/datasource/basket-datasource.dart';
import 'package:apple_store/data/datasource/category-datasource.dart';
import 'package:apple_store/data/datasource/category-product-datasource.dart';
import 'package:apple_store/data/datasource/comment-datasource.dart';
import 'package:apple_store/data/datasource/product-datasourse.dart';
import 'package:apple_store/data/datasource/product-detail-datasource.dart';
import 'package:apple_store/data/repository/authentication-repository.dart';
import 'package:apple_store/data/repository/banner-repository.dart';
import 'package:apple_store/data/repository/basket-repository.dart';
import 'package:apple_store/data/repository/category-product-repository.dart';
import 'package:apple_store/data/repository/category-repository.dart';
import 'package:apple_store/data/repository/comment-repository.dart';
import 'package:apple_store/data/repository/product-detail-repository.dart';
import 'package:apple_store/data/repository/product-repository.dart';
import 'package:apple_store/util/payment-handler.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

var locatore = GetIt.instance;

Future<void> getItInit() async {
  locatore.registerSingleton<Dio>(Dio(BaseOptions(
    baseUrl: 'http://alirezagtech.ir/api/',
  )));

  locatore
      .registerFactory<IAuthenticationDatasource>(() => AuthenticationRemote());
  locatore.registerFactory<IAuthRepository>(() => AuthenticationRepository());

  locatore
      .registerFactory<ICategoryDatasource>(() => CategoryDatasourseRemote());
  locatore.registerFactory<ICategoryRepository>(() => CategoryRepository());

  locatore.registerFactory<IBannerDatasourse>(() => BannerDataSourceRemote());
  locatore.registerFactory<IBannerRepository>(() => BannerRepository());

  locatore.registerFactory<IProductDatasoutce>(() => ProductDatasourceRemote());
  locatore.registerFactory<IProductRepository>(() => ProductRepository());

  locatore.registerSingleton<IProductDetailDatasource>(ProductDetailRemote());
  locatore
      .registerSingleton<IProductDetailRepository>(ProductDetailRepository());

  locatore.registerFactory<ICategotyProductDatasource>(
      () => CategotyProductDatasourceRemote());
  locatore.registerFactory<ICategoryProductRepository>(
      () => CategotyProductRepository());

  locatore.registerFactory<IBasketDatasource>(() => BasketDatasourceLocal());
  locatore.registerFactory<IBasketRepository>(() => BasketRepository());

  locatore.registerFactory<ICommentDatasource>(() => CommentDatasourceRemote());
  locatore.registerFactory<ICommentRepository>(() => CommentRepository());

  locatore.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());

  //payment
  locatore.registerSingleton<PaymentHandler>(ZarinpalPaymentHandler());

  //bloc
  locatore.registerSingleton<BasketBloc>(BasketBloc());
}
