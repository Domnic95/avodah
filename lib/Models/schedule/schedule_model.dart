// To parse this JSON data, do
//
//     final scheduleModel = scheduleModelFromJson(jsonString);

import 'dart:convert';

import 'package:southwind/component/dateFormattor.dart';

ScheduleModel scheduleModelFromJson(String str) =>
    ScheduleModel.fromJson(json.decode(str));

String scheduleModelToJson(ScheduleModel data) => json.encode(data.toJson());

class ScheduleModel {
  ScheduleModel({
    this.profileSchedules,
    this.profileTimeOff,
  });

  List<ProfileSchedule>? profileSchedules;
  List<ProfileTimeOff>? profileTimeOff;

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
        profileSchedules: List<ProfileSchedule>.from(
            json["profile_schedules"].map((x) => ProfileSchedule.fromJson(x))),
        profileTimeOff: List<ProfileTimeOff>.from(
            json["profile_timeOff"].map((x) => ProfileTimeOff.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "profile_schedules":
            List<dynamic>.from(profileSchedules!.map((x) => x.toJson())),
        "profile_timeOff":
            List<dynamic>.from(profileTimeOff!.map((x) => x.toJson())),
      };
}

class ProfileSchedule {
  ProfileSchedule({
    this.id,
    this.profileId,
    this.scheduleId,
    this.shiftId,
    this.day,
    this.notes,
    this.createdBy,
    this.teamId,
    this.adminUserId,
    this.lastModified,
    this.active,
    // this.schedule,
    this.shift,
  });

  int? id;
  int? profileId;
  int? scheduleId;
  int? shiftId;
  DateTime? day;
  String? notes;
  int? createdBy;
  int? teamId;
  int? adminUserId;
  DateTime? lastModified;
  int? active;
  // Schedule? schedule;
  ScheduleShift? shift;

  factory ProfileSchedule.fromJson(Map<String, dynamic> json) =>
      ProfileSchedule(
        id: json["id"],
        profileId: json["profileId"],
        scheduleId: json["scheduleId"],
        shiftId: json["shiftId"],
        day: convertStringIntoDate(json["day"]),
        notes: json["notes"],
        createdBy: json["created_by"],
        teamId: json["team_id"],
        adminUserId: json["admin_user_id"],
        lastModified: DateTime.parse(json["last_modified"]),
        active: json["active"],
        // schedule: Schedule.fromJson(json["schedule"]) == null
        //     ? null
        //     : Schedule.fromJson(json["schedule"]),
        shift: ScheduleShift.fromJson(json["shift"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "profileId": profileId,
        "scheduleId": scheduleId,
        "shiftId": shiftId,
        "day": day,
        "notes": notes,
        "created_by": createdBy,
        "team_id": teamId,
        "admin_user_id": adminUserId,
        "last_modified": lastModified!.toIso8601String(),
        "active": active,
        // "schedule": schedule!.toJson() == null ? null : schedule!.toJson(),
        "shift": shift!.toJson(),
      };
}

class Schedule {
  Schedule({
    this.id,
    this.name,
    this.start,
    this.end,
  });

  int? id;
  String? name;
  String? start;
  String? end;

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        id: json["id"],
        name: json["name"],
        start: json["start"],
        end: json["end"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "start": start,
        "end": end,
      };
}

class ScheduleShift {
  ScheduleShift({
    this.id,
    this.name,
    this.start,
    this.end,
  });

  int? id;
  String? name;
  String? start;
  String? end;

  factory ScheduleShift.fromJson(Map<String, dynamic> json) => ScheduleShift(
        id: json["id"],
        name: json["name"],
        start: json["start"],
        end: json["end"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "start": start,
        "end": end,
      };
}

class ProfileTimeOff {
  ProfileTimeOff({
    this.reqMessage,
    this.status,
    this.offDay,
    this.profile_id,
  });

  String? reqMessage;
  int? status;
  int? profile_id;
  DateTime? offDay;

  factory ProfileTimeOff.fromJson(Map<String, dynamic> json) => ProfileTimeOff(
      reqMessage: json["req_message"],
      status: json["status"],
      offDay: DateTime.parse(json["off_date"]),
      profile_id: json["profile_id"]);

  Map<String, dynamic> toJson() => {
        "req_message": reqMessage,
        "status": status,
      };
}
