import 'dart:convert';
import 'dart:io';

import 'package:rss/data/cache/auth/auth_local_store_contract.dart';
import 'package:http/http.dart' as http;
import 'package:rss/data/cache/auth/auth_local_store_impl.dart';
import 'package:rss/data/core/api_constants.dart';
import 'package:rss/data/core/custom_exception.dart';
import 'package:rss/di/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  static IAuthLocalStore? store;

  ApiClient(this._client);
  final http.Client _client;

  dynamic get(String path, {Map<dynamic, dynamic>? params}) async {
    // store = getItInstance<IAuthLocalStore>();
    // final token = await store!.fetch();
    IAuthLocalStore? _authLocalStore;
    SharedPreferences? _sharedPrefrences;
    _sharedPrefrences = await SharedPreferences.getInstance();
    _authLocalStore = AuthLocalStoreImpl(_sharedPrefrences);
    final token = await _authLocalStore.fetch();
    var responseJson;
    try {
      await Future.delayed(Duration(milliseconds: 500));
      print(token!.value);
      final response = await _client.get(getPath(path, params), headers: {
        'Accept': 'application/json',
        'content-type': 'application/json',
        'Authorization': 'Bearer ${token.value}'
      });

      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('no connection found!');
    }
    return responseJson;
  }

  dynamic post(String path, {Map<dynamic, dynamic>? params}) async {
    // store = getItInstance<IAuthLocalStore>();
    // final token = await store!.fetch();
    IAuthLocalStore? _authLocalStore;
    SharedPreferences? _sharedPrefrences;
    _sharedPrefrences = await SharedPreferences.getInstance();
    _authLocalStore = AuthLocalStoreImpl(_sharedPrefrences);
    final token = await _authLocalStore.fetch();
    var responseJson;
    try {
      await Future.delayed(Duration(milliseconds: 500));
      print(token!.value);
      final response = await _client.post(getPath(path, null),
          headers: {
            'Accept': 'application/json',
            'content-type': 'application/json',
            'Authorization': 'Bearer ${token.value}'
          },
          body: jsonEncode(params));

      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('no connection found!');
    }
    return responseJson;
  }

  dynamic getWithoutToken(String path, {Map<dynamic, dynamic>? params}) async {
    store = getItInstance<IAuthLocalStore>();
    var responseJson;
    try {
      await Future.delayed(Duration(milliseconds: 500));
      final response = await _client.get(getPath(path, params), headers: {
        'Accept': 'application/json',
        'content-type': 'application/json',
      });

      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('no connection found!');
    }
    return responseJson;
  }

  Uri getPath(String path, Map<dynamic, dynamic>? params) {
    var paramsString = '';
    if (params?.isNotEmpty ?? false) {
      params?.forEach((key, value) {
        paramsString += '&$key=$value';
      });
    }
    var endpoint = '${ApiConstants.BASE_URL}$path$paramsString';
    print(endpoint);
    return Uri.parse(endpoint);
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = jsonDecode(response.body);
        return responseJson['data'];
      case 400:
        throw BadRequestException(response.body);
      case 401:
        throw UnauthorizedException(response.body);
      case 403:
        throw UnauthorizedException(response.body);
      case 300:
        throw UnauthorizedException(response.body);
      default:
        throw FetchDataException('Error occured while communicating to server');
    }
  }
}

// class DioApiClient {
//   String? token;
//   final Dio dio = Dio(
//     BaseOptions(
//       baseUrl: ApiConstants.BASE_URL,
//       headers: {
//         'Content-Type': 'application/json',
//         "Accept": 'application/json',
//       },
//     ),
//   );

//   Future<>
// }
