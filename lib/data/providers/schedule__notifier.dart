import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:southwind/Models/schedule/schedule_model.dart';
import 'package:southwind/Models/user_data.dart';
import 'package:southwind/data/providers/ValueFetcher/UserFetch.dart';
import 'package:southwind/data/providers/base_notifer.dart';
import 'package:southwind/utils/helpers.dart';

class ScheduleProvider extends BaseNotifier {
  UserData? userData;
  ScheduleModel scheduleModel = ScheduleModel();
  List<DateTime> schedule_dates = [];
  List<List<DateTime>> leaveDays_dates = [[], [], []];

  ScheduleProvider() {
    userData = UserFetch().fetchUserData();

    // initialize();
    notifyListeners();
  }
  // initialize() async {
  //   await getScheduleData();
  // }

  getScheduleData() async {
    // scheduleModel.profileSchedules!.clear();
    // scheduleModel.profileTimeOff!.clear();

    schedule_dates = [];
    leaveDays_dates = [[], [], []];
    List<DateTime> appliedLeave = [];
    List<DateTime> approvedLeave = [];
    List<DateTime> rejectedLeave = [];

    final res = await dioClient.getRequest(apiEnd: api_schedule);

    scheduleModel = ScheduleModel.fromJson(res.data['result']);
    for (int i = 0; i < scheduleModel.profileSchedules!.length; i++) {
      schedule_dates.add(scheduleModel.profileSchedules![i].day!);
    }
    for (int i = 0; i < scheduleModel.profileTimeOff!.length; i++) {
      if (scheduleModel.profileTimeOff![i].status == 0) {
        appliedLeave.add(scheduleModel.profileTimeOff![i].offDay!);
      } else if (scheduleModel.profileTimeOff![i].status == 1) {
        approvedLeave.add(scheduleModel.profileTimeOff![i].offDay!);
      } else {
        rejectedLeave.add(scheduleModel.profileTimeOff![i].offDay!);
      }
      // leaveDays_dates.add(scheduleModel.profileTimeOff![i].offDay!);
    }
    leaveDays_dates[0] = appliedLeave;
    leaveDays_dates[1] = approvedLeave;
    leaveDays_dates[2] = rejectedLeave;
    // print("datesssss ${leaveDays_dates[0]}");
    // print("datesssss ${leaveDays_dates[1]}");

    notifyListeners();
  }

  Future<List<int>> getSchedule(DateTime dateTime) async {
    List<int> scheduleIndex = [];

    for (int i = 0; i < scheduleModel.profileSchedules!.length; i++) {
      if (scheduleModel.profileSchedules![i].day == dateTime) {
        scheduleIndex.add(i);
      }
    }
    return scheduleIndex;
  }

  Future<ProfileTimeOff> getLeaveData(DateTime dateTime) async {
    late ProfileTimeOff loc;
    for (int i = 0; i < scheduleModel.profileTimeOff!.length; i++) {
      if (scheduleModel.profileTimeOff![i].offDay == dateTime) {
        loc = scheduleModel.profileTimeOff![i];
      }
    }
    return loc;
  }

  Future request(
      {required DateTime time,
      required String reason,
      required BuildContext context}) async {
    String date = time.year.toString() +
        "-" +
        time.month.toString() +
        "-" +
        time.day.toString();
    final res = await dioClient
        .postWithFormData(apiEnd: api_set_time_off_request, data: {
      'team_id': userData!.teamId,
      'req_message': reason,
      'off_date': date,
    });
    getScheduleData();
    showToast(res.data['message']);
    // log('dates $date');
    //  log('time $time');
  }
}
