// To parse this JSON data, do
//
//     final allLeaderBoard = allLeaderBoardFromJson(jsonString);

import 'dart:convert';

class AllLeaderBoard {
  AllLeaderBoard({
    this.revenue,
    this.ajs,
    this.revenuePerHour,
    this.nps,
  });

  List<LeaderDetail>? revenue;
  List<LeaderDetail>? ajs;
  List<LeaderDetail>? revenuePerHour;
  List<LeaderDetail>? nps;

  factory AllLeaderBoard.fromJson(List json) {
    return AllLeaderBoard(
      revenue: List<LeaderDetail>.from(
          json[0]["Revenue"].map((x) => LeaderDetail.fromJson(x, 'revenue'))),
      ajs: json[1]["AJS"] == null
          ? null
          : List<LeaderDetail>.from(
              json[1]["AJS"].map((x) => LeaderDetail.fromJson(x, 'ajs'))),
      revenuePerHour: json[2]["Revenue Per Hour"] == null
          ? null
          : List<LeaderDetail>.from(json[2]["Revenue Per Hour"]
              .map((x) => LeaderDetail.fromJson(x, 'revenueperhour'))),
      nps: json[3]["NPS"] == null
          ? null
          : List<LeaderDetail>.from(
              json[3]["NPS"].map((x) => LeaderDetail.fromJson(x, 'nps'))),
    );
  }
}

class LeaderDetail {
  LeaderDetail({
    this.employee,
    this.team,
    this.price,
  });

  String? employee;
  String? team;
  String? price;

  factory LeaderDetail.fromJson(Map<String, dynamic> json, String title) =>
      LeaderDetail(
        employee: json["employee"].toString(),
        team: json["team"]??"",
        price: json[title].toString(),
      );
}
