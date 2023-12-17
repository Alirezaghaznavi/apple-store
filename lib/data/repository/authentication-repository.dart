import 'package:apple_store/data/datasource/authentication-datasource.dart';
import 'package:apple_store/util/api-exception.dart';
import 'package:apple_store/util/auth-manager.dart';
import 'package:dartz/dartz.dart';
import 'package:apple_store/di/di.dart';

abstract class IAuthRepository {
  Future<Either<String, String>> register(
      String username, String password, String passwordConfirm);

  Future<Either<String,  String>> login(String username, String password);
}

class AuthenticationRepository implements IAuthRepository {
  final IAuthenticationDatasource _datasource = locatore.get();

  @override
  Future<Either<String, String>> register(
      String username, String password, String passwordConfirm) async {
    try {
      await _datasource.register(username, password, passwordConfirm);
      return right('ثبت نام انجام شد');
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطای غیر منتظره');
    }
  }

  @override
  Future<Either<String, String>> login(String username, String password) async {
    try {
      String token = await _datasource.login(username, password);
      if (token.isNotEmpty) {
        AuthManager.saveToken(token);
        return right('شما وارد شده اید');
      } else {
        return left('خطایی در ورود پیش آمده! ');
      }
    } on ApiException catch (ex) {
      return left('${ex.message}');
    }
  }
}
