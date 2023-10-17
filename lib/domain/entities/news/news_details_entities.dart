import 'package:equatable/equatable.dart';

class NewsDetailsEntity extends Equatable {
  final int? id;
  final String? title;
  final String? subject;
  final String? dateLine;

  NewsDetailsEntity(
      {required this.id,
      required this.title,
      required this.subject,
      required this.dateLine});

  @override
  List<Object?> get props => [id!, title!, subject!, dateLine!];

  @override
  bool get stringify => true;
}
