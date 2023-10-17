import 'package:rss/domain/entities/news/new_modules_entities.dart';

class NewsModule extends NewsModuleEntity {
  final int? id;
  final String? name;

  NewsModule({
    this.id,
    this.name,
  }) : super(
          id: id,
          name: name,
        );

  factory NewsModule.fromJson(Map<String, dynamic> json) {
    return NewsModule(
      id: json['id'],
      name: json['module_name'],
    );
  }
}
