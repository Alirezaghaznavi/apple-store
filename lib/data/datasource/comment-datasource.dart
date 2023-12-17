import 'package:apple_store/data/model/comment.dart';
import 'package:apple_store/di/di.dart';
import 'package:apple_store/util/api-exception.dart';
import 'package:dio/dio.dart';

abstract class ICommentDatasource {
  Future<List<Comment>> getComments(String productId);
  Future<void> postComment(String productId, String userId, String comment);
}

class CommentDatasourceRemote extends ICommentDatasource {
  final Dio _dio = locatore.get();

  @override
  Future<List<Comment>> getComments(String productId) async {
    final Map<String, String> qParams = {
      'filter': "productId='$productId'",
      'expand': 'userId'
    };

    try {
      var response = await _dio.get('collections/comments/records',
          queryParameters: qParams);

      return response.data['items']
          .map<Comment>((jsonObject) => Comment.fromJson(jsonObject))
          .toList();
    } on DioException catch (e) {
      throw ApiException(e.response?.statusCode, e.message);
    } catch (ex) {
      throw ApiException(0, 'unknow error');
    }
  }

  @override
  Future<void> postComment(
      String productId, String userId, String comment) async {
    final Map<String, String> data = {
      'productId': productId,
      'userId': 'wovc1mc3pkxqmbn',
      'text': comment
    };

    try {
      await _dio.post('collections/comments/records', data: data);
    } on DioException catch (e) {
      throw ApiException(e.response?.statusCode, e.message);
    } catch (ex) {
      throw ApiException(0, 'unknow error');
    }
  }
}
