class BadgeDetails {
  BadgeDetails({
    this.earnedBadges,
    this.usedBadges,
    this.totalCount,
  });

  int? earnedBadges;
  String? usedBadges;
  int? totalCount;

  factory BadgeDetails.fromJson(Map<String, dynamic> json) => BadgeDetails(
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
