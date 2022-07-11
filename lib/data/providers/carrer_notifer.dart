// ignore_for_file: prefer_is_empty

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:southwind/Models/career/careerModel.dart';
import 'package:southwind/Models/user_data.dart';
import 'package:southwind/data/providers/ValueFetcher/UserFetch.dart';
import 'package:southwind/data/providers/base_notifer.dart';

class CareerProvider extends BaseNotifier {
  UserData? userData;
  CareerModel careerModel = CareerModel();
  // carre path
  // List<CareerPath> dropDownCareerPath = [];
  CareerPath selectedCareerPath = CareerPath(name: "Not data found");
  int selectedCareerPathIndex = 0;
  int selectedNewCareerpathIndex = -1;
  // achievement
  List<CareerAchievement> allSelectedCareerPath = [];
  List<CareerAchievement> newAchievement = [];
  List<CareerAchievement> submittedAchievement = [];
  List<CareerAchievement> completedAchievement = [];
  CareerAchievement selectedAchievement =
      CareerAchievement(careerPathNotificationAchievementQuestion: []);
  bool textReadibility = false;

  CareerProvider() {
    userData = UserFetch().fetchUserData();

    notifyListeners();
  }
  setReadibility(bool va) {
    textReadibility = va;

    notifyListeners();
  }

  Future getCareerQuestion() async {
    //log(userData!.teamId.toString());
    careerModel = CareerModel();
    final res = await dioClient.postWithFormData(apiEnd: api_career, data: {
      'team_id': userData!.teamId,
      // 'total_chat': 0,
      // 'is_admin': userData!.adminUserId,
      // 'logProfile': "",
      // 'franchiseuser_detail': "",
      // 'questions': "",
    });

    careerModel = CareerModel.fromJson(res.data["notifications"]);
    careerModel.careerPath
        ?.removeWhere((element) => element.teamId != userData!.teamId);
    if (careerModel.careerPath!.length > 0) {
      for (int i = 0; i < careerModel.careerPath!.length; i++) {
        if (careerModel.careerPath![i].current == 1) {
          selectedCareerPathIndex = i;
          selectedCareerPath = careerModel.careerPath![i];
        }
      }
    }

    await categorizedData();
    notifyListeners();
  }

  Future categorizedData() async {
    // dropDown data

    await getAchievementWisely();
    notifyListeners();
  }

  setIndexAndPath(CareerPath careerPath, int index) {
    selectedCareerPath = careerPath;
    selectedCareerPathIndex = index;
    getAchievementWisely();
    notifyListeners();
  }

  getAchievementWisely() async {
    newAchievement = [];
    allSelectedCareerPath = [];
    submittedAchievement = [];
    completedAchievement = [];

    final res = await dioClient.getRequest(
        apiEnd: api_career_single_career + selectedCareerPath.id.toString());

    if (res.data['careerpath'] != null) {
      allSelectedCareerPath = List<CareerAchievement>.from(res
          .data['careerpath']['career_path_notification_achievement']
          .map((x) => CareerAchievement.fromJson(x)));
      for (int i = 0; i < allSelectedCareerPath.length; i++) {
        if (allSelectedCareerPath[i].is_completed == 0 &&
            allSelectedCareerPath[i]
                    .careerPathNotificationAchievementQuestion!
                    .length >
                0) {
          if (allSelectedCareerPath[i].is_completed == 0 &&
              allSelectedCareerPath[i]
                      .careerPathNotificationAchievementQuestion!
                      .first
                      .careerPathNotificationAchievementAnswer!
                      .length >
                  0) {
            submittedAchievement.add(allSelectedCareerPath[i]);
          } else if (allSelectedCareerPath[i].is_completed == 0) {
            newAchievement.add(allSelectedCareerPath[i]);
          } else if (allSelectedCareerPath[i].is_completed == 1) {
            completedAchievement.add(allSelectedCareerPath[i]);
          }
        } else {
          if (allSelectedCareerPath[i].is_completed == 0) {
            newAchievement.add(allSelectedCareerPath[i]);
          } else if (allSelectedCareerPath[i].is_completed == 1) {
            completedAchievement.add(allSelectedCareerPath[i]);
          }
        }
      }

      notifyListeners();
    }
  }

  setAchievement(CareerAchievement careerAchievement) {
    selectedAchievement =
        CareerAchievement(careerPathNotificationAchievementQuestion: []);
    selectedAchievement = careerAchievement;
    notifyListeners();
  }

  updateAnswer(int index, int optionIndex) {
    // selectedAchievement
    //     .careerPathNotificationAchievementQuestion![index].answer = answer;
    // careerModel
    //     .questions![selectedCareerPath.id.toString()]![
    //         selectedAchievement.id.toString()]![index]
    //     .answer = answer;
    selectedAchievement
            .careerPathNotificationAchievementQuestion![index].optionId =
        selectedAchievement.careerPathNotificationAchievementQuestion![index]
            .options![optionIndex].id;

    selectedAchievement.careerPathNotificationAchievementQuestion![index]
        .options![optionIndex].score = selectedAchievement
            .careerPathNotificationAchievementQuestion![index]
            .options![optionIndex]
            .score! +
        1;
    notifyListeners();
  }

  Future<bool> submitAnswers() async {
    final questionAnser = jsonEncode(
        selectedAchievement.careerPathNotificationAchievementQuestion!.map((e) {
      return e.toAnswerJson();
    }).toList());
    final res = await dioClient
        .postWithFormData(apiEnd: api_career_submit_answer, data: {
      "achievement_id": selectedAchievement.id.toString(),
      // "team_id": userData!.teamId.toString(),
      //"client_id": userData!.id.toString(),
      //"is_admin": userData!.isAdmin.toString(),
      'feedback': "submit data",
      'submit_status': 1,
      'answers': questionAnser,
      'career_path_notification_id': selectedCareerPath.id
    });
    await getCareerQuestion();
    if (res != null) {
      return true;
    }

    return false;
  }

  Future<int> getScore() async {
    // int score = 0;
    // for (int a = 0;
    //     a <
    //         selectedAchievement
    //             .careerPathNotificationAchievementQuestion!.length;
    //     a++) {
    // final element =
    //     selectedAchievement.careerPathNotificationAchievementQuestion![a];

    // for (int j = 0; j < element.options!.length; j++) {
    //   if (element.options![j].id ==
    //       selectedAchievement
    //           .careerPathNotificationAchievementQuestion![a].optionId) {
    //     log(element.options![j].score.toString());
    //     score = score + element.options![j].score!;
    //     log("score =" + score.toString());
    //   }
    // }
    // }
    int score = -1;
    for (int i = 0; i < allSelectedCareerPath.length; i++) {
      if (allSelectedCareerPath[i].id == selectedAchievement.id) {
        selectedAchievement =
            CareerAchievement(careerPathNotificationAchievementQuestion: []);
        selectedAchievement = allSelectedCareerPath[i];
        score = allSelectedCareerPath[i].userAchievemnts!.first.score!;
      }
    }

    log("final score Is " + score.toString());
    // await Future.delayed(Duration(milliseconds: 100));
    return score;
  }
}
