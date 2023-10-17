import 'package:rss/domain/entities/news/recent_news_entities.dart';

// ignore: must_be_immutable
class News extends RecentNewsEntity {
  int? id;
  String? title;
  String? subject;
  String? newsPriority;
  String? dateLine;
  String? newsDate;
  String? newsTime;
  String? newsModule;
  List<NewsCategory>? newsCategory;


  News({
    this.id,
    this.title,
    this.subject,
    this.dateLine,
    this.newsDate,
    
  }) : super(id: id, title: title, subject: subject, dateLine: dateLine,newsDate:newsDate);

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'],
      title: json['title'],
      subject: json['subject'],
      dateLine: json['dateline'],
      newsDate:json["news_date"],
    );
  }
}

class NewsCategory {
  int? id;
  String? newsCat;
  String? newsCatEn;
  Null createdAt;
  Null updatedAt;
  Pivot? pivot;

  NewsCategory(
      {this.id,
      this.newsCat,
      this.newsCatEn,
      this.createdAt,
      this.updatedAt,
      this.pivot});

  NewsCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    newsCat = json['news_cat'];
    newsCatEn = json['news_cat_en'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['news_cat'] = this.newsCat;
    data['news_cat_en'] = this.newsCatEn;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? newsId;
  int? categoryId;

  Pivot({this.newsId, this.categoryId});

  Pivot.fromJson(Map<String, dynamic> json) {
    newsId = json['news_id'];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['news_id'] = this.newsId;
    data['category_id'] = this.categoryId;
    return data;
  }
}
