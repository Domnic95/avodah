import 'package:southwind/Models/Timer/timer_card.dart';
import 'package:southwind/Models/user_data.dart';
import 'package:southwind/data/providers/ValueFetcher/UserFetch.dart';
import 'package:southwind/data/providers/base_notifer.dart';
import 'package:southwind/utils/helpers.dart';
import 'package:southwind/utils/utilsContstant.dart';

List monthsList = [
  "",
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "May",
  "Jun",
  "Jul",
  "Aug",
  "Sep",
  "Oct",
  "Nov",
  "Dec"
];
List weekDaysList = ["", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];

class TimerCardNotifier extends BaseNotifier {
  UserData? userData;
  List<TimerCard> timerCardList = [];
  DateTime? startDate;
  DateTime? endDate;
  TimerCardNotifier() {
    endDate = DateTime.now();

    startDate = DateTime(endDate!.year, endDate!.month, endDate!.day - 7);
    userData = UserFetch().fetchUserData();
    notifyListeners();
  }
  // Future timerHistroy() async {
  //   timerCardList.clear();
  //   final res = await dioClient.postWithFormData(apiEnd: api_timerHistory);
  //   timerCardList = List<TimerCard>.from(
  //       res.data["timecard_details"].map((x) => TimerCard.fromJson(x)));
  // }
  Future timeCardAccordingToDates() async {
    timerCardList.clear();
    final res =
        await dioClient.postWithFormData(apiEnd: api_timerHistoryDate, data: {
      "start_date": startDate.toString().substring(0, 10),
      "end_date": endDate.toString().substring(0, 10),
    });

    timerCardList = List<TimerCard>.from(
        res.data["timecard_details"].map((x) => TimerCard.fromJson(x)));
    notifyListeners();
  }

  Future setDate(DateTime _endTime, DateTime startTime) async {
    this.startDate = startTime;
    this.endDate = _endTime;
    notifyListeners();
  }

  Future punchIn() async {
    DateTime date = DateTime.now();
    final res =
        await dioClient.postWithFormData(apiEnd: api_punchInAndOut, data: {
      "team_id": userData!.teamId,
      "client_id": userData!.id,
      "time_in": date,
      "gps_in": 0,
    });
    Utils.setPref(key_punchInDate, date.toIso8601String());
  }

  Future punchOut() async {
    final res =
        await dioClient.postWithFormData(apiEnd: api_punchInAndOut, data: {
      "team_id": userData!.teamId,
      "client_id": userData!.id,
      "time_out": DateTime.now(),
      "gps_in": 0,
    });
    Utils.removeSingleKey(key_punchInDate);
  }
}
