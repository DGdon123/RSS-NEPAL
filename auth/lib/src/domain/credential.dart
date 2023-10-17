class Credential {
  String? email;
  String? password;
  // ignore: non_constant_identifier_names
  String? customer_org_name;
  // ignore: non_constant_identifier_names
  int? organization_type_id;
  // ignore: non_constant_identifier_names
  String? password_confirmation;
  AuthType? type;

  Credential({
    this.type,
    // ignore: non_constant_identifier_names
    this.organization_type_id,
    // ignore: non_constant_identifier_names
    this.password_confirmation,
    // ignore: non_constant_identifier_names
    this.customer_org_name,
    required this.email,
    required this.password,
  });
}

enum AuthType { emailPassword, google }
