// To parse this JSON data, do
//
//     final surveyList = surveyListFromJson(jsonString);

import 'dart:convert';

class LibraryNotification {
  LibraryNotification(
      {this.id,
      this.title,
      this.notificationText,
      // this.sendTo,
      // this.teamId,
      // this.individualId,
      // this.notifyOn,
      // this.createdBy,
      // this.creatorGuard,
      // this.notifyStatus,
      // this.createdAt,
      // this.updatedAt,
      // this.commentCount,
      this.questionCount,
      // this.unseenCount,
      // this.likesCount,
      // this.firstName,
      // this.lastName,
      // this.userImage,
      // this.liked,
      // this.surveyNotificationProfiles,
      this.submitted
      // this.user,
      });

  int? id;
  String? title;
  String? notificationText;
  // String? sendTo;
  // dynamic teamId;
  // dynamic individualId;
  // DateTime? notifyOn;
  // int? createdBy;
  // String? creatorGuard;
  // String? notifyStatus;
  // DateTime? createdAt;
  bool? submitted;
  // DateTime? updatedAt;
  // int? commentCount;
  int? questionCount;
  // int? unseenCount;
  // int? likesCount;
  // String? firstName;
  // String? lastName;
  // String? userImage;
  // bool? liked;
  // List<SurveyNotificationProfile>? surveyNotificationProfiles;
  // User? user;

  factory LibraryNotification.fromJson(Map<String, dynamic> json) =>
      LibraryNotification(
        id: json["id"],
        title: json["title"],
        notificationText: json["notification_text"],
        // sendTo: json["send_to"],
        // teamId: json["team_id"],
        // individualId:
        //     json["individual_id"] == null ? null : json["individual_id"],
        submitted: json['submitted'],
        // notifyOn: DateTime.parse(json["notify_on"]),
        // createdBy: json["created_by"],
        // creatorGuard: json["creator_guard"],
        // notifyStatus: json["notify_status"],
        // createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: DateTime.parse(json["updated_at"]),
        // commentCount: json["comment_count"],
        questionCount: json["question_count"],
        // unseenCount: json["unseen_count"],
        // likesCount: json["likes_count"],
        // firstName: json["first_name"],
        // lastName: json["last_name"],
        // userImage: json["user_image"],
        // liked: json["liked"],
        // surveyNotificationProfiles: List<SurveyNotificationProfile>.from(
        //     json["survey_notification_profiles"]
        //         .map((x) => SurveyNotificationProfile.fromJson(x))),
        // user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "notification_text": notificationText,
        // "send_to": sendTo,
        // "team_id": teamId,
        // "individual_id": individualId == null ? null : individualId,
        // "notify_on": notifyOn!.toIso8601String(),
        // "created_by": createdBy,
        // "creator_guard": creatorGuard,
        // "notify_status": notifyStatus,
        // "created_at": createdAt!.toIso8601String(),
        // "updated_at": updatedAt!.toIso8601String(),
        // "comment_count": commentCount,
        "question_count": questionCount,
        // "unseen_count": unseenCount,
        // "likes_count": likesCount,
        // "first_name": firstName,
        // "last_name": lastName,
        // "user_image": userImage,
        // "liked": liked,
        // "survey_notification_profiles": List<dynamic>.from(
        //     surveyNotificationProfiles!.map((x) => x.toJson())),
        // "user": user!.toJson(),
      };
}class SurveyNotificationProfile {
  SurveyNotificationProfile({
    this.id,
    this.surveyNotificationId,
    this.profileId,
    this.isViewed,
    this.isLiked,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? surveyNotificationId;
  int? profileId;
  int? isViewed;
  int? isLiked;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory SurveyNotificationProfile.fromJson(Map<String, dynamic> json) =>
      SurveyNotificationProfile(
        id: json["id"],
        surveyNotificationId: json["survey_notification_id"],
        profileId: json["profile_id"],
        isViewed: json["is_viewed"],
        isLiked: json["is_liked"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "survey_notification_id": surveyNotificationId,
        "profile_id": profileId,
        "is_viewed": isViewed,
        "is_liked": isLiked,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
