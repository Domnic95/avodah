import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:southwind/Models/news/postModal.dart';
import 'package:southwind/Models/news/singleNews.dart';
import 'package:southwind/Models/user_data.dart';
import 'package:southwind/data/providers/ValueFetcher/UserFetch.dart';
import 'package:southwind/data/providers/base_notifer.dart';

class NewsNotifier extends BaseNotifier {
  List<PostModal> total_news = [];
  UserData? userData;
  int offset = 0;
  int limit = offsetDifference;
  int maxFeedFromServer = 0;
  bool lazyLoading = true;
  NewsNotifier() {
    userData = UserFetch().fetchUserData();

    notifyListeners();
  }
  // Future fetchNews() async {
  //   total_news = [];

  //   Response res = await dioClient.postWithFormData(apiEnd: api_getNews, data: {
  //     'team_id': userData!.teamId,
  //     'client_id': userData!.id,
  //     'total_chat': 0,
  //     'is_admin': userData!.isAdmin,
  //     'selected_additional_team_id': userData!.additionalTeamId
  //   });

  //   total_news = List<SingleNews>.from(
  //       res.data["CommNotification"].map((x) => SingleNews.fromJson(x)));

  //   // if (res.data.containsKey('CommNotification'))
  //   //   total_news = List<SingleNews>.from(
  //   //       res.data["CommNotification"].map((x) => SingleNews.fromJson(x)));

  //   // notifyListeners();
  // }
  Future fetchNews() async {
    offset = 0;
    limit = offsetDifference;
    total_news = [];

    Response res = await dioClient.getRequest(
      apiEnd: api_communication_get_notification,
      queryParameter: {'limit': limit, "offset": offset},
    );

    maxFeedFromServer = res.data["notification_count"];
    total_news = List<PostModal>.from(
        res.data["notifications"].map((x) => PostModal.fromJson(x)));
    lazyLoading = true;
    // if (res.data.containsKey('CommNotification'))
    //   total_news = List<SingleNews>.from(
    //       res.data["CommNotification"].map((x) => SingleNews.fromJson(x)));

    notifyListeners();
  }

  Future lazyData() async {
    List<PostModal> local = [];

    if (maxFeedFromServer > offset) {
      offset = limit;
      limit = limit + offsetDifference;
      Response res = await dioClient.getRequest(
        apiEnd: api_communication_get_notification,
        queryParameter: {'limit': limit, "offset": offset},
      );
      print(res);

      local = List<PostModal>.from(
          res.data["notifications"].map((x) => PostModal.fromJson(x)));

      total_news.addAll(local);

      notifyListeners();
    } else {
      lazyLoading = false;
      notifyListeners();
    }
  }

  like(int index) async {
    final res = await dioClient.postWithFormData(
        apiEnd: api_communication_like,
        data: {"notification_id": total_news[index].id});

    if (res.data['isSuccess']) {
      total_news[index].liked = true;
      total_news[index].likesCount = total_news[index].likesCount! + 1;
    }
    notifyListeners();
  }

  dislike(int index) async {
    final res = await dioClient.postWithFormData(
        apiEnd: api_communication_unlike,
        data: {"notification_id": total_news[index].id});

    if (res.data['isSuccess']) {
      total_news[index].liked = false;
      total_news[index].likesCount = total_news[index].likesCount! - 1;
      if (total_news[index].likesCount! < 0) {
        total_news[index].likesCount = 0;
      }
    }
    notifyListeners();
  }

  localCommentUdpate(int ind) async {
    total_news[ind].commentCount = total_news[ind].commentCount! + 1;
    notifyListeners();
  }
}
