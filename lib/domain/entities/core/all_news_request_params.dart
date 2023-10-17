import 'package:equatable/equatable.dart';

class AllNewsRequestParams extends Equatable {
  final int? page;

  AllNewsRequestParams(this.page);

  @override
  List<Object?> get props => [page];
}
