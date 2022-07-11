import 'package:southwind/Models/Incentive/Incentive.dart';

class IncentiveHistroy {
  IncentiveHistroy({
    this.incentiveList,
    // this.approvedIncentives,
    // this.pendingIncentives,
    // this.declinedIncentives,
  });

  List<IncentiveList>? incentiveList;
  // List<IncentiveList>? approvedIncentives;
  // List<IncentiveList>? pendingIncentives;
  // List<IncentiveList>? declinedIncentives;

  factory IncentiveHistroy.fromJson(Map<String, dynamic> json) =>
      IncentiveHistroy(
        incentiveList: List<IncentiveList>.from(json['notificationDetails']
                ["incentiveList"]
            .map((x) => IncentiveList.fromJson(x))),
        // approvedIncentives: List<IncentiveList>.from(
        //     json['notificationDetails']["approvedIncentives"].map((x) => x)),
        // pendingIncentives: List<IncentiveList>.from(
        //     json['notificationDetails']["pendingIncentives"].map((x) => x)),
        // declinedIncentives: List<IncentiveList>.from(
        //     json['notificationDetails']["declinedIncentives"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "incentiveList":
            List<dynamic>.from(incentiveList!.map((x) => x.toJson())),
        // "approvedIncentives":
        //     List<dynamic>.from(approvedIncentives!.map((x) => x)),
        // "pendingIncentives":
        //     List<dynamic>.from(pendingIncentives!.map((x) => x)),
        // "declinedIncentives":
        //     List<dynamic>.from(declinedIncentives!.map((x) => x)),
      };
}
