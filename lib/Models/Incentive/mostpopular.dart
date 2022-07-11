import 'package:southwind/Models/Incentive/Incentive.dart';

class MostPopularIncentive {
  List<IncentiveList>? incentiveList;
  int? badgeAvailable;
  MostPopularIncentive({this.incentiveList, this.badgeAvailable});
  factory MostPopularIncentive.fromJson(Map<String, dynamic> json) =>
      MostPopularIncentive(
        incentiveList: List<IncentiveList>.from(
            json["incentiveList"].map((x) => IncentiveList.fromJson(x))),
        badgeAvailable: json["badgeAvailable"],
      );

  Map<String, dynamic> toJson() => {
        "incentiveList":
            List<dynamic>.from(incentiveList!.map((x) => x.toJson())),
        "badgeAvailable": badgeAvailable,
      };
}
