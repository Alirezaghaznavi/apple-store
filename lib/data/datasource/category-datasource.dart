import 'package:apple_store/data/model/category.dart';
import 'package:apple_store/di/di.dart';
import 'package:apple_store/util/api-exception.dart';
import 'package:dio/dio.dart';

abstract class ICategoryDatasource {
  Future<List<Category>> getCategories();
}

class CategoryDatasourseRemote extends ICategoryDatasource {
  final Dio _dio = locatore.get();
  @override
  Future<List<Category>> getCategories() async {
    try {
      var response = await _dio.get('collections/categories/records');

      return response.data['items']
          .map<Category>((jsonObject) => Category.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (e) {
      throw ApiException(e.response?.statusCode, e.message);
    } catch (ex) {
      throw ApiException(0, 'unknow error');
    }
  }
}
