import 'package:apple_store/data/model/product.dart';
import 'package:apple_store/di/di.dart';
import 'package:apple_store/util/api-exception.dart';
import 'package:dio/dio.dart';

abstract class IProductDatasoutce {
  Future<List<Product>> getProducts();
  Future<List<Product>> getBestCellerProducts();
  Future<List<Product>> getHotestProducts();
}

class ProductDatasourceRemote extends IProductDatasoutce {
  final Dio _dio = locatore.get();

  @override
  Future<List<Product>> getProducts() async {
    try {
      var response = await _dio.post('collections/products/records');

      return response.data['items']
          .map<Product>((jsonObject) => Product.fromJson(jsonObject))
          .toList();
    } on DioException catch (e) {
      throw ApiException(e.response?.statusCode, e.message);
    } catch (ex) {
      throw ApiException(0, 'unknow error');
    }
  }

  @override
  Future<List<Product>> getBestCellerProducts() async {
    final Map<String, String> qParams = {'filter': "popularity='Best Seller'"};
    try {
      var response = await _dio.get('collections/products/records',
          queryParameters: qParams);

      return response.data['items']
          .map<Product>((jsonObject) => Product.fromJson(jsonObject))
          .toList();
    } on DioException catch (e) {
      throw ApiException(e.response?.statusCode, e.message);
    } catch (ex) {
      throw ApiException(0, 'unknow error');
    }
  }

  @override
  Future<List<Product>> getHotestProducts() async {
    final Map<String, String> qParams = {'filter': "popularity='Hotest'"};
    try {
      var response = await _dio.get('collections/products/records',
          queryParameters: qParams);

      return response.data['items']
          .map<Product>((jsonObject) => Product.fromJson(jsonObject))
          .toList();
    } on DioException catch (e) {
      throw ApiException(e.response?.statusCode, e.message);
    } catch (ex) {
      throw ApiException(0, 'unknow error');
    }
  }
}
