// To parse this JSON data, do
//
//     final basicSurveyDetail = basicSurveyDetailFromJson(jsonString);

import 'dart:convert';

BasicSurveyDetail basicSurveyDetailFromJson(String str) =>
    BasicSurveyDetail.fromJson(json.decode(str));

String basicSurveyDetailToJson(BasicSurveyDetail data) =>
    json.encode(data.toJson());

class BasicSurveyDetail {
  BasicSurveyDetail({
    this.id,
    this.title,
    this.notificationText,
    this.notificationType,
    this.notificationUrl,
    this.learningDesc,
    this.attachmentUrl,
    this.sendTo,
    this.teamId,
    this.individualId,
    this.notifyOn,
    this.questionOne,
    this.questionTwo,
    this.questionThree,
    this.publicId,
    this.isResourceLibrary,
    this.resourceLibraryId,
    this.resourceType,
    this.url,
    this.secureUrl,
    this.format,
    this.createdOn,
    this.createdBy,
    this.adminUserId,
    this.lastModified,
    this.maxBadge,
    this.surveyType,
    this.surveyExpireDate,
    this.textResponse,
    this.profileId,
    this.creatorId,
    this.badges,
    this.viewed,
    this.readStatus,
    this.surveyStatus,
    this.needAdminRes,
    this.gradePercentage,
    this.notificationId,
    this.today,
    this.newCreatedOn,
    this.expireDate,
    this.daysOfDiff,
  });

  int? id;
  String? title;
  String? notificationText;
  String? notificationType;
  String? notificationUrl;
  dynamic learningDesc;
  dynamic attachmentUrl;
  String? sendTo;
  int? teamId;
  int? individualId;
  dynamic notifyOn;
  dynamic questionOne;
  dynamic questionTwo;
  dynamic questionThree;
  dynamic publicId;
  int? isResourceLibrary;
  int? resourceLibraryId;
  dynamic resourceType;
  String? url;
  String? secureUrl;
  dynamic format;
  DateTime? createdOn;
  int? createdBy;
  int? adminUserId;
  DateTime? lastModified;
  int? maxBadge;
  int? surveyType;
  dynamic surveyExpireDate;
  String? textResponse;
  int? profileId;
  int? creatorId;
  int? badges;
  int? viewed;
  int? readStatus;
  int? surveyStatus;
  int? needAdminRes;
  int? gradePercentage;
  int? notificationId;
  String? today;
  DateTime? newCreatedOn;
  DateTime? expireDate;
  int? daysOfDiff;

  factory BasicSurveyDetail.fromJson(Map<String, dynamic> json) =>
      BasicSurveyDetail(
        id: json["id"],
        title: json["title"],
        notificationText: json["notification_text"],
        notificationType: json["notification_type"],
        notificationUrl: json["notification_url"],
        learningDesc: json["learning_desc"],
        attachmentUrl: json["attachment_url"],
        sendTo: json["send_to"],
        teamId: json["team_id"],
        individualId: json["individual_id"],
        notifyOn: json["notify_on"],
        questionOne: json["question_one"],
        questionTwo: json["question_two"],
        questionThree: json["question_three"],
        publicId: json["public_id"],
        isResourceLibrary: json["is_resource_library"],
        resourceLibraryId: json["resource_library_id"],
        resourceType: json["resource_type"],
        url: json["url"],
        secureUrl: json["secure_url"],
        format: json["format"],
        createdOn: DateTime.parse(json["created_on"]),
        createdBy: json["created_by"],
        adminUserId: json["admin_user_id"],
        lastModified: DateTime.parse(json["last_modified"]),
        maxBadge: json["max_badge"],
        surveyType: json["survey_type"],
        surveyExpireDate: json["survey_expire_date"],
        textResponse: json["text_response"],
        profileId: json["profile_id"],
        creatorId: json["creator_id"],
        badges: json["badges"],
        viewed: json["viewed"],
        readStatus: json["read_status"],
        surveyStatus: json["survey_status"],
        needAdminRes: json["need_admin_res"],
        gradePercentage: json["grade_percentage"],
        notificationId: json["notification_id"],
        today: json["today"],
        newCreatedOn: DateTime.parse(json["new_created_on"]),
        expireDate: DateTime.parse(json["expire_date"]),
        daysOfDiff: json["days_of_diff"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "notification_text": notificationText,
        "notification_type": notificationType,
        "notification_url": notificationUrl,
        "learning_desc": learningDesc,
        "attachment_url": attachmentUrl,
        "send_to": sendTo,
        "team_id": teamId,
        "individual_id": individualId,
        "notify_on": notifyOn,
        "question_one": questionOne,
        "question_two": questionTwo,
        "question_three": questionThree,
        "public_id": publicId,
        "is_resource_library": isResourceLibrary,
        "resource_library_id": resourceLibraryId,
        "resource_type": resourceType,
        "url": url,
        "secure_url": secureUrl,
        "format": format,
        "created_on": createdOn!.toIso8601String(),
        "created_by": createdBy,
        "admin_user_id": adminUserId,
        "last_modified": lastModified!.toIso8601String(),
        "max_badge": maxBadge,
        "survey_type": surveyType,
        "survey_expire_date": surveyExpireDate,
        "text_response": textResponse,
        "profile_id": profileId,
        "creator_id": creatorId,
        "badges": badges,
        "viewed": viewed,
        "read_status": readStatus,
        "survey_status": surveyStatus,
        "need_admin_res": needAdminRes,
        "grade_percentage": gradePercentage,
        "notification_id": notificationId,
        "today": today,
        "new_created_on": newCreatedOn!.toIso8601String(),
        "expire_date": expireDate!.toIso8601String(),
        "days_of_diff": daysOfDiff,
      };
}
