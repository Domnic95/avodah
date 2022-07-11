import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:southwind/constant/Global.dart';
import 'package:southwind/data/config.dart';
import 'package:southwind/data/http_client/ResponeMessage.dart';
import 'package:southwind/utils/helpers.dart';
import 'package:southwind/utils/utilsContstant.dart';

class CustomInterCeptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // String temporaryToken =
    //     'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9tZmxpcC5jb21cL2FwaVwvbG9naW4iLCJpYXQiOjE2NDEyODU0OTMsImV4cCI6MTY0MTM3MTg5MywibmJmIjoxNjQxMjg1NDkzLCJqdGkiOiJuSEpQaENmM25HbVNENklYIiwic3ViIjoyNywicHJ2IjoiZjUyNmFmMTg4MmU5NDU2YzFiNjJhNTM0YWIwMzk4MTQyZmNhZTU5NSJ9.XMDWLQOrPY9sBzrSG7vcndFIUW22hVjvqRYSY8ZegRs';

    if (sharedPreferences.containsKey(key_user_token)) {
      String _user_Token = Utils.getPref(key_user_token)!;
      log("user token " + _user_Token);
      options.headers = {'Authorization': "Bearer ${_user_Token}"};
    }

    // print(user_Token);
    // options.headers = {'Authorization': "Bearer ${temporaryToken}"};
    super.onRequest(options, handler);
  }
}

class DioClient {
  Dio _dio = Dio(BaseOptions(
    baseUrl: BASE_URL,
  ))
    ..interceptors.add(CustomInterCeptor());
  Future<dynamic> getRequest(
      {required String apiEnd, Map<String, dynamic>? queryParameter}) async {
    try {
      final res = await _dio.get(apiEnd, queryParameters: queryParameter);
      responeMessage('get', apiEnd, res);
      return res;
    } on DioError catch (e) {
      return e.response;
    } catch (e) {
      log("get" + apiEnd + e.toString());
    }
  }

  Future<dynamic> postWithFormData(
      {required String apiEnd, Map<String, dynamic>? data}) async {
    try {
      final res = await _dio.post(apiEnd, data: FormData.fromMap(data ?? {}));
      //print("mmmm" + data.toString());
      responeMessage('post', apiEnd, res);
      // print("mmmm"+res.toString());
      return res;
    } on DioError catch (e) {
      return e.response;
    } catch (e) {
      log("post" + apiEnd + e.toString());
    }
  }
}
