import 'package:auth/auth.dart';

abstract class IAuthLocalStore {
  Future<Token>? fetch();
  delete();
  Future<void> save(Token token);
  Future<AuthType>? fetchAuthType();
  Future saveAuthType(AuthType authType);
}
