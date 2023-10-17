import 'package:auth/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rss/data/cache/auth/auth_local_store_contract.dart';
import 'package:rss/data/cache/auth/auth_local_store_impl.dart';
import 'package:rss/presentation/state_management/auth/auth_cubit.dart';
import 'package:rss/presentation/views/auth/auth_page.dart';
import 'package:rss/presentation/views/auth/auth_page_adapter.dart';
import 'package:rss/presentation/views/auth/check_credentials.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';

class CompositionRoot {
  static SharedPreferences? _sharedPrefrences;
  static IAuthLocalStore? _authLocalStore;
  static String? _baseUrl;
  static Client? _client;

  // static AuthManager? _manager;

  static configure() async {
    _sharedPrefrences = await SharedPreferences.getInstance();
    _authLocalStore = AuthLocalStoreImpl(_sharedPrefrences);
    _client = Client();
    _baseUrl = 'nepalrss.org.np';
  }

  static Widget composeAuthUI() {
    IAuthApi _api = AuthApi(_baseUrl, _client);
    AuthManager _manager = AuthManager(_api);
    AuthCubit _authCubit = AuthCubit(_authLocalStore);
    IAuthPageAdapter _adapter =
        AuthPageAdapter(onUserAuthenticated: composeDashBoardUI);
    return BlocProvider(
      create: (context) => _authCubit,
      child: AuthPage(
        _manager,
        _adapter,
      ),
    );
  }

  static Future<Widget> start() async {
    final token = _authLocalStore!.fetch();
    // final authType = await _authLocalStore!.fetchAuthType();
    // final service = _manager?.service(authType!);
    // return token == null ? composeAuthUI() : composeDashBoardUI(service);
    if (token == null) {
      return composeAuthUI();
    } else {
      return CheckCreditalsPage();
    }
  }

  static Widget composeDashBoardUI(IAuthService? service) {
    return CheckCreditalsPage();
  }
}
