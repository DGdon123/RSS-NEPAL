import 'package:rss/data/core/api_client.dart';
import 'package:rss/data/model/users/me_model.dart';

abstract class MeRemoteDataSource {
  Future<MeModel> getMe();
}

class MeRemoteDataSourceImpl extends MeRemoteDataSource {
  final ApiClient _client;
  MeRemoteDataSourceImpl(this._client);
  @override
  Future<MeModel> getMe() async {
    final response = await _client.get('/me');
    var responseData = response;
    final me = MeModel.fromJson(responseData);

    return me;
  }
}
