import 'dart:convert';

import 'package:southwind/Models/Incentive/Incentive.dart';

ALlIncentive aLlIncentiveFromJson(String str) =>
    ALlIncentive.fromJson(json.decode(str));

String aLlIncentiveToJson(ALlIncentive data) => json.encode(data.toJson());

class ALlIncentive {
  ALlIncentive({
    this.incentiveList,
    this.badgeAvailable,
  });

  String? message;
  List<IncentiveList>? incentiveList;
  BadgeAvailable? badgeAvailable;
  bool? isSuccess;

  factory ALlIncentive.fromJson(Map<String, dynamic> json) => ALlIncentive(
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
  int? usedBadges;
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
