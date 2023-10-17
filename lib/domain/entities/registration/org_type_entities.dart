import 'package:equatable/equatable.dart';

class OrgTypeEntity extends Equatable {
  final int? id;
  // ignore: non_constant_identifier_names
  final String? type_name;

  OrgTypeEntity({
    required this.id,
    // ignore: non_constant_identifier_names
    required this.type_name,
  });

  @override
  List<Object?> get props => [id!, type_name!];

  @override
  bool get stringify => true;
}
