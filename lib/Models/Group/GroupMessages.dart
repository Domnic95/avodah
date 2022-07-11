// // To parse this JSON data, do
// //
// //     final groupMessage = groupMessageFromJson(jsonString);

// import 'dart:convert';

// GroupMessage groupMessageFromJson(String str) =>
//     GroupMessage.fromJson(json.decode(str));

// String groupMessageToJson(GroupMessage data) => json.encode(data.toJson());

// To parse this JSON data, do
//
//     final groupMessage = groupMessageFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

GroupMessage groupMessageFromJson(String str) =>
    GroupMessage.fromJson(json.decode(str));

String groupMessageToJson(GroupMessage data) => json.encode(data.toJson());

class AllGroupMessage {
  AllGroupMessage({
    this.message,
    this.groupMessages,
    this.isSuccess,
  });

  String? message;
  GroupMessagesinfo? groupMessages;
  bool? isSuccess;

  factory AllGroupMessage.fromJson(Map<String, dynamic> json) =>
      AllGroupMessage(
        message: json["message"],
        groupMessages: GroupMessagesinfo.fromJson(json["groupMessages"]),
        isSuccess: json["isSuccess"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "groupMessages": groupMessages!.toJson(),
        "isSuccess": isSuccess,
      };
}

class GroupMessagesinfo {
  GroupMessagesinfo({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int? currentPage;
  List<GroupMessage>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  factory GroupMessagesinfo.fromJson(Map<String, dynamic> json) =>
      GroupMessagesinfo(
        currentPage: json["current_page"],
        data: List<GroupMessage>.from(
            json["data"].map((x) => GroupMessage.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class GroupMessage {
  GroupMessage(
      {this.id,
      this.groupId,
      this.profileId,
      this.message,
      this.mediaUrl,
      this.mediaType,
      this.createdOn,
      this.userImage,
      this.fullName,
      this.today,
      this.time,
      this.displayFormat});

  int? id;
  int? groupId;
  int? profileId;
  String? message;
  String? mediaUrl;
  MediaTypes? mediaType;
  DateTime? createdOn;
  String? userImage;
  String? fullName;
  //DateTime? time;
  String? time;
  String? today;
  String? displayFormat;

  factory GroupMessage.fromJson(Map<String, dynamic> json) {
    // DateTime time = DateTime.parse(json["time"]);
    DateTime date = DateTime.parse(json['created_on']);
    return GroupMessage(
      id: json["id"],
      groupId: json["group_id"],
      profileId: json["profile_id"],
      message: json["message"].toString(),
      mediaUrl: json["media_url"].toString(),
      mediaType: media(json["media_type"].toString()),
      createdOn: DateTime.parse(json["created_on"]),
      userImage: json["user_image"].toString(),
      fullName: json["fullName"].toString(),
      // time: DateTime(json["time"]),
      //  time: timeDifference(date),
      time: json['time'],
      today: json["today"].toString(),
      // displayFormat:
      //     // timeDifference(date)
      //     DateFormat.jm().format(DateTime.parse(json["created_on"])),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "group_id": groupId,
        "profile_id": profileId,
        "message": message,
        "media_url": mediaUrl,
        "media_type": mediaType,
        "created_on": createdOn!.toIso8601String(),
        "user_image": userImage,
        "fullName": fullName,
        "time": time,
        "today": today,
      };
}

enum MediaTypes { Image, Video, message }
MediaTypes media(String type) {
  if (type == 'video') {
    return MediaTypes.Video;
  } else if (type == 'image') {
    return MediaTypes.Image;
  } else {
    return MediaTypes.message;
  }
}

String timeDifference(DateTime times) {
  String time = '';
  DateTime now = DateTime.now();

  log('cjschshuh' + times.toString());
  if (now.difference(times).inDays > 1) {
    time = "${times.day}-${times.month}-${times.year}";
  } else {
    String hour = times.hour > 13
        ? (24 - times.hour).toString()
        : (times.hour).toString();
    String ge = times.hour > 12 ? "pm" : "am";
    time = "${hour}:${times.minute} ${ge}";
  }
  return time;
}
