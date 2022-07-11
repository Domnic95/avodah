// To parse this JSON data, do
//
//     final jobModal = jobModalFromJson(jsonString);

import 'dart:convert';

JobModal jobModalFromJson(String str) => JobModal.fromJson(json.decode(str));

String jobModalToJson(JobModal data) => json.encode(data.toJson());

class JobModal {
  JobModal({
    required this.id,
    this.createdBy,
    this.assignedTo,
    this.title,
    this.jobType,
    this.jobDate,
    this.myCreditCardTip,
    this.totalJobRevenue,
    this.myJobRevenue,
    this.revenueSharePercentage,
    this.paymentType,
    this.numberOfTeamMember,
    this.isApproved,
    this.createdAt,
    this.updatedAt,
    this.revenuePerHour,
    this.profitSharePercentage,
    this.careerPathBashShare,
  });

  int id;
  int? createdBy;
  int? assignedTo;
  String? title;
  int? jobType;
  DateTime? jobDate;
  String? myCreditCardTip;
  String? totalJobRevenue;
  String? myJobRevenue;
  String? revenueSharePercentage;
  int? paymentType;
  int? numberOfTeamMember;
  int? isApproved;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? revenuePerHour;
  String? profitSharePercentage;
  String? careerPathBashShare;
  String? AJS;

  factory JobModal.fromJson(Map<String, dynamic> json) => JobModal(
        id: json["id"],
        createdBy: json["created_by"],
        assignedTo: json["assigned_to"],
        title: json["title"],
        jobType: json["job_type"],
        jobDate: DateTime.parse(json["job_date"]),
        myCreditCardTip: json["my_credit_card_tip"],
        totalJobRevenue: json["total_job_revenue"],
        myJobRevenue: json["my_job_revenue"],
        revenueSharePercentage: json["revenue_share_percentage"],
        paymentType: json["payment_type"],
        numberOfTeamMember: json["number_of_team_member"],
        isApproved: json["is_approved"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        revenuePerHour: json["revenue_per_hour"],
        profitSharePercentage: json["profit_share_percentage"],
        careerPathBashShare: json["career_path_bash_share"],
      );
  setAJS(int jobCount) {
    AJS = (double.parse(myJobRevenue ?? "0") / jobCount).toString();
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_by": createdBy,
        "assigned_to": assignedTo,
        "title": title,
        "job_type": jobType,
        "job_date":
            "${jobDate?.year.toString().padLeft(4, '0')}-${jobDate?.month.toString().padLeft(2, '0')}-${jobDate?.day.toString().padLeft(2, '0')}",
        "my_credit_card_tip": myCreditCardTip,
        "total_job_revenue": totalJobRevenue,
        "my_job_revenue": myJobRevenue,
        "revenue_share_percentage": revenueSharePercentage,
        "payment_type": paymentType,
        "number_of_team_member": numberOfTeamMember,
        "is_approved": isApproved,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "revenue_per_hour": revenuePerHour,
        "profit_share_percentage": profitSharePercentage,
        "career_path_bash_share": careerPathBashShare,
      };
}
