import 'dart:convert';

import 'package:southwind/Models/news/singleNews.dart';
import 'package:southwind/Models/user_data.dart';

PostModal postModalFromJson(String str) => PostModal.fromJson(json.decode(str));

String postModalToJson(PostModal data) => json.encode(data.toJson());

class PostModal {
  PostModal({
    this.id,
    this.title,
    this.notificationText,
    this.notificationUrl,
    this.sendTo,
    this.teamId,
    this.individualId,
    this.notifyOn,
    this.resourceType,
    this.resourceUrl,
    this.resourceSecureUrl,
    this.createdBy,
    this.creatorGuard,
    this.notifyStatus,
    this.createdAt,
    this.updatedAt,
    this.commentCount,
    this.unseenCount,
    this.likesCount,
    this.firstName,
    this.lastName,
    this.userImage,
    this.liked,

    // this.profile,
  });

  int? id;
  String? title;
  String? notificationText;
  String? notificationUrl;
  String? sendTo;
  dynamic teamId;
  int? individualId;
  DateTime? notifyOn;
  dynamic resourceType;
  dynamic resourceUrl;
  dynamic resourceSecureUrl;
  int? createdBy;
  String? creatorGuard;
  String? notifyStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? commentCount;
  int? unseenCount;
  int? likesCount;
  String? firstName;
  String? lastName;
  String? userImage;
  bool? liked;
  String get timeDifference {
    return dateDifference(notifyOn);
  }
//  UserData? profile;

  factory PostModal.fromJson(Map<String, dynamic> json) => PostModal(
        id: json["id"],
        title: json["title"],
        notificationText: json["notification_text"],
        notificationUrl: json["notification_url"]??"",
        sendTo: json["send_to"],
        teamId: json["team_id"],
        individualId: json["individual_id"],
        notifyOn: DateTime.parse(json["notify_on"]),
        resourceType: json["resource_type"],
        resourceUrl: json["resource_url"],
        resourceSecureUrl: json["resource_secure_url"],
        createdBy: json["created_by"],
        creatorGuard: json["creator_guard"],
        notifyStatus: json["notify_status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        commentCount: json["comment_count"],
        unseenCount: json["unseen_count"],
        likesCount: json["likes_count"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        userImage: json["user_image"],
        liked: json["liked"],

        // profile: UserData.fromJson(json["profile"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "notification_text": notificationText,
        "notification_url": notificationUrl,
        "send_to": sendTo,
        "team_id": teamId,
        "individual_id": individualId,
        "notify_on": notifyOn?.toIso8601String(),
        "resource_type": resourceType,
        "resource_url": resourceUrl,
        "resource_secure_url": resourceSecureUrl,
        "created_by": createdBy,
        "creator_guard": creatorGuard,
        "notify_status": notifyStatus,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "comment_count": commentCount,
        "unseen_count": unseenCount,
        "likes_count": likesCount,
        "first_name": firstName,
        "last_name": lastName,
        "user_image": userImage,
        "liked": liked,
        // "profile": profile?.toJson(),
      };
}
