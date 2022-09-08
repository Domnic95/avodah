import 'package:flutter/widgets.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';

class Internet {
  bool connected = false;
  checkInternetConn() async {
    connected = await InternetConnectionChecker().hasConnection;
    final msg = connected ? "Connected to Internet" : "No internet Connection";
    showSimpleNotification(Text("$msg"));
  }
}
