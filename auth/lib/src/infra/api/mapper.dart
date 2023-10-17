import 'package:auth/src/domain/credential.dart';

class Mapper {
  static Map<String, dynamic> toJson(Credential credential) => {
        'email': credential.email,
        'password': credential.password,
        'password_confirmation': credential.password_confirmation,
        'customer_org_name': credential.customer_org_name,
        'organization_type_id': credential.organization_type_id,
      };
}
