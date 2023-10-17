import 'package:rss/data/core/api_client.dart';
import 'package:rss/data/model/news/news-details.dart';

abstract class NewsDetailsRemoteDataSource {
  Future<Newdetailsmodel> getNewsDetails(id);
}

class NewsDetailsRemoteDataSourceImpl extends NewsDetailsRemoteDataSource {
  final ApiClient _apiClient;
  NewsDetailsRemoteDataSourceImpl(this._apiClient);
  @override
  Future<Newdetailsmodel> getNewsDetails(id) async {
    final response = await _apiClient.get('/news/$id');

    final resData = response;
    print(resData);
    final newsDetails = Newdetailsmodel.fromJson(resData);
    return newsDetails;

    // if (resData.isNotEmpty) {
    //   print(resData);
    //   final newsDetails = resData.map((e) => NewsDetails.fromJson(e));
    //   return newsDetails;
    // }
    // return getNewsDetails(id);
  }
}
