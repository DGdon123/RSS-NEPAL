import 'package:auth/auth.dart';
import 'package:rss/data/cache/auth/auth_local_store_contract.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String CACHED_TOKEN = 'CACHED_TOKEN';
const String CACHED_AUTH = 'CACHED_AUTH';

class AuthLocalStoreImpl implements IAuthLocalStore {
  final SharedPreferences? preferences;
  AuthLocalStoreImpl(this.preferences);

  @override
  delete() {
    preferences!.remove(CACHED_TOKEN);
  }

  @override
  Future<Token>? fetch() {
    final tokenStr = preferences!.getString(CACHED_TOKEN);

    if (tokenStr != null) return Future.value(Token(tokenStr));
  }

  @override
  Future<AuthType>? fetchAuthType() {
    final authType = preferences!.getString(CACHED_AUTH);
    if (authType != null)
      return Future.value(
          AuthType.values.firstWhere((e) => e.toString() == authType));

    return null;
  }

  @override
  Future<void> save(Token token) {
    print("Printed Topeknm");
    print(token.value);
    return preferences!.setString(CACHED_TOKEN, token.value!);
  }

  @override
  Future saveAuthType(AuthType authType) {
    return preferences!.setString(CACHED_AUTH, authType.toString());
  }
}
