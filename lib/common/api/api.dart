import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rss/common/constants/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  // ignore: type_annotate_public_apis
  var _sharedPreferences;

  httpGet(dynamic api) async {
    _sharedPreferences = SharedPreferences.getInstance();
    var token = _sharedPreferences.getString("CACHED_TOKEN");
    // ignore: prefer_interpolation_to_compose_strings
    return await http.get(Uri.parse(baseUrl + '/' + api), headers: {
      "Content-type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    });
  }

  httpPost(dynamic api, Map<String, dynamic> data) async {
    _sharedPreferences = SharedPreferences.getInstance();
    var token = _sharedPreferences.getString("CACHED_TOKEN");
    // ignore: prefer_interpolation_to_compose_strings
    var resopones = await http.post(Uri.parse(baseUrl + '/' + api),
        body: json.encode(data),
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        });
    return resopones;
  }
}
