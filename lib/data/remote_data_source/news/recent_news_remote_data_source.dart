import 'package:rss/data/core/api_client.dart';
import 'package:rss/data/model/news/recent_news_model.dart';

abstract class RecentNewsRemoteDataSource {
  Future<List<News>> getRecentNews();
}

class RecentNewsRemoteDataSourceImpl extends RecentNewsRemoteDataSource {
  final ApiClient _client;
  RecentNewsRemoteDataSourceImpl(this._client);
  @override
  Future<List<News>> getRecentNews() async {
    final response = await _client.get('/recent-news');
    final responseData = response as List;
    if (responseData.isNotEmpty) {
      final recentNews = responseData.map((e) => News.fromJson(e)).toList();
      return recentNews;
    }
    return [];
  }
}
