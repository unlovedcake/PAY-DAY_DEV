import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'package:my_app/Model/GK-DataModel/GKBorrowerProfileDataModel.dart';

String? imei = ".";


String? sha1OTP;
GKBorrowerProfileDataModel? userData ;

// VERSION CONTROL
String appTypeCode = "0";// 0 = GK App, 1 = Payday Standalone .... value changes @AppDelegate login()
String appVersion = "112";
String paydayAppVersion = "2";

var deviceType = {
  if (Platform.isAndroid) {
    "ANDROID"
  } else if (Platform.isIOS) {
    "IOS"
  }
};
