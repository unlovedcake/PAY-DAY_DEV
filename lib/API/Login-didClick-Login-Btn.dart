import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:my_app/Components/Utilities/Extensions.dart';
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
      errorMessage(responseData.message.toString());

    }

    else if (responseData.status == "000") {

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('mobileNumber', "63$userid" ?? ".");


      Map<String, dynamic> jsonData = json.decode(responseData.data ?? ".");

      GKBorrowerProfileDataModel decodedData =  GKBorrowerProfileDataModel.fromMap(jsonData["profile"]);

      var jsonEncodedData = json.encode(jsonData);



      String sesionId = jsonData['sessionid'].toString();

      prefs.setString("gkBorrowerProfile", jsonEncodedData );



      prefs.setString('sessionId', sesionId);
      sha1OTP = decodedData.recentotp?.getSha1();

      //debugPrint(decodedData.toMap().toString());

      debugPrint("SHAOTP1");
      debugPrint(jsonEncodedData.toString());



      if (prefs.containsKey("gkBorrowerProfile")) {

       // GKBorrowerProfileDataModel?  listCompanyData;

        var companyJSONData = json.decode((prefs.getString("gkBorrowerProfile")!));
        //listCompanyData = GKBorrowerProfileDataModel.fromMap(companyJSONData);

        GKBorrowerProfileDataModel decodedData =  GKBorrowerProfileDataModel.fromMap(companyJSONData["profile"]);


        print('DECODEZZZZ ');
        print( companyJSONData);
        print(  decodedData.firstname);
        print(  decodedData.lastname);
        //listCompanyData.map((e) => debugPrint(e.CompanyName.toString()));
      }

     //getEmployersInfo( context,userid);


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

void getEmployersInfo( BuildContext context, String userId) {
  Future<bool> dismissLoadingView() async {
    Navigator.pop(context);

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


    SharedPreferences prefs = await SharedPreferences.getInstance();

    var sessionID = prefs.getString('sessionId') ?? ".";
    var borrowerID = prefs.getString('borrowerId') ?? ".";


    var params = LinkListParams();
    params.add(MyEntry("imei", imei ?? "."));
    params.add(MyEntry("userid", '63$userId'));
    params.add(MyEntry("borrowerid", borrowerID ));
    params.add(MyEntry("devicetype",
        deviceType.toString().replaceAll("{", "").replaceAll("}", "")));

    RepoClass repoClass = RepoClass();
    ResponseDataModel responseData =
    await repoClass.didStartCallAPI_withSession(
        sessionID, "api/wsb319", "getEmployersInfo", params);



      if (responseData.status == "000") {
        final jsonData  = json.decode((responseData.data ?? "."));
        List<PaydayCompanyListDataModel> decodedData = (jsonData as List).map((value) => PaydayCompanyListDataModel.fromMap(value)).toList();

        final jsonEncodedData = json.encode(decodedData.map((item) => item.toJson()).toList());

        SharedPreferences prefs = await SharedPreferences.getInstance();

        prefs.setString("companyListData", jsonEncodedData );




        if (prefs.containsKey("companyListData")) {

          List<PaydayCompanyListDataModel>?  listCompanyData;

          var companyJSONData = json.decode((prefs.getString("companyListData")!));
          listCompanyData = (companyJSONData as List)
              .map((itemWord) => PaydayCompanyListDataModel.fromMap(itemWord))
              .toList();

         // final jsonEncodedDatas = json.encode(listCompanyData.map((item) => item.toJson()).toList().toString());
          print('DECODEZZZZ ');
          print( listCompanyData.map((e) => e.EmployeeID));
          print( listCompanyData.first.EmployeeID);
          //listCompanyData.map((e) => debugPrint(e.CompanyName.toString()));
        }



        print('DECODE');
        debugPrint(jsonData.toString());

        print(decodedData[0].EmployerID);
        print(decodedData.length);
        if (decodedData.length > 1) {
          moveToSelectCompany();
        } else {
         // moveToHomePage();
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
        debugPrint(sessionID);

      }

  }

  init();
}