// // To parse this JSON data, do
// //
// //     final newdetailsmodel = newdetailsmodelFromJson(jsonString);

// import 'dart:convert';

// Newdetailsmodel newdetailsmodelFromJson(String str) =>
//     Newdetailsmodel.fromJson(json.decode(str));

// String newdetailsmodelToJson(Newdetailsmodel data) =>
//     json.encode(data.toJson());

// class Newdetailsmodel {
//   Newdetailsmodel({
//     this.data,
//   });

//   Data? data;

//   factory Newdetailsmodel.fromJson(Map<String, dynamic> json) =>
//       Newdetailsmodel(
//         data: Data.fromJson(json),
//       );

//   Map<String, dynamic> toJson() => {
//         "data": data == null ? null : data!.toJson(),
//       };
// }

// class Data {
//   Data({
//     this.id,
//     this.title,
//     this.subject,
//     this.news,
//     this.newsPriority,
//     this.dateline,
//     this.newsDate,
//     this.newsTime,
//     this.newsModule,
//     this.newsCategory,
//     this.newsMedia,
//   });

//   int? id;
//   String? title;
//   String? subject;
//   String? news;
//   String? newsPriority;
//   String? dateline;
//   DateTime? newsDate;
//   String? newsTime;
//   String? newsModule;
//   List<NewsCategory>? newsCategory;
//   NewsMedia? newsMedia;

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         id: json["id"] == null ? null : json["id"],
//         title: json["title"] == null ? null : json["title"],
//         subject: json["subject"] == null ? null : json["subject"],
//         news: json["news"] == null ? null : json["news"],
//         newsPriority:
//             json["news_priority"] == null ? null : json["news_priority"],
//         dateline: json["dateline"] == null ? null : json["dateline"],
//         newsDate: json["news_date"] == null
//             ? null
//             : DateTime.parse(json["news_date"]),
//         newsTime: json["news_time"] == null ? null : json["news_time"],
//         newsModule: json["news_module"] == null ? null : json["news_module"],
//         newsCategory: json["news_category"] == null
//             ? null
//             : List<NewsCategory>.from(
//                 json["news_category"].map((x) => NewsCategory.fromJson(x))),
//         newsMedia: json["news_media"] == null
//             ? null
//             : NewsMedia.fromJson(json["news_media"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id == null ? null : id,
//         "title": title == null ? null : title,
//         "subject": subject == null ? null : subject,
//         "news": news == null ? null : news,
//         "news_priority": newsPriority == null ? null : newsPriority,
//         "dateline": dateline == null ? null : dateline,
//         "news_date": newsDate == null
//             ? null
//             : "${newsDate!.year.toString().padLeft(4, '0')}-${newsDate!.month.toString().padLeft(2, '0')}-${newsDate!.day.toString().padLeft(2, '0')}",
//         "news_time": newsTime == null ? null : newsTime,
//         "news_module": newsModule == null ? null : newsModule,
//         "news_category": newsCategory == null
//             ? null
//             : List<dynamic>.from(newsCategory!.map((x) => x.toJson())),
//         "news_media": newsMedia == null ? null : newsMedia!.toJson(),
//       };
// }

// class NewsCategory {
//   NewsCategory({
//     this.id,
//     this.newsCat,
//     this.newsCatEn,
//     this.createdAt,
//     this.updatedAt,
//     this.pivot,
//   });

//   int? id;
//   String? newsCat;
//   String? newsCatEn;
//   dynamic createdAt;
//   dynamic updatedAt;
//   Pivot? pivot;

//   factory NewsCategory.fromJson(Map<String, dynamic> json) => NewsCategory(
//         id: json["id"] == null ? null : json["id"],
//         newsCat: json["news_cat"] == null ? null : json["news_cat"],
//         newsCatEn: json["news_cat_en"] == null ? null : json["news_cat_en"],
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
//         pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id == null ? null : id,
//         "news_cat": newsCat == null ? null : newsCat,
//         "news_cat_en": newsCatEn == null ? null : newsCatEn,
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//         "pivot": pivot == null ? null : pivot!.toJson(),
//       };
// }

// class Pivot {
//   Pivot({
//     this.newsId,
//     this.categoryId,
//   });

//   int? newsId;
//   int? categoryId;

//   factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
//         newsId: json["news_id"] == null ? null : json["news_id"],
//         categoryId: json["category_id"] == null ? null : json["category_id"],
//       );

//   Map<String, dynamic> toJson() => {
//         "news_id": newsId == null ? null : newsId,
//         "category_id": categoryId == null ? null : categoryId,
//       };
// }

// class NewsMedia {
//   NewsMedia({
//     this.image,
//     this.audio,
//     this.video,
//   });

//   List<Image>? image;
//   List<dynamic>? audio;
//   List<dynamic>? video;

//   factory NewsMedia.fromJson(Map<String, dynamic> json) => NewsMedia(
//         image: json["image"] == null
//             ? null
//             : List<Image>.from(json["image"].map((x) => Image.fromJson(x))),
//         audio: json["audio"] == null
//             ? null
//             : List<dynamic>.from(json["audio"].map((x) => x)),
//         video: json["video"] == null
//             ? null
//             : List<dynamic>.from(json["video"].map((x) => x)),
//       );

//   Map<String, dynamic> toJson() => {
//         "image": image == null
//             ? null
//             : List<dynamic>.from(image!.map((x) => x.toJson())),
//         "audio":
//             audio == null ? null : List<dynamic>.from(audio!.map((x) => x)),
//         "video":
//             video == null ? null : List<dynamic>.from(video!.map((x) => x)),
//       };
// }

// class Image {
//   Image({
//     this.id,
//     this.newsId,
//     this.filePath,
//     this.mediaType,
//     this.mediaFileProperty,
//   });

//   int? id;
//   int? newsId;
//   String? filePath;
//   String? mediaType;
//   String? mediaFileProperty;

//   factory Image.fromJson(Map<String, dynamic> json) => Image(
//         id: json["id"] == null ? null : json["id"],
//         newsId: json["news_id"] == null ? null : json["news_id"],
//         filePath: json["file_path"] == null ? null : json["file_path"],
//         mediaType: json["media_type"] == null ? null : json["media_type"],
//         mediaFileProperty: json["media_file_property"] == null
//             ? null
//             : json["media_file_property"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id == null ? null : id,
//         "news_id": newsId == null ? null : newsId,
//         "file_path": filePath == null ? null : filePath,
//         "media_type": mediaType == null ? null : mediaType,
//         "media_file_property":
//             mediaFileProperty == null ? null : mediaFileProperty,
//       };
// }

class Newdetailsmodel {
  Data? data;

  Newdetailsmodel({this.data});

  Newdetailsmodel.fromJson(Map<String, dynamic> json) {
    data = new Data.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? title;
  String? subject;
  String? news;
  String? newsPriority;
  String? dateline;
  String? newsDate;
  String? newsTime;
  String? newsModule;
  List<NewsCategory>? newsCategory;
  NewsMedia? newsMedia;

  Data(
      {this.id,
      this.title,
      this.subject,
      this.news,
      this.newsPriority,
      this.dateline,
      this.newsDate,
      this.newsTime,
      this.newsModule,
      this.newsCategory,
      this.newsMedia});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subject = json['subject'];
    news = json['news'];
    newsPriority = json['news_priority'];
    dateline = json['dateline'];
    newsDate = json['news_date'];
    newsTime = json['news_time'];
    newsModule = json['news_module'];
    if (json['news_category'] != null) {
      newsCategory = <NewsCategory>[];
      json['news_category'].forEach((v) {
        newsCategory!.add(new NewsCategory.fromJson(v));
      });
    }
    newsMedia = json['news_media'] != null
        ? new NewsMedia.fromJson(json['news_media'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['subject'] = this.subject;
    data['news'] = this.news;
    data['news_priority'] = this.newsPriority;
    data['dateline'] = this.dateline;
    data['news_date'] = this.newsDate;
    data['news_time'] = this.newsTime;
    data['news_module'] = this.newsModule;
    if (this.newsCategory != null) {
      data['news_category'] =
          this.newsCategory!.map((v) => v.toJson()).toList();
    }
    if (this.newsMedia != null) {
      data['news_media'] = this.newsMedia!.toJson();
    }
    return data;
  }
}

class NewsCategory {
  int? id;
  String? newsCat;
  String? newsCatEn;
  String? createdAt;
  String? updatedAt;
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

class NewsMedia {
  List<Image>? image;
  List<Audio>? audio;
  List<Video>? video;

  NewsMedia({this.image, this.audio, this.video});

  NewsMedia.fromJson(Map<String, dynamic> json) {
    if (json['image'] != null) {
      image = <Image>[];
      json['image'].forEach((v) {
        image!.add(new Image.fromJson(v));
      });
    }
    if (json['audio'] != null) {
      audio = <Audio>[];
      json['audio'].forEach((v) {
        audio!.add(new Audio.fromJson(v));
      });
    }
    if (json['video'] != null) {
      video = <Video>[];
      json['video'].forEach((v) {
        video!.add(new Video.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.image != null) {
      data['image'] = this.image!.map((v) => v.toJson()).toList();
    }
    if (this.audio != null) {
      data['audio'] = this.audio!.map((v) => v.toJson()).toList();
    }
    if (this.video != null) {
      data['video'] = this.video!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Image {
  int? id;
  int? newsId;
  String? filePath;
  String? mediaType;
  String? mediaFileProperty;
  String? media_title;
  Image(
      {this.id,
      this.newsId,
      this.filePath,
      this.mediaType,
      this.mediaFileProperty,
      this.media_title});

  Image.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    newsId = json['news_id'];
    filePath = json['file_path'];
    mediaType = json['media_type'];
    mediaFileProperty = json['media_file_property'];
    media_title = json["media_title"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['news_id'] = this.newsId;
    data['file_path'] = this.filePath;
    data['media_type'] = this.mediaType;
    data['media_file_property'] = this.mediaFileProperty;
    data["media_title"] = this.media_title;
    return data;
  }
}

class Video {
  int? id;
  int? newsId;
  String? filePath;
  String? mediaType;
  String? mediaFileProperty;
  String? media_title;
  Video(
      {this.id,
      this.newsId,
      this.filePath,
      this.mediaType,
      this.mediaFileProperty,
      this.media_title});

  Video.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    newsId = json['news_id'];
    filePath = json['file_path'];
    mediaType = json['media_type'];
    mediaFileProperty = json['media_file_property'];
    this.media_title = json["media_title"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['news_id'] = this.newsId;
    data['file_path'] = this.filePath;
    data['media_type'] = this.mediaType;
    data['media_file_property'] = this.mediaFileProperty;
    data["media_title"] = this.media_title;
    return data;
  }
}

class Audio {
  int? id;
  int? newsId;
  String? filePath;
  String? mediaType;
  String? mediaFileProperty;

  Audio(
      {this.id,
      this.newsId,
      this.filePath,
      this.mediaType,
      this.mediaFileProperty});

  Audio.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    newsId = json['news_id'];
    filePath = json['file_path'];
    mediaType = json['media_type'];
    mediaFileProperty = json['media_file_property'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['news_id'] = this.newsId;
    data['file_path'] = this.filePath;
    data['media_type'] = this.mediaType;
    data['media_file_property'] = this.mediaFileProperty;
    return data;
  }
}
