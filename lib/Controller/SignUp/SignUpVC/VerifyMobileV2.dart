import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:my_app/Controller/SignUp/SignUpVC/VerifyCodeVC.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Components/Utilities/CommonFunc.dart';
import '../../../Components/Utilities/GlobalVar.dart';
import '../../../Components/Utilities/LinkList.dart';
import '../../../Components/Utilities/Extensions.dart';
import '../../../Model/PaydayTodayDataModel.dart';
import '../../Modal/LoadingView.dart';
import '../../Services/Payday_Today/PaydayMultipleCompany/PaydaySelectCompany.dart';
import '../../Services/Payday_Today/PaydayTabbar/PaydayHomeTabbarVC.dart';
import '/Model/APIResponse/APIDataModel.dart';
import '/Server/Repo.dart';

import 'SignUp-SetupVC.dart';
import 'SignUpVC.dart';

void verifyMobileV3(BuildContext context,
    String? phoneNumber,String? otpCode) {



  const encryptionChannel = MethodChannel('enc/dec');

  void startShowLoadingView() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context1) {
        context = context1;
        return GKLoadingView(parentContext: context);
      },
    );
  }

  void dismissLoadingView() {
    Navigator.of(context, rootNavigator: true).pop();
    //Navigator.pop(loadingViewContext); // error Looking up a deactivated widget's ancestor is unsafe
  }

  startShowLoadingView();

  void gotoToSingupSetUpVc() {
    Navigator.push<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => SignUpSetupVC(phoneNumber: phoneNumber!),
        ));
  }

  void errorMessage(String error) {
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
  }


  init() async {
    // var params = LinkListParams();
    //
    // params.add(MyEntry("imei", imei ?? "."));
    // params.add(MyEntry("userid", '$phoneNumber'));
    // params.add(MyEntry("usertype", "BORROWER"));
    // params.add(MyEntry("devicetype",
    //     deviceType.toString().replaceAll("{", "").replaceAll("}", "")),);
    // params.add(MyEntry("from", "."));
    // params.add(MyEntry("otp", otpCode ?? ""));
    //
    // // params.add(MyEntry("isalwayssignin", ''));
    //
    //
    // RepoClass repoClass = RepoClass();
    // ResponseDataModel responseData = await repoClass.didStartCallAPI_noSession(
    //     "api/wsb04", "verifyMobileV2", params);

    var params = LinkListParams();
    params.add(MyEntry("imei",imei ?? "."));
    params.add(MyEntry("userid","63$phoneNumber"));
    params.add(MyEntry("usertype","BORROWER"));
    params.add(MyEntry("devicetype",deviceType.toString().replaceAll("{", "").replaceAll("}", "")));
    params.add(MyEntry("from","."));
    params.add(MyEntry("otp",otpCode ?? ''));
    //params.add(MyEntry("index",'1'));
    //params.add(MyEntry("isalwayssignin","0"));

    RepoClass repoClass = RepoClass();
    ResponseDataModel responseData = await repoClass.didStartCallAPI_noSession(
        "api/wsb04V2","verifyMobileV3",params);



    try {


      if (responseData.status != "000") {
        errorMessage(responseData.message.toString());
        debugPrint('A network error occurred $otpCode');
        debugPrint('A network error occurred 63$phoneNumber');
        dismissLoadingView();

      } else {

        dismissLoadingView();
        Map<String, dynamic> res = json.decode(responseData.data ?? '.');

        var sesionID = res['sessionid'].toString();
        var borrowerID = res['borrowerid'].toString();

        debugPrint('SessionID: $sesionID');
        debugPrint('BorrowerID: $borrowerID');

        SharedPreferences prefs = await SharedPreferences.getInstance();

        prefs.setString('sessionId',sesionID);
        prefs.setString('borrowerId',borrowerID);

        sha1OTP = otpCode?.getSha1() ?? ".";

        debugPrint(sha1OTP);

        gotoToSingupSetUpVc();
        //Navigator.of(context).push(createRoute(SignUpSetupVC(phoneNumber: "$phoneNumber")));
        debugPrint('Validate OKEY');
        debugPrint(responseData.status);

      }



    } catch (e) {
      debugPrint(e.toString());
      dismissLoadingView();
    }
  }
  init();
}

