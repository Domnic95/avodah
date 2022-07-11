import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:southwind/constant/Global.dart';
import 'package:southwind/constant/slidedrection.dart';

class Utils {
  ///
  /// This method get Offset base on [sliderOpen] type
  ///

  static Offset getOffsetValues(SlideDirection direction, double value) {
    switch (direction) {
      case SlideDirection.LEFT_TO_RIGHT:
        return Offset(value, 0);
      case SlideDirection.RIGHT_TO_LEFT:
        return Offset(-value, 0);
      case SlideDirection.TOP_TO_BOTTOM:
        return Offset(0, value);
      default:
        return Offset(value, 0);
    }
  }

  static Offset getOffsetValueForShadow(
      SlideDirection direction, double value, double slideOpenWidth) {
    switch (direction) {
      case SlideDirection.LEFT_TO_RIGHT:
        return Offset(value - (slideOpenWidth > 50 ? 20 : 10), 0);
      case SlideDirection.RIGHT_TO_LEFT:
        return Offset(-value - 5, 0);
      case SlideDirection.TOP_TO_BOTTOM:
        return Offset(0, value - (slideOpenWidth > 50 ? 15 : 5));
      default:
        return Offset(value - 30.0, 0);
    }
  }

  static setPref(String name, String data) {
    sharedPreferences.setString(name, data);
  }

  static String? getPref(
    String name,
  ) {
    return sharedPreferences.getString(name);
  }

  static removePref() {
    sharedPreferences.clear();
  }

  static removeSingleKey(String key) {
    sharedPreferences.remove(key);
  }

  static setBool(String key,bool val){
    sharedPreferences.setBool(key, val);
  }
  static bool? getBool(String key){
    return sharedPreferences.getBool(key);
  }
}

showToast(String s) {
  Fluttertoast.showToast(msg: s, gravity: ToastGravity.SNACKBAR);
}

String DateToYYMMDD(DateTime dateTime){
  return "${dateTime.year}-${dateTime.month}-${dateTime.day}"; 
}