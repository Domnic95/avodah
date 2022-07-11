// To parse this JSON data, do
//
//     final individualSurvey = individualSurveyFromJson(jsonString);

import 'dart:convert';

import 'package:southwind/Models/survey/UserSurvey.dart';

class IndividualSurvey {
  IndividualSurvey(
      {this.id,
      this.title,
      this.notificationText,
      this.sendTo,
      this.teamId,
      this.individualId,
      this.notifyOn,
      this.createdBy,
      this.creatorGuard,
      this.notifyStatus,
      this.createdAt,
      this.updatedAt,
      this.commentCount,
      this.questionCount,
      this.unseenCount,
      this.likesCount,
      this.firstName,
      this.lastName,
      this.userImage,
      this.liked,
      this.surveyNotificationQuestion,
      this.surveyNotificationProfiles,
      this.user,
      this.surveyAnswer});

  int? id;
  String? title;
  String? notificationText;
  String? sendTo;
  dynamic teamId;
  int? individualId;
  DateTime? notifyOn;
  int? createdBy;
  String? creatorGuard;
  String? notifyStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? commentCount;
  int? questionCount;
  int? unseenCount;
  int? likesCount;
  String? firstName;
  String? lastName;
  String? userImage;
  bool? liked;
  List<SurveyNotificationQuestion>? surveyNotificationQuestion;
  List<SurveyNotificationProfile>? surveyNotificationProfiles;
  List<SurveyNotificationAnswer>? surveyAnswer;
  SurveyUser? user;

  factory IndividualSurvey.fromJson(Map<String, dynamic> json) =>
      IndividualSurvey(
          id: json["id"],
          title: json["title"],
          notificationText: json["notification_text"],
          sendTo: json["send_to"],
          teamId: json["team_id"],
          individualId: json["individual_id"],
          notifyOn: DateTime.parse(json["notify_on"]),
          createdBy: json["created_by"],
          creatorGuard: json["creator_guard"],
          notifyStatus: json["notify_status"],
          createdAt: DateTime.parse(json["created_at"]),
          updatedAt: DateTime.parse(json["updated_at"]),
          commentCount: json["comment_count"],
          questionCount: json["question_count"],
          unseenCount: json["unseen_count"],
          likesCount: json["likes_count"],
          firstName: json["first_name"],
          lastName: json["last_name"],
          userImage: json["user_image"],
          liked: json["liked"],
          surveyNotificationQuestion: List<SurveyNotificationQuestion>.from(
              json["survey_notification_question"]
                  .map((x) => SurveyNotificationQuestion.fromJson(x))),
          surveyNotificationProfiles: List<SurveyNotificationProfile>.from(
              json["survey_notification_profiles"]
                  .map((x) => SurveyNotificationProfile.fromJson(x))),
          user: SurveyUser.fromJson(json["user"]),
          surveyAnswer: List<SurveyNotificationAnswer>.from(
              json["survey_notification_question"]
                  .map((x) => SurveyNotificationAnswer.fromJson(x))));
}

class SurveyNotificationProfile {
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
  dynamic createdAt;
  DateTime? updatedAt;

  factory SurveyNotificationProfile.fromJson(Map<String, dynamic> json) =>
      SurveyNotificationProfile(
        id: json["id"],
        surveyNotificationId: json["survey_notification_id"],
        profileId: json["profile_id"],
        isViewed: json["is_viewed"],
        isLiked: json["is_liked"],
        createdAt: json["created_at"],
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "survey_notification_id": surveyNotificationId,
        "profile_id": profileId,
        "is_viewed": isViewed,
        "is_liked": isLiked,
        "created_at": createdAt,
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class SurveyNotificationQuestion {
  SurveyNotificationQuestion({
    this.id,
    this.surveyNotificationId,
    this.question,
    this.other,
    this.surveyNotificationOption,
    this.surveyNotificationAnswer,
  });

  int? id;
  int? surveyNotificationId;
  String? question;
  int? other;
  List<SurveyNotificationOption>? surveyNotificationOption;
  List<SurveyNotificationAnswer>? surveyNotificationAnswer;

  factory SurveyNotificationQuestion.fromJson(Map<String, dynamic> json) =>
      SurveyNotificationQuestion(
        id: json["id"],
        surveyNotificationId: json["survey_notification_id"],
        question: json["question"],
        other: json["other"],
        surveyNotificationOption: List<SurveyNotificationOption>.from(
            json["survey_notification_option"]
                .map((x) => SurveyNotificationOption.fromJson(x))),
        surveyNotificationAnswer: List<SurveyNotificationAnswer>.from(
            json["survey_notification_answer"]
                .map((x) => SurveyNotificationAnswer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "survey_notification_id": surveyNotificationId,
        "question": question,
        "other": other,
        "survey_notification_option": List<dynamic>.from(
            surveyNotificationOption!.map((x) => x.toJson())),
        "survey_notification_answer":
            List<dynamic>.from(surveyNotificationAnswer!.map((x) => x)),
      };
}

class SurveyNotificationOption {
  SurveyNotificationOption(
      {this.id,
      this.surveyNotificationId,
      this.surveyNotificationQuestionId,
      this.optionName,
      this.answerCount});

  int? id;
  int? surveyNotificationId;
  int? surveyNotificationQuestionId;
  String? optionName;
  int? answerCount;

  factory SurveyNotificationOption.fromJson(Map<String, dynamic> json) =>
      SurveyNotificationOption(
        id: json["id"],
        surveyNotificationId: json["survey_notification_id"],
        surveyNotificationQuestionId: json["survey_notification_question_id"],
        optionName: json["option_name"],
        answerCount: json["survey_notification_answer_count"],
        // answerCount:0
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "survey_notification_id": surveyNotificationId,
        "survey_notification_question_id": surveyNotificationQuestionId,
        "option_name": optionName,
        "survey_notification_answer_count": answerCount
      };
}

class SurveyNotificationAnswer {
  SurveyNotificationAnswer({
    this.questionId,
    this.answerId,
    this.optionId,
    this.other,
  });

  int? questionId;
  dynamic answerId;
  int? optionId;
  dynamic other;

  factory SurveyNotificationAnswer.fromJson(Map<String, dynamic> json) =>
      SurveyNotificationAnswer(
        questionId: json["id"],
        answerId: null,
        optionId: json['survey_notification_option_id'] == null
            ? -1
            : json['survey_notification_option_id'],
        other: json['other'].toString(),
      );

  Map<String, dynamic> toJson() => {
        "question_id": questionId,
        "answer_id": answerId,
        "option_id": optionId,
        "other": other,
      };
}
