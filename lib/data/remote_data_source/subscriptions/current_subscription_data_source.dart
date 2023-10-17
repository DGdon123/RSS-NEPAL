import 'package:rss/data/core/api_client.dart';
import 'package:rss/data/model/subscription/current_subscription.dart';

abstract class CurrentSubscriptionDataSource {
  Future<CurrenSubscription> getCurrenttSubscription();
}

class CurrentSubscriptionDataSourceImpl extends CurrentSubscriptionDataSource {
  final ApiClient _apiClient;
  CurrentSubscriptionDataSourceImpl(this._apiClient);
  @override
  Future<CurrenSubscription> getCurrenttSubscription() async {
    final response = await _apiClient.get('/current-subscription');
    final resData = response;

    final currentSubscription =
        resData.map((e) => CurrenSubscription.fromJson(e));
    return currentSubscription;
  }
}
