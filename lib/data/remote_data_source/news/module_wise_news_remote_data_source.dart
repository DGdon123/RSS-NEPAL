import 'package:rss/data/core/api_client.dart';
import 'package:rss/data/model/news/all_news_model.dart';

abstract class ModuleWiseNewsRemoteDataSource {
  Future<List<AllNews>> getNewsByModule(int p, int id);
}

class ModuleWiseNewsRemoteDataSourceImpl
    extends ModuleWiseNewsRemoteDataSource {
  final ApiClient _client;
  ModuleWiseNewsRemoteDataSourceImpl(this._client);
  @override
  Future<List<AllNews>> getNewsByModule(int p, int id) async {
    // final response = await _client.get('/news?page=$page');
    final response = await _client.get('/module-news/$id?page=$p');

    final responseData = response as List;
    if (responseData.isNotEmpty) {
      final recentNews = responseData.map((e) => AllNews.fromJson(e)).toList();
      return recentNews;
    }
    return [];
  }
}
