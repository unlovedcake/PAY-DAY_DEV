import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import 'package:my_app/Components/Utilities/CommonFunc.dart';
import 'package:my_app/Components/UI Design/TextField-Design.dart';
import 'package:my_app/Controller/ForgotPassword/forgot-password.dart';

import 'package:my_app/Controller/Login/LoginVC/Login-didClick-Login-Btn.dart';

import 'package:my_app/Controller/Modal/LoadingView.dart';

import '../../SignUp/SignUpVC/SignUpVC.dart';

// VIEW: contentColumnView
Column contentColumnView(
    BuildContext loadingViewContext,
    BuildContext context,
    double safeTop,
    Size screenSize,
    TextEditingController mobileNum,
    TextEditingController password) {
  return Column(
    children: [
      Row(
        children: [
          const Spacer(),
          Container(
              margin: EdgeInsets.only(top: safeTop + 40 + 35, right: 15),
              child: Text("Welcome to\nPayday Today.",
                  style: TextStyle(
                      fontFamily: "SF-Pro-Round-Bold",
                      fontSize: 28,
                      color: Colors.white.withOpacity(1.0)),
                  textAlign: TextAlign.right))
        ],
      ),

      const Spacer(),

      // Login Textfields UI View
      inputLoginUIView(loadingViewContext, context, safeTop, screenSize,
          mobileNum, password),

      const Spacer(),

      Row(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 18),
            child: Text("version 1.0",
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.withOpacity(0.8)),
                textAlign: TextAlign.left),
          ),
          const Spacer(),
          Container(
            margin: const EdgeInsets.only(bottom: 30),
            child: Text("Powered by:",
                style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(1)),
                textAlign: TextAlign.right),
          ),
          Container(
            margin: const EdgeInsets.only(right: 10, bottom: 7),
            width: 55,
            child: Image.asset(
              'assets/goodkredit-logo/new_gk _logo.png',
              fit: BoxFit.fill,
            ),
          )
        ],
      ),

      Container(height: (MediaQuery.of(context).viewInsets.bottom))
    ],
  );
}

errorMessage(String error, BuildContext context) {
  showToast(error,
      context: context,
      animation: StyledToastAnimation.slideFromTopFade,
      reverseAnimation: StyledToastAnimation.slideToTopFade,
      position: const StyledToastPosition(
          align: Alignment.topCenter, offset: 0.0),
      startOffset: const Offset(0.0, -3.0),
      reverseEndOffset: Offset(0.0, -3.0),
      duration: const Duration(seconds: 4),
      //Animation duration   animDuration * 2 <= duration
      animDuration: const Duration(seconds: 1),
      curve: Curves.fastLinearToSlowEaseIn,
      reverseCurve: Curves.fastOutSlowIn);

  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //   content: Text(error),
  //   duration: const Duration(seconds: 3),
  // ));
}

// VIEW: inputLoginUIView
Column inputLoginUIView(
    BuildContext loadingViewContext,
    BuildContext context,
    double safeTop,
    Size screenSize,
    TextEditingController mobileNum,
    TextEditingController password) {
  void startShowLoadingView() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context1) {
        loadingViewContext = context1;
        return GKLoadingView(parentContext: context);
      },
    );
  }

  return Column(
    children: [
      // mobile num txt field
      Container(
        width: screenSize.width - 66,
        padding: const EdgeInsets.only(left: 7, right: 7),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            Container(
                margin: const EdgeInsets.only(right: 5, left: 7),
                child: const Text("PH +63",
                    style:
                    TextStyle(fontWeight: FontWeight.w700, fontSize: 15))),
            Container(
              width: 1,
              height: 32,
              color: Colors.grey,
              margin: const EdgeInsets.only(right: 5),
            ),
            SizedBox(
                width: screenSize.width - 154,
                child: gkTxtField('Mobile Number', mobileNum,
                    keyboardType: TextInputType.number)),
          ],
        ),
      ),

      // password txtfield
      Container(
          height: 52,
          width: screenSize.width - 66,
          margin: const EdgeInsets.only(top: 7),
          padding: const EdgeInsets.only(left: 7, right: 7),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: PwdTextField(textController: password, txtLbl: "Password")),

      // Login button
      Container(
        margin: const EdgeInsets.only(top: 15, left: 28, right: 28, bottom: 5),
        width: screenSize.width - 66,
        decoration: BoxDecoration(
            color: const Color(0xFF86A16A),
            borderRadius: BorderRadius.circular(5)),
        child: MaterialButton(
          onPressed: () {
            if (mobileNum.text.length < 10) {
              errorMessage('Phone number must be 10 digits', context);
            } else if (password.text.isEmpty) {
              errorMessage('Password is required.', context);
            } else {
              init() async {
                FocusScope.of(context).unfocus();
                startShowLoadingView();
                loginV2(loadingViewContext, context, mobileNum.text,
                    password.text, "0", "LOGIN");
              }

              init();
            }
          },
          child: const Text("Login",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.white)),
        ),
      ),

      // forgot password buttonn
      MaterialButton(
        onPressed: () {
          Navigator.of(context)
              .push(createRoute(ForgotPassword()));
        },
        child: const Text("Forgot Password?",
            style: TextStyle(
                fontFamily: "SF-Pro-Round-Medium",
                fontSize: 16,
                color: Color(0xFF86A16A))),
      ),

      // always login check box
      Container(
        margin: const EdgeInsets.only(top: 2),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              width: 17,
              height: 17,
              margin: const EdgeInsets.only(right: 12),
              color: Colors.white,
              child: MaterialButton(onPressed: () {
                print("@@1");
              })),
          const Text("Always Login",
              style: TextStyle(
                  fontFamily: "SF-Pro-Round-Medium",
                  fontSize: 16,
                  color: Colors.white))
        ]),
      ),

      // not yet a member button
      Container(
        margin: const EdgeInsets.only(top: 45, bottom: 45),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text("Not yet a member?",
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 17,
                  color: Colors.white)),
          MaterialButton(
            minWidth: 70,
            padding: const EdgeInsets.all(0),
            onPressed: () {
              Navigator.of(context).push(createRoute(SignUpVC()));
            },
            child: const Text("Sign Up",
                style: TextStyle(
                    fontFamily: "SF-Pro-Round-Bold",
                    fontSize: 17,
                    color: Color(0xFF86A16A))),
          )
        ]),
      ),
    ],
  );
}