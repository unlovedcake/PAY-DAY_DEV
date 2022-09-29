import 'package:flutter/material.dart';
import 'package:my_app/Components/Utilities/GlobalVar.dart';
import 'package:my_app/Components/Utilities/LinkList.dart';
import 'package:my_app/Controller/Modal/LoadingView.dart';
import 'package:my_app/Controller/Services/Payday_Today/PaydayTabbar/PaydayHomeTabbarVC.dart';
import 'package:my_app/Model/APIResponse/APIDataModel.dart';
import 'package:my_app/Server/Repo.dart';



// class ModalOTPView extends StatefulWidget {
//   String modalMsg = "";

//   @override
//   State<ModalOTPView> createState() => _ModalOTPView();
// }

// class _ModalOTPView extends State<ModalOTPView>{

//   @override 
//   Widget build(BuildContext context) {
//     return showModalView();

//   }

//   void showModalView(){
//       showDialog(
//         barrierDismissible: false,
//         context: context, 
//         builder: (context) => showModalOTPView(context, widget.modalMsg)
//       );
//   }
// }

AlertDialog showModalOTPView(BuildContext context, 
String msg,
{String userid = ".",
String password = "."}) {

  BuildContext? loadingViewContext;
  final TextEditingController otpVal = TextEditingController();
  late String finalOtpVal = "";

  //======================================================================
  //                        START: Action Codes
  //======================================================================
  void cancelBtn(){
    Navigator.of(context).pop();
  }

  void startShowLoadingView(){
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context1){
        loadingViewContext = context1;
        return  GKLoadingView(parentContext: context);
      },
    );
  }

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
          builder: (BuildContext context) => PaydayHomeTabbar(),
        ), (route) => false
      );
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
        moveToHomePage();
      } else {
        print('A network error occurred');
      }

    }
    init();
  }
  //======================================================================
  //                        END: Action Codes
  //======================================================================



  //======================================================================
  //                        START: UI Related Codes
  //======================================================================
  return
  AlertDialog(
    title: const Text("OTP Verification"),
    content:  IntrinsicHeight(
      child:  Column(
                children: [
                  TextField(
                    controller: otpVal,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: "Enter six digit Code"),
                    style: const TextStyle(fontSize: 17),
                    textAlign: TextAlign.center,
                    onChanged: (text){
                      if (otpVal.text.length <= 6) {
                        otpVal.text = text;
                        finalOtpVal = otpVal.text;
                        otpVal.selection = TextSelection.fromPosition(TextPosition(offset: otpVal.text.length));
                      }

                      if (otpVal.text.length > 6){
                        otpVal.text = finalOtpVal;
                        otpVal.selection = TextSelection.fromPosition(TextPosition(offset: otpVal.text.length));
                      }
                    }
                  ),

                  Container(margin: const EdgeInsets.only(top: 7, left: 7, right: 7),
                    child: Text(msg, 
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                      textAlign: TextAlign.left,
                    ),
                  )
                ],
              ),
    ),
    actions: [
      TextButton(
        child:  const Text("CANCEL", 
                  style: TextStyle(color: Colors.black),
                ),
        onPressed: (){
          cancelBtn();
        }
      ),

      TextButton(
        child: const Text("OK", 
                  style: TextStyle(color: Colors.black),
                ),
        onPressed: (){
          startShowLoadingView();
          loginPayday(loadingViewContext = context, context, userid, password,finalOtpVal,"0");
        }
      )
    ],
  );
  //======================================================================
  //                        END: UI Related Codes
  //======================================================================
}