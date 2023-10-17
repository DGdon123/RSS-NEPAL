import 'package:rss/data/core/api_client.dart';
import 'package:rss/data/model/regisrtaion/org_type_model.dart';

abstract class OrgTypeRemoteDataSource {
  Future<List<OrgType>> getOrgTypes();
}

class OrgTypeRemoteDataSourceImpl extends OrgTypeRemoteDataSource {
  final ApiClient _client;
  OrgTypeRemoteDataSourceImpl(this._client);
  @override
  Future<List<OrgType>> getOrgTypes() async {
    final response = await _client.getWithoutToken('/organization-type');
    print(response);
    final responseData = response as List;
    if (responseData.isNotEmpty) {
      final orgTypes = responseData.map((e) => OrgType.fromJson(e)).toList();
      return orgTypes;
    }
    return [];
  }
}
