class SurveyUser {
  SurveyUser({
    this.id,
    this.userEmail,
    this.firstName,
    this.lastName,
    this.organisationName,
    this.franchiseId,
    this.bannerId,
    this.role,
    this.status,
    // this.logoImage,
    // this.box1Title,
    // this.box1Value,
    // this.box1Change,
    // this.box2Title,
    // this.box2Value,
    // this.box2Change,
    // this.box3Title,
    // this.box3Value,
    // this.box3Change,
    // this.box4Title,
    // this.box4Value,
    // this.box4Change,
    // this.ajs,
    // this.ajsYesterday,
    // this.jobs,
    // this.jobsYesterday,
    // this.revenue,
    // this.revenueYesterday,
    // this.trend,
    // this.trendYesterday,
    // this.timezoneId,
    // this.latitude,
    // this.longitude,
    // this.kiosk,
  });

  int? id;
  String? userEmail;
  String? firstName;
  String? lastName;
  String? organisationName;
  int? franchiseId;
  int? bannerId;
  int? role;
  int? status;
  // dynamic logoImage;
  // String? box1Title;
  // String? box1Value;
  // String? box1Change;
  // String? box2Title;
  // String? box2Value;
  // String? box2Change;
  // String? box3Title;
  // String? box3Value;
  // String box3Change;
  // String ?box4Title;
  // String? box4Value;
  // String? box4Change;
  // String ?ajs;
  // String ?ajsYesterday;
  // String ?jobs;
  // String ?jobsYesterday;
  // String ?revenue;
  // String ?revenueYesterday;
  // String ?trend;
  // String ?trendYesterday;
  // int ?timezoneId;
  // String? latitude;
  // String? longitude;
  // int kiosk;

  factory SurveyUser.fromJson(Map<String, dynamic> json) => SurveyUser(
        id: json["id"],
        userEmail: json["user_email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        organisationName: json["organisation_name"],
        franchiseId: json["franchise_id"],
        bannerId: json["banner_id"],
        role: json["role"],
        status: json["status"],
        // logoImage: json["logo_image"],
        // box1Title: json["box1_title"],
        // box1Value: json["box1_value"],
        // box1Change: json["box1_change"],
        // box2Title: json["box2_title"],
        // box2Value: json["box2_value"],
        // box2Change: json["box2_change"],
        // box3Title: json["box3_title"],
        // box3Value: json["box3_value"],
        // box3Change: json["box3_change"],
        // box4Title: json["box4_title"],
        // box4Value: json["box4_value"],
        // box4Change: json["box4_change"],
        // ajs: json["ajs"],
        // ajsYesterday: json["ajs_yesterday"],
        // jobs: json["jobs"],
        // jobsYesterday: json["jobs_yesterday"],
        // revenue: json["revenue"],
        // revenueYesterday: json["revenue_yesterday"],
        // trend: json["trend"],
        // trendYesterday: json["trend_yesterday"],
        // timezoneId: json["timezone_id"],
        // latitude: json["latitude"],
        // longitude: json["longitude"],
        // kiosk: json["kiosk"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_email": userEmail,
        "first_name": firstName,
        "last_name": lastName,
        "organisation_name": organisationName,
        "franchise_id": franchiseId,
        "banner_id": bannerId,
        "role": role,
        "status": status,
        // "logo_image": logoImage,
        // "box1_title": box1Title,
        // "box1_value": box1Value,
        // "box1_change": box1Change,
        // "box2_title": box2Title,
        // "box2_value": box2Value,
        // "box2_change": box2Change,
        // "box3_title": box3Title,
        // "box3_value": box3Value,
        // "box3_change": box3Change,
        // "box4_title": box4Title,
        // "box4_value": box4Value,
        // "box4_change": box4Change,
        // "ajs": ajs,
        // "ajs_yesterday": ajsYesterday,
        // "jobs": jobs,
        // "jobs_yesterday": jobsYesterday,
        // "revenue": revenue,
        // "revenue_yesterday": revenueYesterday,
        // "trend": trend,
        // "trend_yesterday": trendYesterday,
        // "timezone_id": timezoneId,
        // "latitude": latitude,
        // "longitude": longitude,
        // "kiosk": kiosk,
      };
}
