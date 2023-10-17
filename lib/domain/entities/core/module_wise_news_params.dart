import 'package:equatable/equatable.dart';

class ModuleWiseRequestParam extends Equatable {
  final int? page;
  final int? id;

  ModuleWiseRequestParam(this.page, this.id);

  @override
  List<Object?> get props => [page];
}
