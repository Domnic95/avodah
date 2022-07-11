import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:southwind/Models/Group/GroupMember.dart';
import 'package:southwind/Models/Group/GroupMessages.dart';
import 'package:southwind/Models/Group/GroupModel.dart';
import 'package:southwind/Models/user_data.dart';
import 'package:southwind/UI/home/chat_tab/group_chat_screen.dart';
import 'package:southwind/data/providers/ValueFetcher/UserFetch.dart';
import 'package:southwind/data/providers/base_notifer.dart';
import 'package:southwind/data/providers/providers.dart';
import 'package:southwind/utils/File_Picker.dart';
import 'package:southwind/utils/cloudinaryclient/cloudinary_client.dart';
import 'package:southwind/utils/cloudinaryclient/models/CloudinaryResponse.dart';
import 'package:timezone/standalone.dart' as tz;

class GroupNotifier extends BaseNotifier {
  UserData? userData;
  CloudinaryClient cloudinaryClient = CloudinaryClient();
  File_Picker file_picker = File_Picker();
  List<Group> listGroup = [];
  List<GroupMessage> listOfMessage = [];
  List<GroupMessage> list = [];
  int? selectedGroupIndex;
  List<GroupMembers> listOfMembers = [];
  GroupMessagesinfo? groupinfo;
  GroupNotifier() {
    userData = UserFetch().fetchUserData();

    notifyListeners();
  }
  setGroupId(int id) {
    this.selectedGroupIndex = id;
    listOfMessage = [];
    listOfMembers = [];
    notifyListeners();
  }

  Future getAllGroup() async {
    listGroup = [];
    final res = await dioClient.postWithFormData(apiEnd: api_group_list);
    listGroup =
        List<Group>.from(res.data['groupsList'].map((e) => Group.fromJson(e)));

    notifyListeners();
    // if (res.data["groupsList"] != null) {
    //   groupinfo = GroupMessagesinfo.fromJson(res.data["groupsList"]);
    //   final int lastpage = res.data["groupsList"]["created_on"];
    // }
  }

  Future getfirstpage(cn, stop) async {
    cn = 1;
    // stop = 1;
    listOfMessage.clear();
    await getIndividualGroupMessages(cn, stop);
  }
  // Future _refresh(cn) async {
  //   await Future.delayed(Duration(seconds: 0, milliseconds: 2000));

  //   listOfMessage.clear();
  //   cn = 0;
  //   getIndividualGroupMessages(cn + 1);
  // }

  Future getIndividualGroupMessages(cn, stop) async {
    log("dsffdsfd = " + cn.toString());
    final res = await dioClient.getRequest(
        apiEnd: api_get_group_msgs,
        queryParameter: {
          "page": cn,
          "group_id": listGroup[selectedGroupIndex!].groupId
        });

    log("messgae = ${res}");
    for (int i = 0; i < cn; i++) {
      list = List<GroupMessage>.from(res.data['groupMessages']['data']
          .map((x) => GroupMessage.fromJson(x)));
    }

    listOfMessage.addAll(list);

    if (res.data["groupMessages"] != null) {
      groupinfo = GroupMessagesinfo.fromJson(res.data["groupMessages"]);
      final int lastpage = res.data["groupMessages"]["last_page"];
    }

    // listOfMessage.addAll(List<GroupMessage>.from(res.data['groupMessages']
    //         ['data']
    //     .map((x) => GroupMessage.fromJson(x))).reversed.toList());

    // for (int i = 1; i < res.data['groupMessages']['data'].length; i++) {
    //   list = List<GroupMessage>.from(res.data['groupMessages']['data']
    //       .map((x) => GroupMessage.fromJson(x))).reversed.toList();

    //   // List<GroupMessage>.from(res.data['groupMessages']['data']
    //   //     .map((x) => GroupMessage.fromJson(x))).reversed.toList();
    //   //log("length" + list.length.toString());
    //   list.clear();
    //   listOfMessage.addAll(list);
    // }

    // listOfMessage = List<GroupMessage>.from(res.data['groupMessages']['data']
    //     .map((x) => GroupMessage.fromJson(x))).reversed.toList();
    log("messgae = ${listOfMessage.length}");

    notifyListeners();
  }

  Future getGroupMembers() async {
    final res = await dioClient.postWithFormData(
        apiEnd: api_getGroup_participates,
        data: {"group_id": listGroup[selectedGroupIndex!].groupId});

    listOfMembers = List<GroupMembers>.from(
        res.data['groupMembers'].map((x) => GroupMembers.fromJson(x)));

    notifyListeners();
  }

  Future sendMessage(String text, cn, stop) async {
    final res =
        await dioClient.postWithFormData(apiEnd: api_sendMessage, data: {
      "group_id": listGroup[selectedGroupIndex!].groupId,
      'message': text,
      'media_url': "",
      'media_type': "",
    });
    notifyListeners();
    //  getfirstpage(0, 1);
  }

  Future imageUpload(ImageSource source) async {
    String file = await file_picker.pickImage(source);

    CloudinaryResponse cloudinaryres = await cloudinaryClient.uploadImage(file,
        filename: "southDemoId", folder: 'Southwind');
    uploadMedia(cloudinaryres.url!, "image");
  }

  Future videoUpload(ImageSource source) async {
    String file = await file_picker.pickVideo(source);

    CloudinaryResponse cloudinaryres = await cloudinaryClient.uploadVideo(file,
        filename: "southDemoId", folder: 'Southwind');
    uploadMedia(cloudinaryres.url!, "video");
  }

  Future uploadMedia(String url, String media) async {
    final res =
        await dioClient.postWithFormData(apiEnd: api_sendMessage, data: {
      "group_id": listGroup[selectedGroupIndex!].groupId,
      'message': '',
      'media_url': url,
      'media_type': media,
    });
  }
}
