import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_app/Components/Utilities/Extensions.dart';
import 'dart:io' show Platform;

import '../../../Components/Utilities/CommonFunc.dart';
import '../../../Components/Utilities/GlobalVar.dart';
import '../../../Components/Utilities/LinkList.dart';
import '../../../Model/GK-DataModel/GKBorrowerProfileDataModel.dart';
import '../../../Model/PaydayTodayDataModel.dart';
import '../../../Persistent/gk_sqllite.dart';
import '../../Modal/LoadingView.dart';
import '../../Modal/Modal_OTP_VC.dart';
import '../../Services/Payday_Today/PaydayMultipleCompany/PaydaySelectCompany.dart';
import '../../Services/Payday_Today/PaydayTabbar/PaydayHomeTabbarVC.dart';
import '/Model/APIResponse/APIDataModel.dart';
import '/Server/Repo.dart';
import 'SignUpVC.dart';
import 'Terms-Condition.dart';

void setUpPassword(BuildContext context, String firstName, String lastName,
    String from,String phoneNumber, String password) {
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

  void moveToHomePage() {
    Navigator.pushAndRemoveUntil<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => PaydayHomeTabbar(),
        ),
        (route) => false);
  }

  void errorMessage(String error) {
    showToast(error,
        context: context,
        animation: StyledToastAnimation.slideFromTopFade,
        reverseAnimation: StyledToastAnimation.slideToTopFade,
        position:
            const StyledToastPosition(align: Alignment.topCenter, offset: 0.0),
        startOffset: Offset(0.0, -3.0),
        reverseEndOffset: Offset(0.0, -3.0),
        duration: Duration(seconds: 4),
        //Animation duration   animDuration * 2 <= duration
        animDuration: Duration(seconds: 1),
        curve: Curves.fastLinearToSlowEaseIn,
        reverseCurve: Curves.fastOutSlowIn);
  }

  void getEmployersInfo() {
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

  init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var sessionID = prefs.getString('sessionId') ?? "B0043";
    var borrowerID = prefs.getString('borrowerId') ?? "B0043";

    debugPrint("SESSIONID: $sessionID");
    debugPrint("BORROWERID: $borrowerID");

    var params = LinkListParams();
    if(from == ".") {
      params.add(MyEntry("password", password));
      params.add(MyEntry("mobile", '63$phoneNumber'));
      params.add(MyEntry("imei", imei!));
      params.add(MyEntry("borrowerid", borrowerID));
      params.add(MyEntry("userid", '63$phoneNumber'));
      params.add(MyEntry("from", from));
      params.add(MyEntry("firstname", firstName));
      params.add(MyEntry("lastname", lastName));

    }else{
      params.add(MyEntry("password", password));
      params.add(MyEntry("mobile", '$phoneNumber'));
      params.add(MyEntry("imei", imei!));
      params.add(MyEntry("borrowerid", borrowerID));
      params.add(MyEntry("userid", '$phoneNumber'));
      params.add(MyEntry("from", from));

    }
    RepoClass repoClass = RepoClass();
    ResponseDataModel responseData =
        await repoClass.didStartCallAPI_withSession(
            sessionID, "api/wsb05V2", "setupPasswordV2", params);



    try {
      if (responseData.status != "000") {
        errorMessage(responseData.message.toString());
        debugPrint('A network error occurred');
        dismissLoadingView();
      } else {

        if(from == "."){

          debugPrint(responseData.data);

          User user = User();
          SharedPref sharedPref = SharedPref();

          user.firstName = firstName;
          user.lastName = lastName ;
          user.mobile = '63$phoneNumber' ;

          sharedPref.save("user", user);
          prefs.setString('mobileNumber', "63$phoneNumber" ?? "");

          debugPrint('SuccessFully Added');
        }

        dismissLoadingView();

        moveToHomePage();
        debugPrint('Password Changed');


        // User userInfo = User.fromJson(await sharedPref.read("user"));

        // debugPrint(userInfo.name.toString());
        // debugPrint('OKEYS');

      //   Map<String, dynamic> jsonData =
      //       json.decode(responseData.data?.toLowerCase().trim() ?? ".");
      //   GKBorrowerProfileDataModel decodedData =
      //       GKBorrowerProfileDataModel.fromMap(jsonData["profile"]);
      //   String querySTR = '''
      // INSERT Into UserProfile (id, sessionid, borrowerid, borrowername, borrowertype, firstname,
      // middlename, lastname, birthdate, gender, occupation,
      // interest, emailaddress, isverified, mobileno, imei,
      // userid, password, lastlogin, longitude, latitude,
      // billingaddress, streetaddress, city, province, zip,
      // country, dateregistration, datetimelinked, guarantorid, isviasubguarantor,
      // dateapprovedbyguarantor, creditratingbyguarantor, status, profilepicurl, recentotp, extra1,
      // extra2, extra3, extra4, notes1, notes2)
      // VALUES (?,?,?,?,?,?, ?,?,?,?,? ,?,?,?,?,? ,?,?,?,?,? ,?,?,?,?,? ,?,?,?,?,? ,?,?,?,?,?,? ,?,?,?,?,?)
      // ''';
      //   List values = [
      //     decodedData.id,
      //     "${jsonData['sessionid']}",
      //     "${decodedData.borrowerid?.toUpperCase()}",
      //     "${decodedData.borrowername?.toUpperCase()}",
      //     "${decodedData.borrowertype?.toUpperCase()}",
      //     "${decodedData.firstname?.toUpperCase()}",
      //     "${decodedData.middlename?.toUpperCase()}",
      //     "${decodedData.lastname?.toUpperCase()}",
      //     "${decodedData.birthdate}",
      //     "${decodedData.gender}",
      //     "${decodedData.occupation}",
      //     "${decodedData.interest}",
      //     "${decodedData.emailaddress}",
      //     decodedData.isverified,
      //     "${decodedData.mobileno}",
      //     "${decodedData.imei}",
      //     "${decodedData.userid}",
      //     "${decodedData.password}",
      //     "${decodedData.lastlogin}",
      //     "${decodedData.longitude}",
      //     "${decodedData.latitude}",
      //     "${decodedData.billingaddress?.toUpperCase()}",
      //     "${decodedData.streetaddress?.toUpperCase()}",
      //     "${decodedData.city?.toUpperCase()}",
      //     "${decodedData.province?.toUpperCase()}",
      //     decodedData.zip,
      //     "${decodedData.country?.toUpperCase()}",
      //     "${decodedData.dateregistration}",
      //     "${decodedData.datetimelinked}",
      //     "${decodedData.guarantorid}",
      //     decodedData.isviasubguarantor,
      //     "${decodedData.dateapprovedbyguarantor}",
      //     "${decodedData.creditratingbyguarantor}",
      //     "${decodedData.status}",
      //     "${decodedData.profilepicurl}",
      //     "${decodedData.recentotp}",
      //     "${decodedData.extra1}",
      //     "${decodedData.extra2}",
      //     "${decodedData.extra3}",
      //     "${decodedData.extra4}",
      //     "${decodedData.notes1}",
      //     "${decodedData.notes2}"
      //   ];
      //   SQLiteDbProvider.db.insertDBQuery("UserProfile", querySTR, values);
      //
      //   List<GKBorrowerProfileDataModel> sqlUserData =
      //       await SQLiteDbProvider.db.getAllUserProfile();
      //   if (sqlUserData.isNotEmpty) {
      //     userData = sqlUserData[0];
      //
      //     //STORING sha1OTP
      //     sha1OTP = sqlUserData[0].recentotp?.getSha1();
      //     // moveToHomePage();
      //     getEmployersInfo();
      //   } else if (responseData.status == "201") {
      //     showDialog(
      //         barrierDismissible: false,
      //         context: context,
      //         builder: (context) => showModalOTPView(
      //             context, responseData.message ?? "",
      //             userid: phoneNumber, password: password));
      //   } else {
      //     print('A network error occurred');
      //   }
      }
    } catch (e) {
      debugPrint('ERROR');
      debugPrint(e.toString());
    }
  }

  init();
}

Future<Object?> displayGeneralDialog(BuildContext context, String phoneNumber) {
  const begin = Offset(1.0, 0.0);
  const end = Offset.zero;
  const curve = Curves.ease;
  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black45,
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (BuildContext buildContext, Animation animation,
        Animation secondaryAnimation) {
      return CustomDialog(phoneNumber: phoneNumber);
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
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
