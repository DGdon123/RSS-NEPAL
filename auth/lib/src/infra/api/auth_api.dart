import 'dart:convert';

import 'package:async/async.dart';
import 'package:auth/src/domain/credential.dart';
import 'package:auth/src/infra/api/auth_api_contract.dart';
import 'package:auth/src/infra/api/mapper.dart';
import 'package:http/http.dart' as http;

class AuthApi implements IAuthApi {
  String? baseUrl;
  final http.Client? _client;

  AuthApi(this.baseUrl, this._client);

  @override
  Future<Result<String?>> signIn(Credential? credential) async {
    var endpoint = Uri.http('$baseUrl', '/api/v1/login');
    print('endpoint: $endpoint');
    return await _postCrdential(endpoint, credential);
  }

  Future<Result<String?>> _postCrdential(
      Uri endpoint, Credential? credential) async {
    var response = await _client!.post(
      endpoint,
      body: jsonEncode(Mapper.toJson(credential!)),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
    );

    if (response.statusCode != 200) {
      Map map = jsonDecode(response.body);
      return Result.error(_transformError(map));
    }

    var json = jsonDecode(response.body);

    var resData = json['data'];

    if (resData['token'] != null) {
      return Result.value(resData['token']);
    } else {
      return Result.error(resData['message']);
    }
  }

  dynamic _transformError(Map map) {
    var message = map['message'];
    if (message is String) return message;
    var errStr =
        message.fold('', (prev, ele) => '${prev + ele.values.first}' '\n');
    return errStr.trim();
  }

  @override
  Future<Result<String?>> signUp(Credential? credential) async {
    var endpoint = Uri.http('$baseUrl', '/api/v1/register');
    print('endpoint: $endpoint');
    return await _postCrdential(endpoint, credential);
  }
}
