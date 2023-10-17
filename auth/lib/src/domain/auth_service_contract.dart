import 'package:async/async.dart';
import 'package:auth/src/domain/token.dart';

abstract class IAuthService {
  Future<Result<Token>?> signIn();
  Future<Result<Token>?> signUp();
}
