import 'dart:convert';

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:southwind/Models/team/team.dart';
import 'package:southwind/Models/user_data.dart';
import 'package:southwind/constant/Global.dart';
import 'package:southwind/data/providers/base_notifer.dart';
import 'package:southwind/utils/helpers.dart';
import 'package:southwind/utils/utilsContstant.dart';

class AuthNotifier extends BaseNotifier {
  bool isLogedIn = false;
  UserData? userData;
  // TeamData? teamData;
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  AuthNotifier() {
    intialize();
  }
  intialize() async {
    if (sharedPreferences.containsKey(key_user_token)) {
      //
      final res = await dioClient.getRequest(
        apiEnd: api_getUserData,
      );
      userData = UserData.fromJson(res.data['user']);
      isLogedIn = true;
      Utils.setPref(key_userinfo, jsonEncode(userData!.toJson()));
      notifyListeners();
    }
  }

  login(String email, password,bool keepMeLoggedIn) async {
    String? token = await firebaseMessaging.getToken();
    Utils.setBool(key_keep_me_logged_in, keepMeLoggedIn);
    final response =
        await dioClient.postWithFormData(apiEnd: api_loginApiEnd, data: {
      'email': email,
      'password': password,
      'device_token': token,
      "device_type": Platform.isAndroid ? "ANDROID" : "IOS"
    });

    if (response is Response) {
      if (response.statusCode == 200) {
        Utils.setPref(key_user_token, response.data['token']);
        userData = UserData.fromJson(response.data['user']);

        Utils.setPref(key_userinfo, jsonEncode(userData!.toJson()));
        isLogedIn = true;
      } else {
        if (response.data['isSuccess'] == false) {
          String? error = response.data['errors']['email'][0].toString();
          showToast(error);
        }
      }
    }
    notifyListeners();
  }

  logout() {
    isLogedIn = false;
    Utils.removePref();
    notifyListeners();
  }

  Future<String> forgetPassword(String email) async {
    final res = await dioClient.postWithFormData(
        apiEnd: api_forgetPassword, data: {"profile_email": email});

    return res.data['message'];
  }
}
