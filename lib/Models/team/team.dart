// To parse this JSON data, do
//
//     final teamData = teamDataFromJson(jsonString);

import 'dart:convert';

TeamData teamDataFromJson(String str) => TeamData.fromJson(json.decode(str));

String teamDataToJson(TeamData data) => json.encode(data.toJson());

class TeamData {
  TeamData({
    this.primaryTeamList,
    this.additionalTeamList,
  });

  PrimaryTeamList? primaryTeamList;
  dynamic additionalTeamList;

  factory TeamData.fromJson(Map<String, dynamic> json) => TeamData(
        primaryTeamList: PrimaryTeamList.fromJson(json["primaryTeamList"]),
        additionalTeamList: json["additionalTeamList"],
      );

  Map<String, dynamic> toJson() => {
        "primaryTeamList": primaryTeamList!.toJson(),
        "additionalTeamList": additionalTeamList,
      };
}

class PrimaryTeamList {
  PrimaryTeamList({
    this.profileId,
    this.creatorId,
    this.primaryTeamId,
    this.addtionalSelectedTeam,
    this.primaryTeamName,
    this.notificationCount,
  });

  int? profileId;
  int? creatorId;
  int? primaryTeamId;
  int? addtionalSelectedTeam;
  String? primaryTeamName;
  int? notificationCount;

  factory PrimaryTeamList.fromJson(Map<String, dynamic> json) =>
      PrimaryTeamList(
        profileId: json["profileId"],
        creatorId: json["creatorId"],
        primaryTeamId: json["primaryTeamId"],
        addtionalSelectedTeam: json["addtionalSelectedTeam"],
        primaryTeamName: json["primaryTeamName"],
        notificationCount: json["notificationCount"],
      );

  Map<String, dynamic> toJson() => {
        "profileId": profileId,
        "creatorId": creatorId,
        "primaryTeamId": primaryTeamId,
        "addtionalSelectedTeam": addtionalSelectedTeam,
        "primaryTeamName": primaryTeamName,
        "notificationCount": notificationCount,
      };
}
