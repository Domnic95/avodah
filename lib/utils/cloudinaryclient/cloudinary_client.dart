library cloudinary_imageclient;

import 'package:southwind/utils/cloudinaryclient/data/VideoClient.dart';
import 'package:southwind/utils/cloudinaryclient/models/CloudinaryResponse.dart';

import 'data/ImageClient.dart';

class CloudinaryClient {
  String _apiKey = '161841721459867';
  String _apiSecret = 'O8sJxqNd7dLWkFb-KTsOnoOwQv4';
  String _cloudName = 'culture-up';
  ImageClient? _imageClient;
  VideoClient? _videoClient;

  CloudinaryClient() {
    this._imageClient = ImageClient(_apiKey, _apiSecret, _cloudName);
    this._videoClient = VideoClient(_apiKey, _apiSecret, _cloudName);
  }

  Future uploadImage(String imagePath,
      {String? filename, String? folder}) async {
    return _imageClient!
        .uploadImage(imagePath, imageFilename: filename!, folder: folder!);
  }

  Future<List<CloudinaryResponse>> uploadImages(List<String> imagePaths,
      {String? filename, String? folder}) async {
    List<CloudinaryResponse> responses = [];

    for (var path in imagePaths) {
      CloudinaryResponse resp = await _imageClient!
          .uploadImage(path, imageFilename: filename!, folder: folder!);
      responses.add(resp);
    }
    return responses;
  }

  Future<List<String>> uploadImagesStringResp(List<String> imagePaths,
      {String? filename, String? folder}) async {
    List<String> responses = [];

    for (var path in imagePaths) {
      CloudinaryResponse resp = await _imageClient!
          .uploadImage(path, imageFilename: filename!, folder: folder!);
      responses.add(resp.url!);
    }
    return responses;
  }

  Future<CloudinaryResponse> uploadVideo(String videoPath,
      {String? filename, String? folder}) async {
    return _videoClient!
        .uploadVideo(videoPath, videoFileName: filename!, folder: folder!);
  }
}
