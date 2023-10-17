import 'package:rss/data/core/api_client.dart';
import 'package:rss/data/model/news/news_module_model.dart';

abstract class NewModulesRemoteDataSource {
  Future<List<NewsModule>> getNewModules();
}

class NewModulesRemoteDataSourceImpl extends NewModulesRemoteDataSource {
  final ApiClient _apiClient;
  NewModulesRemoteDataSourceImpl(this._apiClient);
  @override
  Future<List<NewsModule>> getNewModules() async {
    final response = await _apiClient.get('/news-module');
    print(response);
    final resData = response as List;
    if (resData.isNotEmpty) {
      final newModules = resData.map((e) => NewsModule.fromJson(e)).toList();
      return newModules;
    }
    return [];
  }
}
