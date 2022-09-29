// ignore_for_file: file_names, must_be_immutable
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/Controller/Login/LoginVC/Login-ContentColumnView.dart';


import 'package:my_app/Components/UI Design/TextField-Design.dart';
import 'package:my_app/Components/UI Design/Colors-Design.dart';
import 'package:my_app/Components/Utilities/CommonFunc.dart';
import 'package:my_app/Controller/SignUp/SignUpVC/Terms-Condition.dart';

import 'PartialRegisterV3-API.dart';



class SignUpVC extends StatelessWidget {
  String titleName = "";

  SignUpVC({Key? key, this.titleName = "Create Account"}) : super(key: key);

  final TextEditingController mobileNum = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            elevation: 2.0,
            titleSpacing: 10.0,
            title: Text(titleName),
            backgroundColor: gkGetColor("gkBGTheme"),
            centerTitle: true,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios, color: gkGetColor("gkSkyBlue")),
            )),
        body: LayoutBuilder(
          builder: (layoutcontext, constraints) => SingleChildScrollView(
              child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                      child: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                          child: Container(
                              width: constraints.maxWidth,
                              color: gkGetColor("gkBGTheme"),
                              child: inputMobileNumView(
                                  context, topPadding, size)))))),
        ));
  }

  Column inputMobileNumView(
      BuildContext context, double safeTop, Size screenSize) {
    return Column(children: [

      Container(
          height: 200,
          padding: EdgeInsets.all(8),
          child: Image.asset('assets/goodkredit-logo/gk_logo.png')),

      // philippines text
      Container(
          margin: const EdgeInsets.only(top: 30),
          width: screenSize.width - 66,
          padding: const EdgeInsets.only(left: 7, right: 7),
          height: 55,
          decoration: BoxDecoration(
              color: const Color(0xFFEEEEEE),
              borderRadius: BorderRadius.circular(5)),
          child: Row(children: [
            Container(
                margin: const EdgeInsets.only(left: 18),
                child: const Text("Philippines",
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 17))),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: gkGetColor("gkSkyBlue"),
              size: 20,
            ),
          ])),

      // mobile num txt field
      Container(
          margin: const EdgeInsets.only(top: 7),
          width: screenSize.width - 66,
          padding: const EdgeInsets.only(left: 7, right: 7),
          height: 55,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Row(children: [
            Container(
                margin: const EdgeInsets.only(right: 7, left: 18),
                child: const Text("PH +63",
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 15))),
            Container(
              width: 1,
              height: 28,
              color: Colors.grey,
              margin: const EdgeInsets.only(right: 5),
            ),
            Container(
                width: screenSize.width - 167,
                margin: const EdgeInsets.only(bottom: 4),
                child: gkTxtField('Mobile Number', mobileNum,
                    keyboardType: TextInputType.number))
          ])),

      // signup button
      Container(
        margin: const EdgeInsets.only(top: 7, left: 28, right: 28, bottom: 5),
        width: screenSize.width - 66,
        height: 43,
        decoration: BoxDecoration(
            color: gkGetColor("gkBtnColor"),
            borderRadius: BorderRadius.circular(5)),
        child: MaterialButton(
          onPressed: () async{
            if (mobileNum.text.length < 10) {
              errorMessage('Phone number must be 10 digits', context);
            } else {

              //Navigator.pop(context);
              init() async {
                FocusScope.of(context).unfocus();

                partialRegisterV3(
                  context,
                  mobileNum.text,
                );
              }

              init();



            }

          },
          child: const Text("Sign Up",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.white)),
        ),
      ),

      // forgot password msg note
      Container(
        width: screenSize.width - 66,
        margin: titleName.contains("Forgot")
            ? const EdgeInsets.only(top: 45)
            : const EdgeInsets.all(0),
        child: titleName.contains("Forgot")
            ? const Text(
                "To retrieve your account, enter your account mobile number.",
                style: TextStyle(fontSize: 17, color: Colors.white),
                textAlign: TextAlign.center)
            : const Text(""),
      ),

      // already a member button
      Container(
        margin: const EdgeInsets.only(top: 45, bottom: 45),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text("Already a member?",
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 17,
                  color: Colors.white)),
          MaterialButton(
            minWidth: 55,
            padding: const EdgeInsets.all(0),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Login",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                    color: Colors.white)),
          )
        ]),
      ),

      const Spacer()
    ]);
  }

  // Future<Object?> displaySignUpDialogConfirmation(BuildContext context) {
  //
  //   const begin = Offset(1.0, 0.0);
  //   const end = Offset.zero;
  //   const curve = Curves.ease;
  //
  //   return showGeneralDialog(
  //             context: context,
  //             barrierDismissible: true,
  //             barrierLabel:
  //                 MaterialLocalizations.of(context).modalBarrierDismissLabel,
  //             barrierColor: Colors.black45,
  //             transitionDuration: const Duration(milliseconds: 300),
  //             pageBuilder: (BuildContext buildContext, Animation animation,
  //                 Animation secondaryAnimation) {
  //               return CustomDialog(phoneNumber: mobileNum.text);
  //             },
  //             transitionBuilder:
  //                 (context, animation, secondaryAnimation, child) {
  //               var tween = Tween(begin: begin, end: end)
  //                   .chain(CurveTween(curve: curve));
  //               return FadeTransition(
  //                   opacity: Tween<double>(
  //                     begin: 0,
  //                     end: 1,
  //                   ).animate(animation),
  //                   child: Align(
  //                     child: SizeTransition(
  //                       sizeFactor: animation,
  //                       axisAlignment: 0.0,
  //                       child: child,
  //                     ),
  //                   ));
  //             },
  //           );
  // }


}

class CustomDialog extends StatelessWidget {
  final String phoneNumber;

  const CustomDialog({required this.phoneNumber, super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(
            top: 28.0,
          ),
          margin: const EdgeInsets.only(top: 63.0, right: 8.0),
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 0.0,
                  offset: Offset(0.0, 0.0),
                ),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(
                height: 20.0,
              ),
              Center(
                  child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "We will verifying your phone \n number \n",
                      style: TextStyle(fontSize: 18.0, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                    Text('+63$phoneNumber \n',
                        style: TextStyle(fontSize: 18.0, color: Colors.black)),
                    const Text(
                      'Is this OK or would you like to \n edit the number?',
                      style: TextStyle(fontSize: 18.0, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ) //
                  ),
              SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(16.0),
                            bottomRight: Radius.circular(16.0)),
                      ),
                      child: const Text(
                        "EDIT",
                        style: TextStyle(color: Colors.blue, fontSize: 20.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(16.0),
                            bottomRight: Radius.circular(16.0)),
                      ),
                      child: const Text(
                        "OK",
                        style: TextStyle(color: Colors.blue, fontSize: 20.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onTap: () {
                       Navigator.of(context).pushReplacement(createRoute( TermsAndConditions(phoneNumber: phoneNumber)));
                    },
                  ),
                ],
              )
            ],
          ),
        ),
        Positioned(
          top: 25,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Align(
              alignment: Alignment.topCenter,
              child: CircleAvatar(
                radius: 40.0,
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.priority_high,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
      ],
    );


  }
}


