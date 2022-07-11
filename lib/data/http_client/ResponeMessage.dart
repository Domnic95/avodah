import 'dart:developer';

import 'package:dio/dio.dart';

void responeMessage(String urlType,String url, Response res) {
  log('-----> ${urlType} = ${url} <----');
  log(res.toString());
  log('-----> <----');
}
