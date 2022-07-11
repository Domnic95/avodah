import 'dart:convert';
import 'dart:developer';

import 'package:southwind/Models/learning/individual_learning.dart';
import 'package:southwind/Models/learning/learning_notification.dart';
import 'package:southwind/Models/user_data.dart';
import 'package:southwind/data/providers/ValueFetcher/UserFetch.dart';
import 'package:southwind/data/providers/base_notifer.dart';

class LearningNotifier extends BaseNotifier {
  UserData? userData;
  int? selectedLearningIndex;
  IndividualLearning? selectedLearning = IndividualLearning();
  List<LearningNotification> learningsList = [];
  List<LearningNotification> newLearnings = [];
  List<LearningNotification> submittedLearning = [];
  List<LearningNotification> compeletedLearning = [];
  bool textReadibility = false;
  LearningNotifier() {
    userData = UserFetch().fetchUserData();

    notifyListeners();
  } 
  setLearning(int index) {
    selectedLearningIndex = index;
    notifyListeners();
  }
 setReadibility(bool va) {
    textReadibility = va;
    
    notifyListeners();
  }
  Future getLearning() async {
    learningsList = [];
    newLearnings = [];
    compeletedLearning = [];
    submittedLearning = [];
    final res = await dioClient.getRequest(apiEnd: api_learning_get);
    
    learningsList = List<LearningNotification>.from(
        res.data["notifications"].map((x) => LearningNotification.fromJson(x)));
    for (int i = 0; i < learningsList.length; i++) {
      if (learningsList[i].notifyStatus == 0) {
        newLearnings.add(learningsList[i]);
      } else if (learningsList[i].notifyStatus == 1) {
        submittedLearning.add(learningsList[i]);
      } else {
        compeletedLearning.add(learningsList[i]);
      }
    }
    notifyListeners();
  }

  indiviualLearning() async {
    final res = await dioClient.getRequest(
        apiEnd: api_getIndividual_learning + selectedLearningIndex.toString());
    print("reso = ${res}");
    selectedLearning = IndividualLearning.fromJson(res.data['notification']);
    notifyListeners();
  }

  updateAnswer(int questionIndex, String _answer) async {
    selectedLearning!.learningNotificationQuestion![questionIndex].answer =
        _answer;
    notifyListeners();
  }

  Future<bool> submitAnswers() async {
    final questionAnser =
        jsonEncode(selectedLearning!.learningNotificationQuestion!.map((e) {
      return e.toAnswerJson();
    }).toList());
    log("answee" + questionAnser.toString());
    final res = await dioClient.postWithFormData(
        apiEnd: api_learning_submit_answer,
        data: {
          "notification_id": selectedLearning!.id.toString(),
          'answers': questionAnser
        });
    print(res);
    if (res != null) {
      return true;
    }

    return false;
  }
}
