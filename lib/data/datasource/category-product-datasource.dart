import 'package:apple_store/data/model/product.dart';
import 'package:apple_store/di/di.dart';
import 'package:apple_store/util/api-exception.dart';
import 'package:dio/dio.dart';

abstract class ICategotyProductDatasource {
  Future<List<Product>> getProductsByCategoryId(String categoryId);
}

class CategotyProductDatasourceRemote extends ICategotyProductDatasource {
  final Dio _dio = locatore.get();
  @override
  Future<List<Product>> getProductsByCategoryId(String categoryId) async {
    
    final Map<String, String> qParams = {"filter": "categoryId='$categoryId'"};
    Response<dynamic> response;
    
    try {
      if (categoryId == '78q8w901e6iipuk') {
        response = await _dio.get('collections/products/records');
      } else {
        response = await _dio.get('collections/products/records',
            queryParameters: qParams);
      }

      return response.data['items']
          .map<Product>((jsonObject) => Product.fromJson(jsonObject))
          .toList();
    } on DioException catch (e) {
      print(e);
      throw ApiException(e.response?.statusCode, e.message);
    } catch (ex) {
      throw ApiException(0, 'unknow error');
    }
  }
}
