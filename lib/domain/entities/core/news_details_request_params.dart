import 'package:equatable/equatable.dart';

class NewsDetailsRequestParams extends Equatable {
  final int? id;
  NewsDetailsRequestParams(this.id);
  @override
  List<Object?> get props => [id];
}
