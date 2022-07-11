import 'package:dio/dio.dart';
  String apiBaseUrl = "https://api.cloudinary.com/v1_1/";
class BaseApi {
 
  final Dio dio = Dio(
    BaseOptions(
    baseUrl: apiBaseUrl,
  )
  );

 

  BaseApi();

  // Future<Dio> getApiClient(InterceptorsWrapper interceptor) async {
  //   assert(interceptor != null);
  //   _dio.options.baseUrl = apiBaseUrl;
  //   _dio.interceptors.clear();
  //   if (interceptor != null) {
  //     _dio.interceptors.add(interceptor);
  //   }
  //   return _dio;
  // }

  Future<Response<T>> httpGet<T>(String url,
      {Map<String, dynamic>? params}) async {
  
    if (params != null)
      return await dio.get(url, queryParameters: params);
    else
      return await dio.get(url);
  }

  Future<Response<T>> httpPost<T>(
      String url, Map<String, dynamic> params) async {
   
    if (params != null)
      return await dio.post(url, data: params);
    else
      return await dio.post(url);
  }
}
