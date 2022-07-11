// To parse this JSON data, do
//
//     final aLlIncentive = aLlIncentiveFromJson(jsonString);

import 'dart:convert';

ALlIncentive aLlIncentiveFromJson(String str) =>
    ALlIncentive.fromJson(json.decode(str));

String aLlIncentiveToJson(ALlIncentive data) => json.encode(data.toJson());

class ALlIncentive {
  ALlIncentive({
    this.message,
    this.incentiveList,
    this.badgeAvailable,
    this.isSuccess,
  });

  String? message;
  List<IncentiveList>? incentiveList;
  BadgeAvailable? badgeAvailable;
  bool? isSuccess;

  factory ALlIncentive.fromJson(Map<String, dynamic> json) => ALlIncentive(
        message: json["message"],
        incentiveList: List<IncentiveList>.from(
            json["incentiveList"].map((x) => IncentiveList.fromJson(x))),
        badgeAvailable: BadgeAvailable.fromJson(json["badgeAvailable"]),
        isSuccess: json["isSuccess"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "incentiveList":
            List<dynamic>.from(incentiveList!.map((x) => x.toJson())),
        "badgeAvailable": badgeAvailable!.toJson(),
        "isSuccess": isSuccess,
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

class IncentiveList {
  IncentiveList({
    this.incentiveId,
    this.createdBy,
    this.teamId,
    this.incentiveTitle,
    this.incentiveBadge,
    this.incentiveDescription,
    this.incentiveStatus,
    this.url,
    this.secureUrl,
    this.cloudinaryId,
    this.cloudinaryUrl,
    this.cloudinarySecureUrl,
    this.resourceType,
    this.createdOn,
    this.adminUserId,
    this.lastModified,
    this.buyStatus,
  });

  int? incentiveId;
  int? createdBy;
  int? teamId;
  String? incentiveTitle;
  int? incentiveBadge;
  String? incentiveDescription;
  int? incentiveStatus;
  String? url;
  String? secureUrl;
  String? cloudinaryId;
  String? cloudinaryUrl;
  String? cloudinarySecureUrl;
  ResourceType? resourceType;
  dynamic? createdOn;
  int? adminUserId;
  DateTime? lastModified;
  int? buyStatus;

  factory IncentiveList.fromJson(Map<String, dynamic> json) => IncentiveList(
        incentiveId: json["incentive_id"],
        createdBy: json["created_by"],
        teamId: json["team_id"],
        incentiveTitle: json["incentive_title"],
        incentiveBadge: json["incentive_badge"],
        incentiveDescription: json["incentive_description"],
        incentiveStatus: json["incentive_status"],
        url: json["url"],
        secureUrl: json["secure_url"],
        cloudinaryId: json["cloudinaryId"],
        cloudinaryUrl: json["cloudinaryUrl"],
        cloudinarySecureUrl: json["cloudinarySecureUrl"],
        resourceType: resourceTypeValues.map[json["resource_type"]],
        createdOn: json["created_on"],
        adminUserId: json["admin_user_id"],
        lastModified: DateTime.parse(json["last_modified"]),
        buyStatus: json["buyStatus"],
      );

  Map<String, dynamic> toJson() => {
        "incentive_id": incentiveId,
        "created_by": createdBy,
        "team_id": teamId,
        "incentive_title": incentiveTitle,
        "incentive_badge": incentiveBadge,
        "incentive_description": incentiveDescription,
        "incentive_status": incentiveStatus,
        "url": url,
        "secure_url": secureUrl,
        "cloudinaryId": cloudinaryId,
        "cloudinaryUrl": cloudinaryUrl,
        "cloudinarySecureUrl": cloudinarySecureUrl,
        "resource_type": resourceTypeValues.reverse[resourceType],
        "created_on": createdOn,
        "admin_user_id": adminUserId,
        "last_modified": lastModified!.toIso8601String(),
        "buyStatus": buyStatus,
      };
}





enum ResourceType { JPG, EMPTY }

final resourceTypeValues =
    EnumValues({"": ResourceType.EMPTY, "jpg": ResourceType.JPG});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
