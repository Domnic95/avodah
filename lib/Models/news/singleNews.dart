// To parse this JSON data, do
//
//     final singleNew = singleNewFromJson(jsonString);

import 'dart:convert';

class SingleNews {
  SingleNews(
      {this.id,
      this.title,
      this.createdOn,
      this.description,
      this.notificationUrl,
      this.notificationId,
      this.userId,
      this.mediaType,
      this.mediaUrl,
      this.firstName,
      this.lastName,
      this.userImage,
      this.notificationType,
      this.listType,
      this.teamId,
      this.teamName,
      this.today,
      this.newCreatedOn,
      this.totalUnseen,
      this.totalCount,
      this.likes,
      this.liked,
      this.comments,
      this.timeDifference});

  int? id;
  dynamic title;
  DateTime? createdOn;
  String? description;
  dynamic notificationUrl;
  dynamic notificationId;
  int? userId;
  MediaType? mediaType;
  String? mediaUrl;
  String? firstName;
  String? lastName;
  String? userImage;
  dynamic notificationType;
  ListType? listType;
  int? teamId;
  var teamName;
  String? today;
  DateTime? newCreatedOn;
  int? totalUnseen;
  int? totalCount;
  int? likes;
  bool? liked;
  List<dynamic>? comments;
  String? timeDifference;

  factory SingleNews.fromJson(Map<String, dynamic> json) => SingleNews(
        id: json["id"],
        title: json["title"] ?? "Test Title",
        createdOn: DateTime.parse(json["created_on"]),
        description: json["description"],
        notificationUrl: json["notification_url"],
        notificationId: json["notification_id"],
        userId: json["user_id"],
        mediaType: mediaTypeValues.map[json["media_type"]],
        mediaUrl: json["media_url"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        userImage: json["user_image"],
        notificationType: json["notification_type"],
        listType: listTypeValues.map[json["list_type"]],
        teamId: json["team_id"],
        teamName: json["team_name"],
        today: json["today"],
        newCreatedOn: DateTime.parse(json["new_created_on"]),
        totalUnseen: json["total_unseen"],
        totalCount: json["total_count"],
        likes: json["likes"],
        liked: json["liked"],
        timeDifference: dateDifference(DateTime.parse(json["created_on"])),
        comments: json["comments"] == null
            ? []
            : List<dynamic>.from(json["comments"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title,
        "created_on": createdOn!.toIso8601String(),
        "description": description,
        "notification_url": notificationUrl,
        "notification_id": notificationId,
        "user_id": userId,
        "media_type": mediaTypeValues.reverse[mediaType],
        "media_url": mediaUrl,
        "first_name": firstName,
        "last_name": lastName,
        "user_image": userImage,
        "notification_type": notificationType,
        "list_type": listTypeValues.reverse[listType],
        "team_id": teamId,
        "team_name": teamName,
        "today": today,
        "new_created_on": newCreatedOn!.toIso8601String(),
        "total_unseen": totalUnseen,
        "total_count": totalCount,
        "likes": likes,
        "liked": liked,
        "comments":
            comments == null ? [] : List<dynamic>.from(comments!.map((x) => x)),
        "timeDifference": timeDifference
      };
}

enum ListType { COMMENTS_MEDIA }

final listTypeValues = EnumValues({"comments/media": ListType.COMMENTS_MEDIA});

enum MediaType { EMPTY, VIDEO, IMAGE }

final mediaTypeValues = EnumValues(
    {"": MediaType.EMPTY, "image": MediaType.IMAGE, "video": MediaType.VIDEO});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}


String dateDifference(DateTime? date) {
  if (date == null) {
    return "";
  }
  String difference = 'a';
  DateTime now = DateTime.now();
  int dif = now.difference(date).inSeconds;

  if (dif < 60) {
    difference = dif.toString() + " second ago";
  } else if (dif < 3600) {
    difference = now.difference(date).inMinutes.toString() + " minutes ago";
  } else if (dif < 86400) {
    difference = now.difference(date).inHours.toString() + " hours ago";
  } else if (dif > 86400) {
    int _days = now.difference(date).inDays;

    if (_days <= 1) {
      difference = _days.toString() + " day ago";
    } else if (_days > 1 && _days < 30) {
      difference = _days.toString() + " days ago";
    }
    // else {
    //   difference = (_days ~/ 31).toString() + " months ago";
    // }
    else if (_days >= 30 && _days < 60) {
      difference = (_days / 30).round().toString() + " month ago";
    } else if (_days < 365) {
      difference = (_days / 30).round().toString() + " months ago";
    } else if (_days >= 365 && _days < 730) {
      // int year = now.difference(date).m;
      difference = (_days / 365).round().toString() + " year ago";
    } else if (_days > 730) {
      difference = (_days / 365).round().toString() + " years ago";
    }
  } else {
    difference = '---';
  }

  return difference;
}
