import 'package:rss/data/core/api_client.dart';
import 'package:rss/data/model/email/resent_email_model.dart';

abstract class ResentEmailVerificationRemoteDataSource {
  Future<EmailModel> resentEmailVerification();
}

class ResentEmailVerificationRemoteDataSourceImpl
    extends ResentEmailVerificationRemoteDataSource {
  final ApiClient _client;
  ResentEmailVerificationRemoteDataSourceImpl(this._client);
  @override
  Future<EmailModel> resentEmailVerification() async {
    final response = await _client.get('/resend/email');
    var responseData = response;
    final me = EmailModel.fromJson(responseData);

    return me;
  }
}
