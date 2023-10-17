import 'package:equatable/equatable.dart';

class RecentNewsEntity extends Equatable {
  final int? id;
  final String? title;
  final String? subject;
  final String? dateLine;
  final String? newsDate;
  RecentNewsEntity(
      {required this.id,
      required this.title,
      required this.subject,
      required this.dateLine,
      required this.newsDate});

  @override
  List<Object?> get props => [id!, title!, subject!, dateLine, newsDate];

  @override
  bool get stringify => true;
}
