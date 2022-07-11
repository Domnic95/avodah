class BadgesEarned {
  BadgesEarned({
    this.title,
    this.type,
    this.badges,
    this.lastModified,
  });

  String? title;
  String? type;
  int? badges;
  DateTime? lastModified;

  factory BadgesEarned.fromJson(Map<String, dynamic> json) => BadgesEarned(
        title: json["title"],
        type: json["type"],
        badges: json["badges"],
        lastModified: DateTime.parse(json["last_modified"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "type": type,
        "badges": badges,
        "last_modified": lastModified!.toIso8601String(),
      };
}
