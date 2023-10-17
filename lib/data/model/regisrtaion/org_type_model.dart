import 'package:rss/domain/entities/registration/org_type_entities.dart';

class OrgType extends OrgTypeEntity {
  final int? id;
  // ignore: non_constant_identifier_names
  final String? type_name;

  OrgType({
    this.id,
    // ignore: non_constant_identifier_names
    this.type_name,
  }) : super(id: id, type_name: type_name);

  factory OrgType.fromJson(Map<String, dynamic> json) {
    return OrgType(
      id: json['id'],
      type_name: json['type_name'],
    );
  }
}

class Data {
  int? id;
  String? typeName;
  Null remarks;

  Data({this.id, this.typeName, this.remarks});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typeName = json['type_name'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type_name'] = this.typeName;
    data['remarks'] = this.remarks;
    return data;
  }
}
