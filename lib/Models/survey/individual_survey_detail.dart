// To parse this JSON data, do
//
//     final individualSurveyDetail = individualSurveyDetailFromJson(jsonString);

import 'dart:convert';

individualSurveyDetailToJson(IndividualSurveyDetail data) =>
    json.encode(data.toJson());

class IndividualSurveyDetail {
  IndividualSurveyDetail({
    this.id,
    this.title,
    this.notificationType,
    this.notificationUrl,
    this.secureUrl,
    this.sendTo,
    this.teamId,
    this.attachmentUrl,
    this.surveyDesc,
    this.createdOn,
    this.isResourceLibrary,
    this.resourceLibraryId,
    this.feedback,
    this.textResponse,
    this.options,
    this.gradePercentage,
    this.answered,
    this.submitStatus,
  });

  int? id;
  String? title;
  String? notificationType;
  String? notificationUrl;
  String? secureUrl;
  String? sendTo;
  int? teamId;
  dynamic attachmentUrl;
  String? surveyDesc;
  DateTime? createdOn;
  int? isResourceLibrary;
  int? resourceLibraryId;
  List<Feedback>? feedback;
  String? textResponse;
  List<Option>? options;
  int? gradePercentage;
  int? answered;
  int? submitStatus;

  factory IndividualSurveyDetail.fromJson(Map<String, dynamic> json) =>
      IndividualSurveyDetail(
        id: json["id"],
        title: json["title"],
        notificationType: json["notification_type"],
        notificationUrl: json["notification_url"],
        secureUrl: json["secure_url"],
        sendTo: json["send_to"],
        teamId: json["team_id"],
        attachmentUrl: json["attachment_url"],
        surveyDesc: json["survey_desc"],
        createdOn: DateTime.parse(json["created_on"]),
        isResourceLibrary: json["is_resource_library"],
        resourceLibraryId: json["resource_library_id"],
        feedback: List<Feedback>.from(
            json["feedback"].map((x) => Feedback.fromJson(x))),
        textResponse: json["text_response"],
        options:
            List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
        gradePercentage: json["grade_percentage"],
        answered: json["answered"],
        submitStatus: json["submit_status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "notification_type": notificationType,
        "notification_url": notificationUrl,
        "secure_url": secureUrl,
        "send_to": sendTo,
        "team_id": teamId,
        "attachment_url": attachmentUrl,
        "survey_desc": surveyDesc,
        "created_on": createdOn!.toIso8601String(),
        "is_resource_library": isResourceLibrary,
        "resource_library_id": resourceLibraryId,
        "feedback": List<dynamic>.from(feedback!.map((x) => x.toJson())),
        "text_response": textResponse,
        "options": List<dynamic>.from(options!.map((x) => x.toJson())),
        "grade_percentage": gradePercentage,
        "answered": answered,
        "submit_status": submitStatus,
      };
}

class Feedback {
  Feedback({
    this.feedback,
  });

  dynamic feedback;

  factory Feedback.fromJson(Map<String, dynamic> json) => Feedback(
        feedback: json["feedback"],
      );

  Map<String, dynamic> toJson() => {
        "feedback": feedback,
      };
}

class Option {
  Option({
    this.optionId,
    this.optionTitle,
    this.type,
    this.answerId,
    this.answer,
    this.submitStatus,
  });

  int? optionId;
  String? optionTitle;
  String? type;
  dynamic answerId;
  String? answer;
  String? submitStatus;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        optionId: json["option_id"],
        optionTitle: json["option_title"],
        type: json["type"],
        answerId: json["answer_id"],
        answer: json["answer"],
        submitStatus: json["submit_status"],
      );

  Map<String, dynamic> toJson() => {
        "option_id": optionId,
        "option_title": optionTitle,
        "type": type,
        "answer_id": answerId,
        "answer": answer,
        "submit_status": submitStatus,
      };
}
