import 'package:rss/data/core/api_client.dart';

abstract class SubscriptionDataSource {
  Future<String?> requestSubscription(Map<String, dynamic> requestBody);
}

class SubscriptionDataSourceImpl extends SubscriptionDataSource {
  final ApiClient? _client;
  SubscriptionDataSourceImpl(this._client);
  @override
  Future<String?> requestSubscription(Map<String, dynamic> requestBody) async {
    final response =
        await _client!.post('/request/subscription', params: requestBody);
    final resData = response['message'];
    return resData;
  }
}
