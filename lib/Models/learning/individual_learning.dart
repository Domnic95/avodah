class IndividualLearning {
  IndividualLearning({
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
    this.questionCount,
    this.unseenCount,
    this.likesCount,
    this.firstName,
    this.lastName,
    this.userImage,
    this.liked,
    this.learningNotificationQuestion,
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
  int? questionCount;
  int? unseenCount;
  int? likesCount;
  String? firstName;
  String? lastName;
  String? userImage;
  bool? liked;
  List<LearningNotificationQuestion>? learningNotificationQuestion;
  List<LearningNotificationProfile>? learningNotificationProfiles;

  factory IndividualLearning.fromJson(Map<String, dynamic> json) =>
      IndividualLearning(
        id: json["id"],
        title: json["title"].toString(),
        notificationText: json["notification_text"].toString(),
        notificationUrl: json["notification_url"],
        sendTo: json["send_to"],
        teamId: json["team_id"],
        individualId: json["individual_id"],
        notifyOn: DateTime.parse(json["notify_on"]),
        resourceType: json["resource_type"],
        resourceUrl: json["resource_url"],
        resourceSecureUrl: json["resource_secure_url"],
        createdBy: json["created_by"],
        creatorGuard: json["creator_guard"].toString(),
        notifyStatus: json["notify_status"].toString(),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        commentCount: json["comment_count"],
        questionCount: json["question_count"],
        unseenCount: json["unseen_count"],
        likesCount: json["likes_count"],
        firstName: json["first_name"].toString(),
        lastName: json["last_name"].toString(),
        userImage: json["user_image"].toString(),
        liked: json["liked"],
        learningNotificationQuestion: List<LearningNotificationQuestion>.from(
            json["learning_notification_question"]
                .map((x) => LearningNotificationQuestion.fromJson(x))),
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
        "question_count": questionCount,
        "unseen_count": unseenCount,
        "likes_count": likesCount,
        "first_name": firstName,
        "last_name": lastName,
        "user_image": userImage,
        "liked": liked,
        "learning_notification_question": List<dynamic>.from(
            learningNotificationQuestion!.map((x) => x.toJson())),
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

class LearningNotificationQuestion {
  LearningNotificationQuestion({
    this.id,
    this.learningNotificationId,
    this.question,
    this.createdAt,
    this.updatedAt,
    this.learningNotificationAnswer,
    this.answer,
  });

  int? id;
  int? learningNotificationId;
  String? question;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<LearningAnswer>? learningNotificationAnswer;
  String? answer;

  factory LearningNotificationQuestion.fromJson(Map<String, dynamic> json) =>
      LearningNotificationQuestion(
          id: json["id"],
          learningNotificationId: json["learning_notification_id"],
          question: json["question"],
          createdAt: DateTime.parse(json["created_at"]),
          updatedAt: DateTime.parse(json["updated_at"]),
          learningNotificationAnswer: List<LearningAnswer>.from(
              json["learning_notification_answer"]
                  .map((x) => LearningAnswer.fromJson(x))),
          answer: "");

  Map<String, dynamic> toJson() => {
        "id": id,
        "learning_notification_id": learningNotificationId,
        "question": question,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "learning_notification_answer":
            List<dynamic>.from(learningNotificationAnswer!.map((x) => x)),
      };
  Map<String, dynamic> toAnswerJson() => {
        "question_id": id,
        "answer_id": null,
        "answer": answer
        //
      };
}

class LearningAnswer {
  LearningAnswer({
    this.id,
    this.learningNotificationId,
    this.learningNotificationQuestionId,
    this.profileId,
    this.answer,
    this.answerStatus,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? learningNotificationId;
  int? learningNotificationQuestionId;
  int? profileId;
  String? answer;
  dynamic answerStatus;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory LearningAnswer.fromJson(Map<String, dynamic> json) => LearningAnswer(
        id: json["id"],
        learningNotificationId: json["learning_notification_id"],
        learningNotificationQuestionId:
            json["learning_notification_question_id"],
        profileId: json["profile_id"],
        answer: json["answer"],
        answerStatus: json["answer_status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "learning_notification_id": learningNotificationId,
        "learning_notification_question_id": learningNotificationQuestionId,
        "profile_id": profileId,
        "answer": answer,
        "answer_status": answerStatus,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
