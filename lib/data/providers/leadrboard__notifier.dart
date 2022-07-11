import 'package:dio/dio.dart';
import 'package:southwind/Models/LeaderBoard/AllLeaderBoard.dart';
import 'package:southwind/Models/team/team.dart';
import 'package:southwind/Models/user_data.dart';
import 'package:southwind/data/providers/ValueFetcher/UserFetch.dart';
import 'package:southwind/data/providers/base_notifer.dart';

class LeaderBoardProvider extends BaseNotifier {
  UserData? userData;
  TeamData? teamData;

  bool isDataSet = false;
  List<String> teamList = ['Southwind'];

  List<AllLeaderBoard> teamLeaderBoard = [];
  LeaderBoardProvider() {
    userData = UserFetch().fetchUserData();

    // initialize();
  }
  initialize() async {
    isDataSet = false;
    Response teamRes =
        await dioClient.postWithFormData(apiEnd: api_teamdetail, data: {
      'team_id': userData!.teamId,
      'notification_type': 'team_list',
      'is_admin': userData!.isAdmin
    });
    
      if(teamRes.statusCode!=200){
        teamData = TeamData.fromJson(teamRes.data['teamlist_details']);
    if (teamData!.primaryTeamList!.primaryTeamName != null) {
      teamList.add(teamData!.primaryTeamList!.primaryTeamName!.toString());
    }
    await getAllLeaderBoardData();
    await getTeamLeaderBoard();
    isDataSet = true;
      }
    
    // notifyListeners();
  }

  Future getAllLeaderBoardData() async {
    // allLeaderBoard =
    //     AllLeaderBoard(ajs: [], nps: [], revenue: [], revenuePerHour: []);
    final res = await dioClient.postWithFormData(
        apiEnd: api_leader_board_all_new, data: {"team_id": userData!.teamId});

    AllLeaderBoard _loc = AllLeaderBoard.fromJson(res.data['leaderboard']);
    teamLeaderBoard.add(_loc);
  }

  Future getTeamLeaderBoard() async {
    final res = await dioClient.postWithFormData(
        apiEnd: api_teamLeader, data: {"team_id": userData!.teamId});

    AllLeaderBoard _loc = AllLeaderBoard.fromJson(res.data['leaderboard']);
    teamLeaderBoard.add(_loc);
  }
}
