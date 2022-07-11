// To parse this JSON data, do
//
//     final learningNotification = learningNotificationFromJson(jsonString);

import 'dart:convert';

class LearningNotification {
  LearningNotification({
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
    this.question_count,
    this.unseenCount,
    this.likesCount,
    this.firstName,
    this.lastName,
    this.userImage,
    this.liked,
    this.learningNotificationProfiles,
  });

  int? id;
  String? title;
  String? notificationText;
  dynamic notificationUrl;
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
  int? question_count;
  int? unseenCount;
  int? likesCount;
  String? firstName;
  String? lastName;
  String? userImage;
  bool? liked;
  List<LearningNotificationProfile>? learningNotificationProfiles;

  factory LearningNotification.fromJson(Map<String, dynamic> json) =>
      LearningNotification(
        id: json["id"],
        title: json["title"],
        notificationText: json["notification_text"],
        notificationUrl: json["notification_url"],
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
        question_count: json["question_count"],
        unseenCount: json["unseen_count"],
        likesCount: json["likes_count"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        userImage: json["user_image"],
        liked: json["liked"],
        learningNotificationProfiles: List<LearningNotificationProfile>.from(
            json["learning_notification_profiles"]
                .map((x) => LearningNotificationProfile.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "notification_text": notificationText,
        "notification_url": notificationUrl,
        "send_to": sendTo,
        "team_id": teamId,
        "individual_id": individualId,
        "notify_on": notifyOn!.toIso8601String(),
        "resource_type": resourceType,
        "resource_url": resourceUrl,
        "resource_secure_url": resourceSecureUrl,
        "created_by": createdBy,
        "creator_guard": creatorGuard,
        "notify_status": notifyStatus,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "comment_count": commentCount,
        "question_count": question_count,
        "unseen_count": unseenCount,
        "likes_count": likesCount,
        "first_name": firstName,
        "last_name": lastName,
        "user_image": userImage,
        "liked": liked,
        "learning_notification_profiles": List<dynamic>.from(
            learningNotificationProfiles!.map((x) => x.toJson())),
      };
}

class LearningNotificationProfile {
  LearningNotificationProfile({
    this.id,
    this.learningNotificationId,
    this.profileId,
    this.isViewed,
    this.isLiked,
    this.feedback,
    this.quizScore,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? learningNotificationId;
  int? profileId;
  int? isViewed;
  int? isLiked;
  dynamic feedback;
  dynamic quizScore;
  dynamic createdAt;
  DateTime? updatedAt;

  factory LearningNotificationProfile.fromJson(Map<String, dynamic> json) =>
      LearningNotificationProfile(
        id: json["id"],
        learningNotificationId: json["learning_notification_id"],
        profileId: json["profile_id"],
        isViewed: json["is_viewed"],
        isLiked: json["is_liked"],
        feedback: json["feedback"],
        quizScore: json["quiz_score"],
        createdAt: json["created_at"],
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "learning_notification_id": learningNotificationId,
        "profile_id": profileId,
        "is_viewed": isViewed,
        "is_liked": isLiked,
        "feedback": feedback,
        "quiz_score": quizScore,
        "created_at": createdAt,
        "updated_at": updatedAt!.toIso8601String(),
      };
}
