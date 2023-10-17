import 'package:auth/src/domain/credential.dart';
import 'package:auth/src/infra/api/auth_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  http.Client? client;
  late AuthApi sut; //; system under test
  String baseUrl = "nepalrss.org.np";

  setUp(() {
    client = http.Client();
    sut = AuthApi(baseUrl, client);
  });

  var credentials = Credential(email: 'email@email.com', password: 'ymc123');

  group('signIn', () {
    test('should return a token', () async {
      var result = await sut.signIn(credentials);
      print(result.asValue!.value!);
      expect(result.asValue!.value, isNotEmpty);
    });
  });
}
