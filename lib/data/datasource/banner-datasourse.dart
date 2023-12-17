import 'package:apple_store/data/model/banner.dart';
import 'package:apple_store/di/di.dart';
import 'package:apple_store/util/api-exception.dart';
import 'package:dio/dio.dart';

abstract class IBannerDatasourse {
  Future<List<BannerCamping>> getBanners();
}

class BannerDataSourceRemote extends IBannerDatasourse {
  final Dio _dio = locatore.get();

  @override
  Future<List<BannerCamping>> getBanners() async {
    try {
      var response = await _dio.get('collections/banners/records');

      return response.data['items']
          .map<BannerCamping>(
              (jsonObject) => BannerCamping.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.message);
    } catch (ex) {
      throw ApiException(0, 'unknow error');
    }
  }
}
