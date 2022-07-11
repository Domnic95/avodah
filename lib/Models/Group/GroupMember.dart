class GroupMembers {
  GroupMembers({this.id, this.fullName, this.userProfile});

  int? id;
  String? fullName;
  String? userProfile;

  factory GroupMembers.fromJson(Map<String, dynamic> json) => GroupMembers(
      id: json["id"],
      fullName: json["fullName"],
      userProfile: json['user_image']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
      };
}
