import 'package:rss/data/core/api_client.dart';
import 'package:rss/data/model/news/all_news_model.dart';

abstract class AllNewsRemoteDataSource {
  Future<List<AllNews>> getAllNews(int p);
}

class AllNewsRemoteDataSourceImpl extends AllNewsRemoteDataSource {
  final ApiClient _client;
  AllNewsRemoteDataSourceImpl(this._client);
  @override
  Future<List<AllNews>> getAllNews(int p) async {
    print(p);
    // final response = await _client.get('/news?page=$page');
    final response = await _client.get('/news?page=$p');

    final responseData = response as List;
    if (responseData.isNotEmpty) {
      final recentNews = responseData.map((e) => AllNews.fromJson(e)).toList();
      return recentNews;
    }
    return [];
  }
}
