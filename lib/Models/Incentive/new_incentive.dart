import 'package:southwind/Models/Incentive/Incentive.dart';

class NewIncentive {
  NewIncentive({
    this.incentiveList,
    this.badgeAvailable,
  });

  List<IncentiveList>? incentiveList;
  BadgeAvailable? badgeAvailable;

  factory NewIncentive.fromJson(Map<String, dynamic> json) => NewIncentive(
        incentiveList: List<IncentiveList>.from(
            json["incentiveList"].map((x) => IncentiveList.fromJson(x))),
        badgeAvailable: BadgeAvailable.fromJson(json["badgeAvailable"]),
      );

  Map<String, dynamic> toJson() => {
        "incentiveList":
            List<dynamic>.from(incentiveList!.map((x) => x.toJson())),
        "badgeAvailable": badgeAvailable!.toJson(),
      };
}

class BadgeAvailable {
  BadgeAvailable({
    this.earnedBadges,
    this.usedBadges,
    this.totalCount,
  });

  int? earnedBadges;
  String? usedBadges;
  int? totalCount;

  factory BadgeAvailable.fromJson(Map<String, dynamic> json) => BadgeAvailable(
        earnedBadges: json["earnedBadges"],
        usedBadges: json["usedBadges"],
        totalCount: json["totalCount"],
      );

  Map<String, dynamic> toJson() => {
        "earnedBadges": earnedBadges,
        "usedBadges": usedBadges,
        "totalCount": totalCount,
      };
}
