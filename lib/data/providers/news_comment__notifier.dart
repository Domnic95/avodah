import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:southwind/Models/news/comment_modal.dart';
import 'package:southwind/data/providers/base_notifer.dart';
import 'package:southwind/utils/cloudinaryclient/cloudinary_client.dart';
import 'package:southwind/utils/cloudinaryclient/models/CloudinaryResponse.dart';
import 'package:southwind/utils/file_Picker.dart';

class NewsCommentNotifier extends BaseNotifier {
  String notificationId = "";
  bool isLoading = true;
  CloudinaryClient cloudinaryClient = CloudinaryClient();
  File_Picker file_picker = File_Picker();
  List<CommentModal> comments = [];
  NewsCommentNotifier(this.notificationId) {}
  loadComments() async {
    Response res = await dioClient.postWithFormData(
      apiEnd: apiCommentList,
      data: {
        'notification_id': notificationId,
      },
    );
    if (res.statusCode == 200) {
      comments = List<CommentModal>.from(
          res.data["comments"].map((x) => CommentModal.fromJson(x)));

      notifyListeners();
    }
    // isLoading = false;
    // if (hasListeners)
  }

  Future sendComment(String id, String text) async {
    final res = await dioClient
        .postWithFormData(apiEnd: api_communication_comment, data: {
      "notification_id": id,
      'comment': text,
      'media_url': "",
      'media_type': "",
    });
    loadComments();
  }

  Future imageUpload(
    ImageSource source,
    String id,
  ) async {
    String file = await file_picker.pickImage(source);

    CloudinaryResponse cloudinaryres = await cloudinaryClient.uploadImage(file,
        filename: "southDemoId", folder: 'Southwind');
    await uploadMedia(id, cloudinaryres.url!, "image");
  }

  Future videoUpload(ImageSource source, String id) async {
    String file = await file_picker.pickVideo(source);

    CloudinaryResponse cloudinaryres = await cloudinaryClient.uploadVideo(file,
        filename: "southDemoId", folder: 'Southwind');
    await uploadMedia(id, cloudinaryres.url!, "video");
  }

  Future uploadMedia(String id, String url, String media) async {
    final res = await dioClient
        .postWithFormData(apiEnd: api_communication_comment, data: {
      "notification_id": id,
      'comment': "--",
      'media_url': url,
      'media_type': media,
    });
    loadComments();
    print('res' + res.toString());
  }
}
