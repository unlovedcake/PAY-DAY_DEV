import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';


import 'dart:io' show Platform;

import '../../../Components/Utilities/CommonFunc.dart';
import '../../../Components/Utilities/GlobalVar.dart';
import '../../../Components/Utilities/LinkList.dart';
import '../../../Model/PaydayTodayDataModel.dart';
import '../../Modal/LoadingView.dart';
import '../../Services/Payday_Today/PaydayMultipleCompany/PaydaySelectCompany.dart';
import '../../Services/Payday_Today/PaydayTabbar/PaydayHomeTabbarVC.dart';
import '/Model/APIResponse/APIDataModel.dart';
import '/Server/Repo.dart';
import 'SignUpVC.dart';
import 'Terms-Condition.dart';


void partialRegisterV3(BuildContext context,
    String? phoneNumber) {



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

  // void moveToHomePage() {
  //   Navigator.pushAndRemoveUntil<dynamic>(
  //       context,
  //       MaterialPageRoute<dynamic>(
  //         builder: (BuildContext context) => PaydayHomeTabbar(),
  //       ),
  //           (route) => false);
  // }

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
    var params = LinkListParams();
    params.add(MyEntry("mobile", '$phoneNumber'));
    params.add(MyEntry("countrycode", "63"));
    params.add(MyEntry("imei", imei ?? "."));
    params.add(MyEntry("from", "."));
    params.add(MyEntry("devicetype",
        deviceType.toString().replaceAll("{", "").replaceAll("}", "")));
    RepoClass repoClass = RepoClass();
    ResponseDataModel responseData = await repoClass.didStartCallAPI_noSession(
        "api/wsb03", "partialRegisterV2", params);


    try {


      if (responseData.status != "000") {



        errorMessage(responseData.message.toString());
        debugPrint('A network error occurred');
        dismissLoadingView();

        //dismissLoadingView();

      } else {

        //   var words =  decryptedData!.split('"');
        //   debugPrint( words[3] );
        //   debugPrint( words[7] );
        //   debugPrint('SESSIONID');
        //
        //   SharedPreferences prefs = await SharedPreferences.getInstance();
        //
        //   prefs.setString('sessionId',words[7]);
        //   prefs.setString('borrowerId',words[3]);
        dismissLoadingView();

        displayGeneralDialog(context, phoneNumber!);
        debugPrint('OKEY');
        debugPrint(responseData.status);


      }



    } catch (e) {
      debugPrint(e.toString());
    }
  }
  init();
}



Future<Object?> displayGeneralDialog(BuildContext context,String phoneNumber) {
  const begin = Offset(1.0, 0.0);
  const end = Offset.zero;
  const curve = Curves.ease;
  return showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
        MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return CustomDialog(phoneNumber:phoneNumber);
        },
        transitionBuilder:
            (context, animation, secondaryAnimation, child) {
          var tween = Tween(begin: begin, end: end)
              .chain(CurveTween(curve: curve));
          return FadeTransition(
              opacity: Tween<double>(
                begin: 0,
                end: 1,
              ).animate(animation),
              child: Align(
                child: SizeTransition(
                  sizeFactor: animation,
                  axisAlignment: 0.0,
                  child: child,
                ),
              ));
        },
      );
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
          print('A network error occurred');
        }
      }
    }

    init();
  }


// Future<String?> _getId() async {
//   var deviceInfo = DeviceInfoPlugin();
//   if (Platform.isIOS) { // import 'dart:io'
//     var iosDeviceInfo = await deviceInfo.iosInfo;
//     return iosDeviceInfo.identifierForVendor; // Unique ID on iOS
//   } else {
//     var androidDeviceInfo = await deviceInfo.androidInfo;
//     return androidDeviceInfo.id; // Unique ID on Android
//   }
// }