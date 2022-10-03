


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import '../Components/Utilities/GlobalVar.dart';
import '../Components/Utilities/LinkList.dart';
import '../Controller/Login/LoginVC/Login-ContentColumnView.dart';
import '../Controller/Services/Payday_Today/PaydayMultipleCompany/PaydaySelectCompany.dart';
import '../Controller/Services/Payday_Today/PaydayTabbar/PaydayHomeTabbarVC.dart';
import '../Model/APIResponse/APIDataModel.dart';
import '../Server/Repo.dart';

void loginPayday(BuildContext loadingViewContext, BuildContext context,
    String userid,
    String password,
    String otp,
    String isAlwaysLogin
    ){



  void dismissLoadingView(){
    Navigator.pop(loadingViewContext);
  }
  void moveToHomePage(){
    Navigator.pushAndRemoveUntil<dynamic>(context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const PaydayHomeTabbar(),
        ), (route) => false
    );
  }

  void moveToSelectCompany() {
    Navigator.pushAndRemoveUntil<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context1) => PaydaySelectCompanyVC(),
        ),
            (route) => false);
  }

  void errorMessage(String error) {
    showToast(error,
        context: context,
        animation: StyledToastAnimation.slideFromTopFade,
        reverseAnimation: StyledToastAnimation.slideToTopFade,
        position: const StyledToastPosition(
            align: Alignment.topCenter, offset: 0.0),
        startOffset: const Offset(0.0, -3.0),
        reverseEndOffset: const Offset(0.0, -3.0),
        duration: const Duration(seconds: 4),
        //Animation duration   animDuration * 2 <= duration
        animDuration: const Duration(seconds: 1),
        curve: Curves.fastLinearToSlowEaseIn,
        reverseCurve: Curves.fastOutSlowIn);
  }

  init() async {
    var params = LinkListParams();
    params.add(MyEntry("imei",imei ?? "."));
    params.add(MyEntry("userid","63$userid"));
    params.add(MyEntry("password",password));
    params.add(MyEntry("devicetype",deviceType.toString().replaceAll("{", "").replaceAll("}", "")));
    params.add(MyEntry("type","LOGIN"));
    params.add(MyEntry("from","VERIFYLOGIN"));
    params.add(MyEntry("otp",otp));
    params.add(MyEntry("appVersion",appVersion));
    params.add(MyEntry("isalwayssignin",isAlwaysLogin));

    RepoClass repoClass = RepoClass();
    ResponseDataModel responseData = await repoClass.didStartCallAPI_noSession("api/wsb307","loginPayday",params);

    dismissLoadingView();

    if (responseData.status == "000") {
      //moveToHomePage();
      moveToSelectCompany();
      debugPrint('Select Company');
    } else {
      errorMessage(responseData.message.toString());
      print('A network error occurred');
    }

  }
  init();
}