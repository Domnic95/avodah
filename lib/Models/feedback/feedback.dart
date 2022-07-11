// To parse this JSON data, do
//
//     final feedbackModal = feedbackModalFromJson(jsonString);

import 'dart:convert';

FeedbackModal feedbackModalFromJson(String str) => FeedbackModal.fromJson(json.decode(str));

String feedbackModalToJson(FeedbackModal data) => json.encode(data.toJson());

class FeedbackModal {
    FeedbackModal({
        this.achivementTitle,
        this.adminFeedback,
        this.userFeedback,
        this.approve,
        this.careerPathUserAchivementId,
        this.profileId,
        this.careerPathNotificationAchievementId,
        this.careerPathNotificationId,
    });

    String? achivementTitle;
    String? adminFeedback;
    String? userFeedback;
    int? approve;
    int? careerPathUserAchivementId;
    int? profileId;
    int? careerPathNotificationAchievementId;
    int? careerPathNotificationId;

    factory FeedbackModal.fromJson(Map<String, dynamic> json) => FeedbackModal(
        achivementTitle: json["achivement_title"],
        adminFeedback: json["admin_feedback"],
        userFeedback: json["user_feedback"],
        approve: json["approve"],
        careerPathUserAchivementId: json["career_path_user_achivement_id"],
        profileId: json["profile_id"],
        careerPathNotificationAchievementId: json["career_path_notification_achievement_id"],
        careerPathNotificationId: json["career_path_notification_id"],
    );

    Map<String, dynamic> toJson() => {
        "achivement_title": achivementTitle,
        "admin_feedback": adminFeedback,
        "user_feedback": userFeedback,
        "approve": approve,
        "career_path_user_achivement_id": careerPathUserAchivementId,
        "profile_id": profileId,
        "career_path_notification_achievement_id": careerPathNotificationAchievementId,
        "career_path_notification_id": careerPathNotificationId,
    };
}
