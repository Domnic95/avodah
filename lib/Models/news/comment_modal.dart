import 'dart:convert';

import 'package:southwind/Models/Group/GroupMessages.dart';
import 'package:southwind/Models/news/singleNews.dart';
import 'package:southwind/Models/user_data.dart';

CommentModal commentModalFromJson(String str) =>
    CommentModal.fromJson(json.decode(str));

String commentModalToJson(CommentModal data) => json.encode(data.toJson());

class CommentModal {
  CommentModal({
    this.id,
    this.communicationNotificationId,
    this.profileId,
    this.comment,
    this.mediaType,
    this.mediaUrl,
    this.createdAt,
    this.updatedAt,
    required this.profile,
  });

  int? id;
  int? communicationNotificationId;
  int? profileId;
  String? comment;
  MediaTypes? mediaType;
  dynamic mediaUrl;
  DateTime? createdAt;
  DateTime? updatedAt;
  UserData profile;
  String get timeDifference {
    return dateDifference(createdAt);
  }

  factory CommentModal.fromJson(Map<String, dynamic> json) => CommentModal(
        id: json["id"],
        communicationNotificationId: json["communication_notification_id"],
        profileId: json["profile_id"],
        comment: json["comment"],
        mediaType: media(json["media_type"].toString()),
        mediaUrl: json["media_url"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        profile: UserData.fromJson(json["profile"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "communication_notification_id": communicationNotificationId,
        "profile_id": profileId,
        "comment": comment,
        "media_type": mediaType,
        "media_url": mediaUrl,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        // "profile": profile.toJson(),
      }; 
}
