// To parse this JSON data, do
//
//     final teamMember = teamMemberFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/widgets.dart';

TeamMember teamMemberFromJson(String str) => TeamMember.fromJson(json.decode(str));

String teamMemberToJson(TeamMember data) => json.encode(data.toJson());

class TeamMember {
    TeamMember({
        required this.id,
        this.profileFirstName,
        this.profileLastName,
        this.profileEmail,
    });

    int id;
    String? profileFirstName;
    String? profileLastName;
    String? profileEmail;

    factory TeamMember.fromJson(Map<String, dynamic> json) => TeamMember(
        id: json["id"],
        profileFirstName: json["profile_first_name"],
        profileLastName: json["profile_last_name"],
        profileEmail: json["profile_email"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "profile_first_name": profileFirstName,
        "profile_last_name": profileLastName,
        "profile_email": profileEmail,
    };
}
