import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:southwind/Models/survey/basic_survey_details.dart';
import 'package:southwind/Models/survey/individual_survey.dart';
import 'package:southwind/Models/survey/surveyModel.dart';
import 'package:southwind/Models/user_data.dart';
import 'package:southwind/data/providers/ValueFetcher/UserFetch.dart';
import 'package:southwind/data/providers/base_notifer.dart';
import 'package:southwind/utils/helpers.dart';
class SurveyProvider extends BaseNotifier {
  UserData? userData;
  String selectedSurveyId = '';
  List<LibraryNotification> allSurvey = [];
  IndividualSurvey? selectedSurvey = IndividualSurvey();
  bool textReadibility = false;
  bool reloadData = false;
  List<LibraryNotification> newSurvey = [];
  List<LibraryNotification> submittedSurvey = [];
  int offset = 0;
  int limit = offsetDifference;
  bool lazyLoading = true;
  int maxFeedFromServer = 0;
  SurveyProvider() {
    userData = UserFetch().fetchUserData();

    notifyListeners();
  }
  setSurveyId(int id) {
    selectedSurveyId = id.toString();
    notifyListeners();
  }

  // setSurvey(LibraryNotification survey) {
  //   selectedSurvey = survey;
  //   notifyListeners();
  // }

  setReadibility(bool va) {
    textReadibility = va;

    notifyListeners();
  }

  // Future getallSurvey() async {
  //   final res = await dioClient.postWithFormData(apiEnd: api_getSurvey, data: {
  //     'selected_additional_team_id': 2,
  //     'team_id': userData?.teamId,
  //     'is_admin': userData?.isAdmin,
  //     'notification_type': 'survey'
  //   });

  //   allSurvey = List<BasicSurveyDetail>.from(res.data['profile_details']
  //           ['survey']
  //       .map((x) => BasicSurveyDetail.fromJson(x)));
  // }
  reload() async {
    if (reloadData) {
      await suveryNotification();
      notifyListeners();
    }
  }

  Future suveryNotification() async {
    allSurvey = [];
    newSurvey = [];

    submittedSurvey = [];
    offset = 0;
    limit = offsetDifference;
    final res = await dioClient.getRequest(
      apiEnd: api_getSurveyNotification,
      queryParameter: {'limit': limit, "offset": offset},
    );

    allSurvey = List<LibraryNotification>.from(
        res.data["notifications"].map((x) => LibraryNotification.fromJson(x)));
    maxFeedFromServer = res.data["notification_count"];
    for (int i = 0; i < allSurvey.length; i++) {
      if (allSurvey[i].submitted!) {
        submittedSurvey.add(allSurvey[i]);
      } else {
        newSurvey.add(allSurvey[i]);
      }

      reloadData = false;
      lazyLoading = true;
    }
    // print('survey data ${submittedSurvey.length}');
    // print('survey data ${newSurvey.length}');
    // notifyListeners();
  }

  Future individualSurvey() async {
    final res = await dioClient.getRequest(
        apiEnd: api_getIndividualSurvey + selectedSurveyId);

    selectedSurvey = IndividualSurvey.fromJson(res.data['notification']);

    notifyListeners();
  }

  updateAnswer(int questionIndex, String notes, int optionIndex) {
    log("notres" + notes);
    selectedSurvey!.surveyAnswer![questionIndex].optionId = selectedSurvey!
        .surveyNotificationQuestion![questionIndex]
        .surveyNotificationOption![optionIndex]
        .id!;
    selectedSurvey!.surveyNotificationQuestion![questionIndex]
        .surveyNotificationOption![optionIndex].answerCount = selectedSurvey!
            .surveyNotificationQuestion![questionIndex]
            .surveyNotificationOption![optionIndex]
            .answerCount! +
        1;
    selectedSurvey!.surveyAnswer![questionIndex].other = notes;

    notifyListeners();
  }

  updateNotes(int questionIndex, String notes) {
    selectedSurvey!.surveyAnswer![questionIndex].other = notes;
    notifyListeners();
  }

  Future<bool> submitAnswers() async {
    final questionAnser = jsonEncode(selectedSurvey!.surveyAnswer!.map((e) {
      return e.toJson();
    }).toList());
    log('ressss = ${questionAnser}');
    final res = await dioClient.postWithFormData(
        apiEnd: api_submitSurveyAnswer,
        data: {
          "notification_id": selectedSurvey!.id,
          "answers": questionAnser
        });
    reloadData = true;
    notifyListeners();
    if (res != null) {
      return true;
    }

    return false;
  }

  Future lazyData() async {
    List<LibraryNotification> local = [];
    List<LibraryNotification> _new = [];
    List<LibraryNotification> _submitted = [];
    if (maxFeedFromServer > offset) {
      offset = limit;
      limit = limit + offsetDifference;
      Response res = await dioClient.getRequest(
        apiEnd: api_communication_get_notification,
        queryParameter: {'limit': limit, "offset": offset},
      );

      local = List<LibraryNotification>.from(res.data["notifications"]
          .map((x) => LibraryNotification.fromJson(x)));
      for (int i = 0; i < local.length; i++) {
        if (local[i].submitted!) {
          _submitted.add(local[i]);
        } else {
          _new.add(local[i]);
        }
      }
      // total_news.addAll(local);
      newSurvey.addAll(_new);
      submittedSurvey.addAll(_submitted);
      notifyListeners();
    } else {
      lazyLoading = false;
      notifyListeners();
    }
  }
}
