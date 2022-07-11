// import 'dart:convert';

// import 'package:southwind/Models/jobs/job_modal.dart';

// MyJobs myJobsFromJson(String str) => MyJobs.fromJson(json.decode(str));

// String myJobsToJson(MyJobs data) => json.encode(data.toJson());

// class MyJobs {
//   MyJobs({
//     required this.id,
//     this.profileFirstName,
//     this.profileLastName,
//     this.payRate,
//     this.designation,
//     this.teamId,
//     this.jobsCount,
//     this.totalJobRevenue,
//     this.totalTip,
//     this.baseRevenueShare,
//     this.bonusBaseRevenueShare,
//     this.multiplier,
//     this.myRevShare,
//     this.totalMinFormat,
//     this.totalMin,
//     this.totalMyJobRevenue,
//     this.revenuePerHour,
//     this.totalSharePercentage,
//     this.jobs,
//   });

//   int id;
//   String? profileFirstName;
//   String? profileLastName;
//   String? payRate;
//   int? designation;
//   int? teamId;
//   int? jobsCount;
//   int? totalJobRevenue;
//   double? totalTip;
//   String? baseRevenueShare;
//   int? bonusBaseRevenueShare;
//   String? multiplier;
//   int? myRevShare;
//   String? totalMinFormat;
//   int? totalMin;
//   double? totalMyJobRevenue;
//   var revenuePerHour;
//   int? totalSharePercentage;

//   List<JobModal>? jobs;

//   factory MyJobs.fromJson(Map<String, dynamic> json) => MyJobs(
//         id: json["id"],
//         profileFirstName: json["profile_first_name"],
//         profileLastName: json["profile_last_name"],
//         payRate: json["pay_rate"],
//         designation: json["designation"],
//         teamId: json["team_id"],
//         jobsCount: json["jobs_count"],
//         totalJobRevenue: json["total_job_revenue"],
//         totalTip: json["total_tip"],
//         baseRevenueShare: json["base_revenue_share"],
//         bonusBaseRevenueShare: json["bonus_base_revenue_share"],
//         multiplier: json["multiplier"],
//         myRevShare: json["my_rev_share"],
//         totalMinFormat: json["total_min_format"],
//         totalMin: json["total_min"],
//         totalMyJobRevenue: json["total_my_job_revenue"],
//         revenuePerHour: json["revenue_per_hour"],
//         totalSharePercentage: json["total_share_percentage"],
//         jobs:
//             List<JobModal>.from(json["jobs"].map((x) => JobModal.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "profile_first_name": profileFirstName,
//         "profile_last_name": profileLastName,
//         "pay_rate": payRate,
//         "designation": designation,
//         "team_id": teamId,
//         "jobs_count": jobsCount,
//         "total_job_revenue": totalJobRevenue,
//         "total_tip": totalTip,
//         "base_revenue_share": baseRevenueShare,
//         "bonus_base_revenue_share": bonusBaseRevenueShare,
//         "multiplier": multiplier,
//         "my_rev_share": myRevShare,
//         "total_min_format": totalMinFormat,
//         "total_min": totalMin,
//         "total_my_job_revenue": totalMyJobRevenue,
//         "revenue_per_hour": revenuePerHour,
//         "total_share_percentage": totalSharePercentage,
//         "jobs": List<dynamic>.from(jobs!.map((x) => x.toJson())),
//       };
// }
// To parse this JSON data, do
//
//     final myJobs = myJobsFromJson(jsonString);

import 'dart:convert';

import 'package:southwind/Models/jobs/job_modal.dart';

MyJobs myJobsFromJson(String str) => MyJobs.fromJson(json.decode(str));

String myJobsToJson(MyJobs data) => json.encode(data.toJson());

class MyJobs {
  MyJobs({
    required this.id,
    this.profileFirstName,
    this.profileLastName,
    this.payRate,
    this.designation,
    this.teamId,
    this.jobsCount,
    this.totalJobRevenue,
    this.totalTip,
    this.baseRevenueShare,
    this.bonusBaseRevenueShare,
    this.multiplier,
    this.myRevShare,
    this.totalMinFormat,
    this.totalMin,
    this.totalMyJobRevenue,
    this.revenuePerHour,
    this.totalSharePercentage,
    this.jobs,
  });

  int id;
  String? profileFirstName;
  String? profileLastName;
  String? payRate;
  int? designation;
  int? teamId;
  int? jobsCount;
  String? totalJobRevenue;
  String? totalTip;
  String? baseRevenueShare;
  int? bonusBaseRevenueShare;
  String? multiplier;
  String? myRevShare;
  String? totalMinFormat;
  int? totalMin;
  String? totalMyJobRevenue;
  String? revenuePerHour;
  int? totalSharePercentage;

  List<JobModal>? jobs;

  factory MyJobs.fromJson(Map<String, dynamic> json) => MyJobs(
        id: json["id"],
        profileFirstName: json["profile_first_name"],
        profileLastName: json["profile_last_name"],
        payRate: json["pay_rate"],
        designation: json["designation"],
        teamId: json["team_id"],
        jobsCount: json["jobs_count"],
        totalJobRevenue: json["total_job_revenue"],
        totalTip: json["total_tip"],
        baseRevenueShare: json["base_revenue_share"],
        bonusBaseRevenueShare: json["bonus_base_revenue_share"],
        multiplier: json["multiplier"],
        myRevShare: json["my_rev_share"],
        totalMinFormat: json["total_min_format"],
        totalMin: json["total_min"],
        totalMyJobRevenue: json["total_my_job_revenue"],
        revenuePerHour: json["revenue_per_hour"],
        totalSharePercentage: json["total_share_percentage"],
        jobs:
            List<JobModal>.from(json["jobs"].map((x) => JobModal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "profile_first_name": profileFirstName,
        "profile_last_name": profileLastName,
        "pay_rate": payRate,
        "designation": designation,
        //"designation": designation?.toInt(),
        "team_id": teamId,
        "jobs_count": jobsCount,
        "total_job_revenue": totalJobRevenue,
        "total_tip": totalTip,
        "base_revenue_share": baseRevenueShare,
        "bonus_base_revenue_share": bonusBaseRevenueShare,
        "multiplier": multiplier,
        "my_rev_share": myRevShare,
        "total_min_format": totalMinFormat,
        "total_min": totalMin,
        "total_my_job_revenue": totalMyJobRevenue,
        "revenue_per_hour": revenuePerHour,
        "total_share_percentage": totalSharePercentage,
        "jobs": List<dynamic>.from(jobs!.map((x) => x.toJson())),
      };
}
