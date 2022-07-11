// To parse this JSON data, do
//
//     final group = groupFromJson(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';

Group groupFromJson(String str) => Group.fromJson(json.decode(str));

String groupToJson(Group data) => json.encode(data.toJson());

class Group {
  Group({
    this.id,
    this.groupId,
    this.profileId,
    this.createdOn,
    this.status,
    this.messageCreatedAt,
    this.userImage,
    this.lastMessage,
    this.group,
    this.displayFormat,
  });

  int? id;
  int? groupId;
  int? profileId;
  DateTime? createdOn;
  int? status;
  DateTime? messageCreatedAt;
  String? userImage;
  GroupClass? group;

  String? lastMessage;
  String? displayFormat;

  factory Group.fromJson(Map<String, dynamic> json) {
    DateTime date = DateTime.parse(json["message_created_at"]);

    return Group(
      id: json["id"],
      groupId: json["group_id"],
      profileId: json["profile_id"],
      createdOn: DateTime.parse(json["created_on"]),
      status: json["status"],
      messageCreatedAt: DateTime.parse(json["message_created_at"]),
      userImage: json["user_image"],
      group: GroupClass.fromJson(json["group"]),
      lastMessage: json["last_message"] ?? "Media",
      displayFormat:
          DateFormat.jm().format(DateTime.parse(json["message_created_at"])),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "group_id": groupId,
        "profile_id": profileId,
        "created_on": createdOn!.toIso8601String(),
        "status": status,
        "message_created_at": messageCreatedAt!.toIso8601String(),
        "user_image": userImage,
        "group": group!.toJson(),
      };
}

class GroupClass {
  GroupClass({
    this.id,
    this.groupName,
    this.creatorId,
    this.createdOn,
    this.status,
    this.adminUserId,
    this.lastModified,
  });

  int? id;
  String? groupName;
  int? creatorId;
  DateTime? createdOn;
  int? status;
  int? adminUserId;
  DateTime? lastModified;

  factory GroupClass.fromJson(Map<String, dynamic> json) => GroupClass(
        id: json["id"],
        groupName: json["group_name"],
        creatorId: json["creator_id"],
        createdOn: DateTime.parse(json["created_on"]),
        status: json["status"],
        adminUserId: json["admin_user_id"],
        lastModified: DateTime.parse(json["last_modified"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "group_name": groupName,
        "creator_id": creatorId,
        "created_on": createdOn!.toIso8601String(),
        "status": status,
        "admin_user_id": adminUserId,
        "last_modified": lastModified!.toIso8601String(),
      };
}
