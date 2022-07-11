import 'dart:convert';

import 'package:southwind/Models/team/team.dart';
import 'package:southwind/Models/user_data.dart';
import 'package:southwind/utils/helpers.dart';
import 'package:southwind/utils/utilsContstant.dart';

class UserFetch {
  UserData fetchUserData() {
    Map<String, dynamic> map = jsonDecode(Utils.getPref(key_userinfo)!);

    return UserData.fromJson(map);
  }

  // TeamData fetchTeamdata() {
  //   Map<String, dynamic> map = jsonDecode(Utils.getPref(key_teamData)!);

  //   return TeamData.fromJson(map);
  // }
}
