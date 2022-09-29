import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:my_app/Controller/Services/Payday_Today/PaydayMultipleCompany/PaydaySelectCompany.dart';
import 'dart:io' show Platform;
import 'package:my_app/Controller/Services/Payday_Today/PaydayTabbar/PaydayHomeTabbarVC.dart';
import 'package:my_app/Model/GK-DataModel/GKBorrowerProfileDataModel.dart';
import 'package:my_app/Model/PaydayTodayDataModel.dart';
import 'package:my_app/Persistent/gk_sqllite.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/Model/APIResponse/APIDataModel.dart';
import '/Server/Repo.dart';

import 'package:my_app/Components/Utilities/GlobalVar.dart';
import 'package:my_app/Components/Utilities/LinkList.dart';
import 'package:my_app/Controller/Modal/Modal_OTP_VC.dart';




void loginV2(BuildContext loadingViewContext, BuildContext context,
    String userid, String password, String isAlwaysLogin, String loginType) {
  const encryptionChannel = MethodChannel('enc/dec');
  void dismissLoadingView() {

    Navigator.of(context, rootNavigator: true).pop();
    //Navigator.pop(loadingViewContext); // error Looking up a deactivated widget's ancestor is unsafe
  }

  void moveToHomePage() {
    Navigator.pushAndRemoveUntil<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => PaydayHomeTabbar(),
        ),
            (route) => false);
  }

  void errorMessage(String error){


    showToast(error,
        context: context,
        animation: StyledToastAnimation.slideFromTopFade,
        reverseAnimation: StyledToastAnimation.slideToTopFade,
        position: const StyledToastPosition(
            align: Alignment.topCenter, offset: 0.0),
        startOffset: Offset(0.0, -3.0),
        reverseEndOffset: Offset(0.0, -3.0),
        duration: Duration(seconds: 4),
        //Animation duration   animDuration * 2 <= duration
        animDuration: Duration(seconds: 1),
        curve: Curves.fastLinearToSlowEaseIn,
        reverseCurve: Curves.fastOutSlowIn);
    // ScaffoldMessenger.of(context).showSnackBar( SnackBar(
    //   content: Text(error),
    //   duration: const Duration(seconds: 3),
    // ));
  }


  init() async {
    var params = LinkListParams();
    params.add(MyEntry("imei", imei ?? "."));
    params.add(MyEntry("userid", "63$userid"));
    params.add(MyEntry("password", password));
    params.add(MyEntry("devicetype",
        deviceType.toString().replaceAll("{", "").replaceAll("}", "")));
    params.add(MyEntry("type", loginType));
    params.add(MyEntry("isalwayssignin", isAlwaysLogin));

    RepoClass repoClass = RepoClass();
    ResponseDataModel responseData = await repoClass.didStartCallAPI_noSession(
        "api/wsb01V2", "loginV2", params);



    if (responseData.status != "000") {
      dismissLoadingView();
    }

    if (responseData.status == "000") {

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('mobileNumber', "63$userid" ?? ".");


      Map<String, dynamic> jsonData =
      json.decode(responseData.data?.toLowerCase().trim() ?? ".");
      GKBorrowerProfileDataModel decodedData =
      GKBorrowerProfileDataModel.fromMap(jsonData["profile"]);
      String querySTR = '''
      INSERT Into UserProfile (id, sessionid, borrowerid, borrowername, borrowertype, firstname,
      middlename, lastname, birthdate, gender, occupation,
      interest, emailaddress, isverified, mobileno, imei,
      userid, password, lastlogin, longitude, latitude, 
      billingaddress, streetaddress, city, province, zip,
      country, dateregistration, datetimelinked, guarantorid, isviasubguarantor,
      dateapprovedbyguarantor, creditratingbyguarantor, status, profilepicurl, recentotp, extra1,
      extra2, extra3, extra4, notes1, notes2) 
      VALUES (?,?,?,?,?,?, ?,?,?,?,? ,?,?,?,?,? ,?,?,?,?,? ,?,?,?,?,? ,?,?,?,?,? ,?,?,?,?,?,? ,?,?,?,?,?)
      ''';
      List values = [
        decodedData.id,
        "${jsonData['sessionid']}",
        "${decodedData.borrowerid?.toUpperCase()}",
        "${decodedData.borrowername?.toUpperCase()}",
        "${decodedData.borrowertype?.toUpperCase()}",
        "${decodedData.firstname?.toUpperCase()}",
        "${decodedData.middlename?.toUpperCase()}",
        "${decodedData.lastname?.toUpperCase()}",
        "${decodedData.birthdate}",
        "${decodedData.gender}",
        "${decodedData.occupation}",
        "${decodedData.interest}",
        "${decodedData.emailaddress}",
        decodedData.isverified,
        "${decodedData.mobileno}",
        "${decodedData.imei}",
        "${decodedData.userid}",
        "${decodedData.password}",
        "${decodedData.lastlogin}",
        "${decodedData.longitude}",
        "${decodedData.latitude}",
        "${decodedData.billingaddress?.toUpperCase()}",
        "${decodedData.streetaddress?.toUpperCase()}",
        "${decodedData.city?.toUpperCase()}",
        "${decodedData.province?.toUpperCase()}",
        decodedData.zip,
        "${decodedData.country?.toUpperCase()}",
        "${decodedData.dateregistration}",
        "${decodedData.datetimelinked}",
        "${decodedData.guarantorid}",
        decodedData.isviasubguarantor,
        "${decodedData.dateapprovedbyguarantor}",
        "${decodedData.creditratingbyguarantor}",
        "${decodedData.status}",
        "${decodedData.profilepicurl}",
        "${decodedData.recentotp}",
        "${decodedData.extra1}",
        "${decodedData.extra2}",
        "${decodedData.extra3}",
        "${decodedData.extra4}",
        "${decodedData.notes1}",
        "${decodedData.notes2}"
      ];
      SQLiteDbProvider.db.insertDBQuery("UserProfile", querySTR, values);

      List<GKBorrowerProfileDataModel> sqlUserData =
      await SQLiteDbProvider.db.getAllUserProfile();
      if (sqlUserData.isNotEmpty) {
        userData = sqlUserData[0];

        //STORING sha1OTP
        sha1OTP = await encryptionChannel
            .invokeMethod('sha1', {'data': sqlUserData[0].recentotp});
        // moveToHomePage();
        getEmployersInfo(loadingViewContext, context);
      }
    } else if (responseData.status == "201") {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => showModalOTPView(
              context, responseData.message ?? "",
              userid: userid, password: password));
    } else {

      errorMessage(responseData.message.toString());
      debugPrint('A network error occurred');
    }


  }

  init();
}

void getEmployersInfo(BuildContext loadingViewContext, BuildContext context) {
  Future<bool> dismissLoadingView() async {
    Navigator.pop(loadingViewContext);

    return true;
  }

  void moveToHomePage() {
    Navigator.pushAndRemoveUntil<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context1) => PaydayHomeTabbar(),
        ),
            (route) => false);
  }

  void moveToSelectCompany() {
    Navigator.pushAndRemoveUntil<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context1) => PaydaySelectCompanyVC(),
        ),
            (route) => false);
  }

  init() async {
    var sessionID = userData?.sessionid ?? ".";

    var params = LinkListParams();
    params.add(MyEntry("imei", imei ?? "."));
    params.add(MyEntry("userid", userData?.userid ?? "."));
    params.add(MyEntry("borrowerid", userData?.borrowerid ?? "."));
    params.add(MyEntry("devicetype",
        deviceType.toString().replaceAll("{", "").replaceAll("}", "")));

    RepoClass repoClass = RepoClass();
    ResponseDataModel responseData =
    await repoClass.didStartCallAPI_withSession(
        sessionID, "api/wsb319", "getEmployersInfo", params);

    bool isDataLoaded = await dismissLoadingView();
    if (isDataLoaded) {
      if (responseData.status == "000") {
        final jsonData = json.decode((responseData.data ?? "."));
        List<PaydayCompanyListDataModel> decodedData = (jsonData as List)
            .map((itemWord) => PaydayCompanyListDataModel.fromMap(itemWord))
            .toList();
        print(decodedData[0].EmployerID);
        print(decodedData.length);
        if (decodedData.length > 1) {
          moveToSelectCompany();
        } else {
          moveToHomePage();
        }
      } else {

        showToast(responseData.message,
            context: context,
            animation: StyledToastAnimation.slideFromTopFade,
            reverseAnimation: StyledToastAnimation.slideToTopFade,
            position: const StyledToastPosition(
                align: Alignment.topCenter, offset: 0.0),
            startOffset: Offset(0.0, -3.0),
            reverseEndOffset: Offset(0.0, -3.0),
            duration: Duration(seconds: 4),
            //Animation duration   animDuration * 2 <= duration
            animDuration: Duration(seconds: 1),
            curve: Curves.fastLinearToSlowEaseIn,
            reverseCurve: Curves.fastOutSlowIn);
        print('A network error occurreds');
      }
    }
  }

  init();
}