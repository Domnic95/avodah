import 'dart:convert';
// To parse this JSON data, do
//
//     final careerModel = careerModelFromJson(jsonString);

import 'dart:convert';

import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';

CareerModel careerModelFromJson(String str) =>
    CareerModel.fromJson(json.decode(str));

String careerModelToJson(CareerModel data) => json.encode(data.toJson());

class CareerModel {
  CareerModel({
    this.careerPath,
    // this.careerAchievements,
  });

  List<CareerPath>? careerPath = [];
  // List<CareerAchievement>? careerAchievements = [];

  factory CareerModel.fromJson(Map<String, dynamic> json) {
    Set<CareerPath> path = {};
    for (int a = 0; a < json["careerpath"].length; a++) {
      path.add(CareerPath.fromJson(json["careerpath"][a]));
    }

    return CareerModel(
        // careerPath: List<CareerPath>.from(
        //     json["careerpath"].map((x) => CareerPath.fromJson(x))),
        careerPath: path.toList()
        // careerAchievements: List<CareerAchievement>.from(
        //     json["acheivements"].map((x) => CareerAchievement.fromJson(x))),
        );
  }

  Map<String, dynamic> toJson() => {
        "careerpath": List<dynamic>.from(careerPath!.map((x) => x.toJson())),
        // "acheivements":
        //     List<dynamic>.from(careerAchievements!.map((x) => x.toJson())),
      };
}

class CareerAchievement {
  CareerAchievement(
      {this.id,
      this.careerPathNotificationId,
      this.teamId,
      this.createdBy,
      this.name,
      this.description,
      this.attachmentUrl,
      this.cloudinaryId,
      this.cloudinaryUrl,
      this.cloudinarySecureUrl,
      this.createdAt,
      this.updatedAt,
      this.careerPathNotificationAchievementQuestion,
      this.is_completed,
      this.userAchievemnts});

  int? id;
  int? careerPathNotificationId;
  int? teamId;
  int? createdBy;
  String? name;
  String? description;
  dynamic attachmentUrl;
  String? cloudinaryId;
  String? cloudinaryUrl;
  String? cloudinarySecureUrl;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? is_completed;
  List<CareerPathNotificationAchievementQuestion>?
      careerPathNotificationAchievementQuestion;
  List<UserAchievement>? userAchievemnts;

  factory CareerAchievement.fromJson(Map<String, dynamic> json) =>
      CareerAchievement(
        id: json["id"],
        careerPathNotificationId: json["career_path_notification_id"],
        teamId: json["team_id"],
        createdBy: json["created_by"],
        name: json["name"],
        description: json["description"],
        attachmentUrl: json["attachment_url"],
        cloudinaryId: json["cloudinaryId"],
        cloudinaryUrl: json["cloudinaryUrl"],
        cloudinarySecureUrl: json["cloudinarySecureUrl"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        is_completed: json['is_completed'],
        careerPathNotificationAchievementQuestion:
            List<CareerPathNotificationAchievementQuestion>.from(
                json["career_path_notification_achievement_question"].map((x) =>
                    CareerPathNotificationAchievementQuestion.fromJson(x))),
        userAchievemnts: List<UserAchievement>.from(
            json["career_path_notification_user_achievement"]
                .map((x) => UserAchievement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "career_path_notification_id": careerPathNotificationId,
        "team_id": teamId,
        "created_by": createdBy,
        "name": name,
        "description": description,
        "attachment_url": attachmentUrl,
        "cloudinaryId": cloudinaryId,
        "cloudinaryUrl": cloudinaryUrl,
        "cloudinarySecureUrl": cloudinarySecureUrl,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "career_path_notification_achievement_question": List<dynamic>.from(
            careerPathNotificationAchievementQuestion!.map((x) => x.toJson())),
      };
}

class CareerPathNotificationAchievementQuestion {
  CareerPathNotificationAchievementQuestion({
    this.id,
    this.careerPathNotificationAchievementId,
    this.question,
    this.createdAt,
    this.updatedAt,
    this.careerPathNotificationAchievementAnswer,
    this.options,
  });

  int? id;
  int? careerPathNotificationAchievementId;
  String? question;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? optionId = -1;
  List<CareerOption>? options;

  List<CareerAnswer>? careerPathNotificationAchievementAnswer;

  factory CareerPathNotificationAchievementQuestion.fromJson(
      Map<String, dynamic> json) {
    log('questionAnser ${json["id"]}');
    return CareerPathNotificationAchievementQuestion(
        id: json["id"],
        careerPathNotificationAchievementId:
            json["career_path_notification_achievement_id"],
        question: json["question"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        // answerId: json["career_path_notification_achievement_answer"][0]['id'],
        // ? json["career_path_notification_achievement_answer"][0]['id']
        // : null,
        // answer: json["career_path_notification_achievement_answer"].length > 0
        //     ? json["career_path_notification_achievement_answer"][0]['answer']
        //     : null,
        careerPathNotificationAchievementAnswer: List<CareerAnswer>.from(
            json["career_path_notification_achievement_answer"]
                .map((x) => CareerAnswer.fromJson(x))),
        options: List<CareerOption>.from(
            json["options"].map((x) => CareerOption.fromJson(x))));
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "career_path_notification_achievement_id":
            careerPathNotificationAchievementId,
        "question": question,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "career_path_notification_achievement_answer": List<dynamic>.from(
            careerPathNotificationAchievementAnswer!.map((x) => x)),
      };
  Map<String, dynamic> toAnswerJson() => {
        "question_id": id,
        "answer_id": careerPathNotificationAchievementAnswer!.length > 0
            ? careerPathNotificationAchievementAnswer![0].id
            : null,
        "option_id": optionId
      };
}

class CareerOption {
  CareerOption({
    this.id,
    this.optionName,
    this.score,
    this.careerPathNotificationAchievementQuestionId,
  });

  int? id;
  String? optionName;
  int? score;
  int? careerPathNotificationAchievementQuestionId;

  factory CareerOption.fromJson(Map<String, dynamic> json) => CareerOption(
        id: json["id"],
        optionName: json["option_name"],
        score: json["score"],
        careerPathNotificationAchievementQuestionId:
            json["career_path_notification_achievement_question_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "option_name": optionName,
        "score": score,
        "career_path_notification_achievement_question_id":
            careerPathNotificationAchievementQuestionId,
      };
}

class CareerAnswer {
  CareerAnswer(
      {this.id,
      this.careerPathNotificationAchievementId,
      this.careerPathNotificationAchievementQuestionId,
      this.profileId,
      this.answer,
      this.answerStatus,
      this.createdAt,
      this.updatedAt,
      this.score,
      this.selectedAnswerId});

  int? id;
  int? careerPathNotificationAchievementId;
  int? careerPathNotificationAchievementQuestionId;
  int? profileId;
  String? answer;
  dynamic answerStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? score;
  int? selectedAnswerId;

  factory CareerAnswer.fromJson(Map<String, dynamic> json) => CareerAnswer(
        id: json["id"],
        careerPathNotificationAchievementId:
            json["career_path_notification_achievement_id"],
        careerPathNotificationAchievementQuestionId:
            json["career_path_notification_achievement_question_id"],
        profileId: json["profile_id"],
        answer: json["answer"],
        selectedAnswerId:
            json['career_path_notification_achievement_option_id'],
        answerStatus: json["answer_status"],
        score: json['score'],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "career_path_notification_achievement_id":
            careerPathNotificationAchievementId,
        "career_path_notification_achievement_question_id":
            careerPathNotificationAchievementQuestionId,
        "profile_id": profileId,
        "answer": answer,
        "answer_status": answerStatus,
        "score": score,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class CareerPath {
  CareerPath({
    this.id,
    this.name = "null",
    this.teamId,
    this.current,
  });

  int? id;
  String? name = "null";
  int? teamId;
  int? current;

  factory CareerPath.fromJson(Map<String, dynamic> json) => CareerPath(
        id: json["id"],
        name: json["name"],
        teamId: json["team_id"],
        current: json["current"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "team_id": teamId,
        "current": current,
      };
  @override
  int get hashCode => this.id!;

  @override
  bool operator ==(Object any) {
    return any is CareerPath && any.id == this.id;
  }
}

// To parse this JSON data, do
//
//     final userAchievement = userAchievementFromJson(jsonString);

UserAchievement userAchievementFromJson(String str) =>
    UserAchievement.fromJson(json.decode(str));

String userAchievementToJson(UserAchievement data) =>
    json.encode(data.toJson());

class UserAchievement {
  UserAchievement({
    required this.id,
    this.profileId,
    this.careerPathNotificationAchievementId,
    this.careerPathNotificationId,
    this.completeStatus,
    this.feedback,
    this.needAdminRes,
    this.achievedDate,
    this.userFeedback,
    this.submitStatus,
    this.score,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int? profileId;
  int? careerPathNotificationAchievementId;
  int? careerPathNotificationId;
  int? completeStatus;
  String? feedback;
  int? needAdminRes;
  DateTime? achievedDate;
  String? userFeedback;
  int? submitStatus;
  int? score;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory UserAchievement.fromJson(Map<String, dynamic> json) =>
      UserAchievement(
        id: json["id"],
        profileId: json["profile_id"],
        careerPathNotificationAchievementId:
            json["career_path_notification_achievement_id"],
        careerPathNotificationId: json["career_path_notification_id"],
        completeStatus: json["complete_status"],
        feedback: json["feedback"],
        needAdminRes: json["need_admin_res"],
        achievedDate: DateTime.parse(json["achieved_date"]),
        userFeedback: json["user_feedback"],
        submitStatus: json["submit_status"],
        score: json["score"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "profile_id": profileId,
        "career_path_notification_achievement_id":
            careerPathNotificationAchievementId,
        "career_path_notification_id": careerPathNotificationId,
        "complete_status": completeStatus,
        "feedback": feedback,
        "need_admin_res": needAdminRes,
        "achieved_date": achievedDate?.toIso8601String(),
        "user_feedback": userFeedback,
        "submit_status": submitStatus,
        "score": score,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}


// class CareerModel {
//   CareerModel({
//     this.careerPath,
//     this.careerId,
//     this.careerAchievements,
//     this.questions,
//     this.countArray,
//     this.mycount,
//   });

//   List<CareerPath>? careerPath;
//   List<int>? careerId;
//   Map<String, List<CareerAchievement>>? careerAchievements;
//   Map<String, Map<String, List<Question>>>? questions;
//   Map<String, CountArray>? countArray;
//   Map<String, Mycount>? mycount;

//   factory CareerModel.fromJson(Map<String, dynamic> json) => CareerModel(
//         careerPath: List<CareerPath>.from(
//             json["career_path"].map((x) => CareerPath.fromJson(x))),
//         careerId: List<int>.from(json["career_id"].map((x) => x)),
//         careerAchievements: Map.from(json["career_achievements"]).map((k, v) =>
//             MapEntry<String, List<CareerAchievement>>(
//                 k,
//                 List<CareerAchievement>.from(
//                     v.map((x) => CareerAchievement.fromJson(x))))),
//         questions: Map.from(json["questions"]).map((k, v) =>
//             MapEntry<String, Map<String, List<Question>>>(
//                 k,
//                 Map.from(v).map((k, v) => MapEntry<String, List<Question>>(k,
//                     List<Question>.from(v.map((x) => Question.fromJson(x))))))),
//         countArray: Map.from(json["countArray"]).map(
//             (k, v) => MapEntry<String, CountArray>(k, CountArray.fromJson(v))),
//         mycount: Map.from(json["mycount"])
//             .map((k, v) => MapEntry<String, Mycount>(k, Mycount.fromJson(v))),
//       );

//   Map<String, dynamic> toJson() => {
//         "career_path": List<dynamic>.from(careerPath!.map((x) => x.toJson())),
//         "career_id": List<dynamic>.from(careerId!.map((x) => x)),
//         "career_achievements": Map.from(careerAchievements!).map((k, v) =>
//             MapEntry<String, dynamic>(
//                 k, List<dynamic>.from(v.map((x) => x.toJson())))),
//         "questions": Map.from(questions!).map((k, v) =>
//             MapEntry<String, dynamic>(
//                 k,
//                 Map.from(v).map((k, v) => MapEntry<String, dynamic>(
//                     k, List<dynamic>.from(v.map((x) => x.toJson())))))),
//         "countArray": Map.from(countArray!)
//             .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
//         "mycount": Map.from(mycount!)
//             .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
//       };
// }

// class CareerAchievement {
//   CareerAchievement({
//     this.id,
//     this.careerId,
//     this.achievements,
//     this.achievementType,
//     this.achievementDesc,
//     this.attachmentUrl,
//     this.isResourceLibrary,
//     this.resourceLibraryId,
//     this.cloudinaryId,
//     this.cloudinaryUrl,
//     this.cloudinarySecureUrl,
//     this.createdBy,
//     this.adminUserId,
//     this.lastModified,
//     this.position,
//     this.resourceType,
//     this.teamId,
//     this.resourceVideoLink,
//     this.cloudinaryAudioSecureUrl,
//     this.feedback,
//     this.achived,
//     this.submitStatus,
//     this.newCreatedOn,
//   });

//   int? id;
//   int? careerId;
//   String? achievements;
//   AchievementType? achievementType;
//   String? achievementDesc;
//   String? attachmentUrl;
//   int? isResourceLibrary;
//   int? resourceLibraryId;
//   String? cloudinaryId;
//   String? cloudinaryUrl;
//   String? cloudinarySecureUrl;
//   int? createdBy;
//   int? adminUserId;
//   DateTime? lastModified;
//   String? position;
//   dynamic resourceType;
//   int? teamId;
//   String? resourceVideoLink;
//   String? cloudinaryAudioSecureUrl;
//   String? feedback;
//   String? achived;
//   dynamic submitStatus;
//   String? newCreatedOn;

//   factory CareerAchievement.fromJson(Map<String, dynamic> json) =>
//       CareerAchievement(
//         id: json["id"],
//         careerId: json["career_id"],
//         achievements: json["achievements"],
//         achievementType: achievementTypeValues.map[json["achievement_type"]],
//         achievementDesc: json["achievement_desc"],
//         attachmentUrl: json["attachment_url"],
//         isResourceLibrary: json["is_resource_library"],
//         resourceLibraryId: json["resource_library_id"],
//         cloudinaryId: json["cloudinaryId"],
//         cloudinaryUrl:
//             json["cloudinaryUrl"] == null ? null : json["cloudinaryUrl"],
//         cloudinarySecureUrl: json["cloudinarySecureUrl"],
//         createdBy: json["created_by"],
//         adminUserId: json["admin_user_id"],
//         lastModified: DateTime.parse(json["last_modified"]),
//         position: json["position"],
//         resourceType: json["resource_type"],
//         teamId: json["team_id"],
//         resourceVideoLink: json["resource_video_link"] == null
//             ? null
//             : json["resource_video_link"],
//         cloudinaryAudioSecureUrl: json["cloudinaryAudioSecureUrl"] == null
//             ? null
//             : json["cloudinaryAudioSecureUrl"],
//         feedback: json["feedback"] == null ? null : json["feedback"],
//         achived: json["achived"],
//         submitStatus: json["submit_status"],
//         newCreatedOn:
//             json["new_created_on"] == null ? null : json["new_created_on"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "career_id": careerId,
//         "achievements": achievements,
//         "achievement_type": achievementTypeValues.reverse[achievementType],
//         "achievement_desc": achievementDesc,
//         "attachment_url": attachmentUrl,
//         "is_resource_library": isResourceLibrary,
//         "resource_library_id": resourceLibraryId,
//         "cloudinaryId": cloudinaryId,
//         "cloudinaryUrl": cloudinaryUrl == null ? null : cloudinaryUrl,
//         "cloudinarySecureUrl": cloudinarySecureUrl,
//         "created_by": createdBy,
//         "admin_user_id": adminUserId,
//         "last_modified": lastModified!.toIso8601String(),
//         "position": position,
//         "resource_type": resourceType,
//         "team_id": teamId,
//         "resource_video_link":
//             resourceVideoLink == null ? null : resourceVideoLink,
//         "cloudinaryAudioSecureUrl":
//             cloudinaryAudioSecureUrl == null ? null : cloudinaryAudioSecureUrl,
//         "feedback": feedback == null ? null : feedback,
//         "achived": achived,
//         "submit_status": submitStatus,
//         "new_created_on": newCreatedOn == null ? null : newCreatedOn,
//       };
// }

// enum AchievementType { NEW, RESOURCE_LIBRARY }

// final achievementTypeValues = EnumValues({
//   "new": AchievementType.NEW,
//   "resourceLibrary": AchievementType.RESOURCE_LIBRARY
// });

// class CareerPath {
//   CareerPath({
//     this.id,
//     this.careerPath,
//     this.completed,
//     this.teamId,
//   });

//   int? id;
//   String? careerPath;
//   dynamic completed;
//   dynamic teamId;

//   factory CareerPath.fromJson(Map<String, dynamic> json) => CareerPath(
//         id: json["id"],
//         careerPath: json["career_path"],
//         completed: json["completed"],
//         teamId: json["team_id"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "career_path": careerPath,
//         "completed": completed,
//         "team_id": teamId,
//       };
// }

// class CountArray {
//   CountArray({
//     this.currentCount,
//     this.submitCount,
//     this.completeCount,
//   });

//   int? currentCount;
//   int? submitCount;
//   int? completeCount;

//   factory CountArray.fromJson(Map<String, dynamic> json) => CountArray(
//         currentCount: json["currentCount"],
//         submitCount: json["submitCount"],
//         completeCount: json["completeCount"],
//       );

//   Map<String, dynamic> toJson() => {
//         "currentCount": currentCount,
//         "submitCount": submitCount,
//         "completeCount": completeCount,
//       };
// }

// class Mycount {
//   Mycount({
//     this.initial,
//     this.save,
//     this.submit,
//     this.completed,
//   });

//   int? initial;
//   int? save;
//   int? submit;
//   int? completed;

//   factory Mycount.fromJson(Map<String, dynamic> json) => Mycount(
//         initial: json["initial"],
//         save: json["save"],
//         submit: json["submit"],
//         completed: json["completed"],
//       );

//   Map<String, dynamic> toJson() => {
//         "initial": initial,
//         "save": save,
//         "submit": submit,
//         "completed": completed,
//       };
// }

// class Question {
//   Question({
//     this.queId,
//     this.question,
//     this.ansId,
//     this.answer,
//   });

//   int? queId;
//   String? question;
//   int? ansId;
//   String? answer;

//   factory Question.fromJson(Map<String, dynamic> json) => Question(
//         queId: json["que_id"],
//         question: json["question"],
//         ansId: json["ans_id"] == null ? null : json["ans_id"],
//         answer: json["answer"],
//       );

//   Map<String, dynamic> toJson() => {
//         "que_id": queId,
//         "question": question,
//         "ans_id": ansId == null ? null : ansId,
//         "answer": answer,
//       };
// }

// class EnumValues<T> {
//   Map<String, T> map;
//   Map<T, String>? reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap!;
//   }
// }
