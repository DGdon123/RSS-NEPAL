import 'package:auth/src/domain/auth_service_contract.dart';
import 'package:auth/src/domain/credential.dart';
import 'package:auth/src/infra/adpater/email_pass_auth.dart';
import 'package:auth/src/infra/api/auth_api_contract.dart';

class AuthManager {
  IAuthApi? _authApi;

  AuthManager(IAuthApi authApi) {
    _authApi = authApi;
  }

  IAuthService? service(AuthType type) {
    var service;
    switch (type) {
      case AuthType.emailPassword:
        service = EmailPassAuth(_authApi!);
        break;
      case AuthType.google:
        break;
    }
    return service;
  }
}
