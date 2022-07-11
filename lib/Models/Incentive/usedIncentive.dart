class UsedIncentive {
  UsedIncentive({
    this.incentiveId,
    this.incentiveTitle,
    this.status,
    this.incentiveBadge,
    this.secureUrl,
    this.cloudinarySecureUrl,
    this.dateUsed,
  });

  int? incentiveId;
  String? incentiveTitle;
  int? status;
  int? incentiveBadge;
  String? secureUrl;
  String? cloudinarySecureUrl;
  DateTime? dateUsed;

  factory UsedIncentive.fromJson(Map<String, dynamic> json) => UsedIncentive(
        incentiveId: json["incentive_id"],
        incentiveTitle: json["incentive_title"],
        status: json["status"],
        incentiveBadge: json["incentive_badge"],
        secureUrl: json["secure_url"],
        cloudinarySecureUrl: json["cloudinarySecureUrl"],
        dateUsed: DateTime.parse(json["dateUsed"]),
      );

  Map<String, dynamic> toJson() => {
        "incentive_id": incentiveId,
        "incentive_title": incentiveTitle,
        "status": status,
        "incentive_badge": incentiveBadge,
        "secure_url": secureUrl,
        "cloudinarySecureUrl": cloudinarySecureUrl,
        "dateUsed": dateUsed!.toIso8601String(),
      };
}
