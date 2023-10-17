import 'package:async/async.dart';
import 'package:auth/src/domain/auth_service_contract.dart';
import 'package:auth/src/domain/credential.dart';
import 'package:auth/src/domain/token.dart';
import 'package:auth/src/infra/api/auth_api_contract.dart';

class EmailPassAuth implements IAuthService {
  final IAuthApi authApi;
  Credential? _credential;

  EmailPassAuth(this.authApi);

  void credentials({
    required String email,
    required String password,
    // ignore: non_constant_identifier_names
    organization_type_id,
    // ignore: non_constant_identifier_names
    password_confirmation,
    // ignore: non_constant_identifier_names
    customer_org_name,
  }) {
    _credential = Credential(
        email: email,
        password: password,
        organization_type_id: organization_type_id,
        password_confirmation: password_confirmation,
        customer_org_name: customer_org_name);
  }

  @override
  Future<Result<Token>?> signIn() async {
    assert(_credential != null);
    var result = await authApi.signIn(_credential!);

    if (result.isError) return result.asError;
    return Result.value(Token(result.asValue!.value));
  }

  @override
  Future<Result<Token>?> signUp() async {
    assert(_credential != null);
    var result = await authApi.signUp(_credential!);

    if (result.isError) return result.asError;
    return Result.value(Token(result.asValue!.value));
  }
}
