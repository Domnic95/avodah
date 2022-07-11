class UserData {
  UserData(
      {required this.id,
      this.title,
      required this.profileEmail,
      required this.profileFirstName,
      required this.profileLastName,
      required this.designation,
      required this.deviceToken,
      required this.deviceType,
      required this.franchiseOwnerId,
      required this.teamId,
      required this.additionalTeamId,
      required this.ajs,
      required this.userImage,
      required this.totalRevenue,
      required this.completedJobs,
      this.hoursSpent,
      this.amountOfMoves,
      this.serviceScore,
      required this.status,
      required this.isAdmin,
      required this.isTeamTrainer,
      required this.teamRank,
      required this.worldRank,
      required this.npsScore,
      required this.tens,
      required this.whenIWorkId,
      required this.needAdminRes,
      required this.adminUserId,
      required this.lastModified,
      required this.startDate,
      this.mobile,
      required this.securityToken,
      required this.createdAt,
      required this.currentlyIn,
      required this.creatorId,
      required this.teamName});

  late int id;
  late dynamic title;
  late String profileEmail;
  late String profileFirstName;
  late String profileLastName;
  late int designation; 
  late String deviceToken;
  late String deviceType;
  late int franchiseOwnerId;
  late int teamId;
  late int additionalTeamId;
  late String ajs;
  late String userImage;
  late String totalRevenue;
  late String completedJobs;
  late dynamic hoursSpent;
  late dynamic amountOfMoves;
  late dynamic serviceScore;
  late int status;
  late int isAdmin;
  late int isTeamTrainer;
  late String teamRank;
  late String worldRank;
  late String npsScore;
  late String tens;
  late String whenIWorkId;
  late int needAdminRes;
  late int adminUserId;
  late DateTime lastModified;
  late DateTime startDate;
  late dynamic mobile;
  late String securityToken;
  late DateTime createdAt;
  late int currentlyIn;
  late int creatorId;
  late String teamName;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
      id: json["id"],
      title: json["title"],
      profileEmail: json["profile_email"].toString(),
      profileFirstName: json["profile_first_name"].toString(),
      profileLastName: json["profile_last_name"].toString(),
      designation: json["designation"],
      deviceToken: json["device_token"].toString().toString(),
      deviceType: json["device_type"].toString().toString(),
      franchiseOwnerId: json["franchise_owner_id"],
      teamId: json["team_id"],
      additionalTeamId: json["additional_team_id"],
      ajs: json["ajs"].toString(),
      userImage:
          json["user_image"] == null ? "" : json["user_image"].toString(),
      totalRevenue: json["total_revenue"].toString(),
      completedJobs: json["completed_jobs"].toString(),
      hoursSpent: json["hours_spent"],
      amountOfMoves: json["amount_of_moves"],
      serviceScore: json["service_score"],
      status: json["status"],
      isAdmin: json["is_admin"],
      isTeamTrainer: json["is_team_trainer"],
      teamRank: json["team_rank"].toString(),
      worldRank: json["world_rank"].toString(),
      npsScore: json["nps_score"].toString(),
      tens: json["tens"].toString(),
      whenIWorkId: json["whenIWorkId"].toString(),
      needAdminRes: json["need_admin_res"],
      adminUserId: json["admin_user_id"],
      lastModified: DateTime.parse(json["last_modified"]),
      startDate: json["start_date"] != null
          ? DateTime.parse(json["start_date"])
          : DateTime.now(),
      mobile: json["mobile"],
      securityToken: json["security_token"].toString(),
      createdAt: DateTime.parse(json["created_at"]),
      currentlyIn: json["currently_in"],
      creatorId: json["creator_id"],
      teamName: json['team_name'] ?? "");

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "profile_email": profileEmail,
        "profile_first_name": profileFirstName,
        "profile_last_name": profileLastName,
        "designation": designation,
        "device_token": deviceToken,
        "device_type": deviceType,
        "franchise_owner_id": franchiseOwnerId,
        "team_id": teamId,
        "additional_team_id": additionalTeamId,
        "ajs": ajs,
        "user_image": userImage,
        "total_revenue": totalRevenue,
        "completed_jobs": completedJobs,
        "hours_spent": hoursSpent,
        "amount_of_moves": amountOfMoves,
        "service_score": serviceScore,
        "status": status,
        "is_admin": isAdmin,
        "is_team_trainer": isTeamTrainer,
        "team_rank": teamRank,
        "world_rank": worldRank,
        "nps_score": npsScore,
        "tens": tens,
        "whenIWorkId": whenIWorkId,
        "need_admin_res": needAdminRes,
        "admin_user_id": adminUserId,
        "last_modified": lastModified.toIso8601String(),
        "start_date": startDate.toIso8601String(),
        "mobile": mobile,
        "security_token": securityToken,
        "created_at": createdAt.toIso8601String(),
        "currently_in": currentlyIn,
        "creator_id": creatorId,
        "team_name": teamName,
      };
}
