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


//dev url
String BuildConfig_BUILD_TYPE = "dev";
String linkv1 = "http://staging-wsborrower.goodkredit.com/"; //v1
const String link = "http://localhost:8193/";
// String link1 = "http://172.16.16.100:8084/";
String link1 = "http://172.16.16.100:3309/";
String sentimosLink = "http://m.me/SentimosTesting";
String SOAlink = "https://www.goodkredi®t.com/";
String s3link = "https://s3-us-west-1.amazonaws.com/goodkredit/";
bool isDebugMode = false;
String BUCKETNAME = "gk-profile";
String SUPPORT_BUCKETNAME = "gk-support";
String FREENETKEY = "b2JHRJTbjaAOVXVo7X6eZx8iihiDDR70sb6dijJm3Oe8S5K";
String SOA_WEBVIEW_URL = "http://staging-admin.goodkredit.com/#/soabilling/3/";
String NL_RL_MsgrUrl = "http://m.me/111976910417769";

