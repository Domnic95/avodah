import 'dart:developer';

import 'package:southwind/Models/Incentive/EarnedIncentive.dart';
import 'package:southwind/Models/Incentive/HistroyIncentive.dart';
import 'package:southwind/Models/Incentive/new_incentive.dart';
import 'package:southwind/Models/Incentive/usedIncentive.dart';
import 'package:southwind/Models/Incentive/mostpopular.dart';
import 'package:southwind/Models/user_data.dart';
import 'package:southwind/data/providers/ValueFetcher/UserFetch.dart';
import 'package:southwind/data/providers/base_notifer.dart';

class IncentiveNotifier extends BaseNotifier {
  UserData? userData;
  MostPopularIncentive mostPopularIncentive = MostPopularIncentive();
  IncentiveHistroy incentiveHistroy = IncentiveHistroy();
  List<BadgesEarned> earnedIncentiveList = [];
  List<UsedIncentive> usedIncentiveList = [];
  NewIncentive newIncentives = NewIncentive();
  IncentiveNotifier() {
    userData = UserFetch().fetchUserData();
    notifyListeners();
  }
  Future mostopularIncentive() async {
    final res =
        await dioClient.postWithFormData(apiEnd: api_mostPopularIncentive);

    mostPopularIncentive = MostPopularIncentive.fromJson(res.data);
  }

  Future newIncentive() async {
    final res = await dioClient.postWithFormData(
        apiEnd: api_newIncentive, data: {"team_id": userData!.teamId});

    newIncentives = NewIncentive.fromJson(res.data);
  }

  Future usedIncentive() async {
    final res = await dioClient.getRequest(apiEnd: api_usedIncentive);

    usedIncentiveList = List<UsedIncentive>.from(
        res.data['notificationDetails'].map((x) => UsedIncentive.fromJson(x)));
  }

  Future incentiveHistrory() async {
    final res = await dioClient.getRequest(apiEnd: api_IncentiveHistory);

    incentiveHistroy = IncentiveHistroy.fromJson(res.data);
  }

  Future incentiveEarned() async {
    final res = await dioClient.getRequest(apiEnd: api_IncentiveEarned);
    earnedIncentiveList = List<BadgesEarned>.from(
        res.data['badgesEarned'].map((x) => BadgesEarned.fromJson(x)));
  }
}
