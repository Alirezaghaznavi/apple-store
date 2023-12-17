import 'package:apple_store/data/datasource/comment-datasource.dart';
import 'package:apple_store/data/model/comment.dart';
import 'package:apple_store/di/di.dart';
import 'package:apple_store/util/api-exception.dart';
import 'package:dartz/dartz.dart';

abstract class ICommentRepository {
  Future<Either<String, List<Comment>>> getComments(String productId);
  Future<Either<String, String>> postComments(
      String productId, String userId, String comment);
}

class CommentRepository extends ICommentRepository {
  final ICommentDatasource _datasource = locatore.get();
  @override
  Future<Either<String, List<Comment>>> getComments(String productId) async {
    try {
      var response = await _datasource.getComments(productId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطای نامشخص');
    }
  }

  @override
  Future<Either<String, String>> postComments(
      String productId, String userId, String comment) async {
    try {
      await _datasource.postComment(productId, userId, comment);
      return right('نظر شما ثبت شد');
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطای نامشخص');
    }
  }
}
