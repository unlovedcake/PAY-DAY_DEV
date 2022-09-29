import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:my_app/Components/UI Design/Colors-Design.dart';
import 'package:my_app/Components/UI Design/TextField-Design.dart';
import 'package:my_app/Controller/SignUp/SignUpVC/SetUpPassword-API.dart';

import '../../../Components/Utilities/CommonFunc.dart';
import '../../../Model/PaydayTodayDataModel.dart';
import '../../Login/LoginVC/Login-ContentColumnView.dart';

import 'PartialRegisterV3-API.dart';
import 'VerifyCodeVC.dart';

class SignUpSetupVC extends StatefulWidget {
  final String phoneNumber;
  const SignUpSetupVC({required this.phoneNumber,super.key});

  @override
  State<SignUpSetupVC> createState() => _SignUpSetupVC();
}

class _SignUpSetupVC extends State<SignUpSetupVC> {
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();


  // regular expression to check if string
  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");

  //A function that validate user entered password
  bool validatePassword(String pass) {
    String _password = pass.trim();
    if (pass_valid.hasMatch(_password)) {
      return true;
    } else {
      return false;
    }
  }

  bool isValidationHasNoError(){
    if (firstName.text.isEmpty) {
      errorMessage('First Name is required.', context);
    } else if (lastName.text.isEmpty) {
      errorMessage('Last Name is required.', context);
    }  else if (password.text.length < 8) {
      errorMessage('Password must be minimum 8 characters', context);
    } else if (password.text.isEmpty) {
      errorMessage('Password is required.', context);
    } else if (confirmPassword.text != password.text) {
      errorMessage('Confirm Password does not match.', context);
    } else {
      //call function to check password
      bool result = validatePassword(password.text);
      if (!result) {
        errorMessage('Password must contain atleast one upper case'
            ' and lower case and atleast one charater and atleast one number. ', context);

      } else {

        return true;

      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 2.0,
        titleSpacing: 10.0,
        title: const Text("Create Account"),
        centerTitle: true,
        backgroundColor: gkGetColor("gkBGTheme"),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: gkGetColor("gkSkyBlue"),
            )),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: gkGetColor("gkBGTheme"),
          width: size.width,
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: size.width - 66,
                  margin: const EdgeInsets.only(top: 25),
                  child: const Text(
                      'To secure your account, kindly input your name and password.',
                      style: TextStyle(fontSize: 17, color: Colors.white),
                      textAlign: TextAlign.center)),

              textFields('First Name', firstName, size),
              textFields('Last Name', lastName, size),
              SizedBox(
                height: 4,
              ),
              passwordField('Password', password, size),
              passwordField('Confirm Password', confirmPassword, size),

              Container(
                  width: size.width - 66,
                  margin: const EdgeInsets.only(top: 12),
                  child: const Text(
                      'Password must be a minimum 8 characters long, a combination of uppercase, lowercase, number and a symbol character (@#\$%&+=.!_).',
                      style: TextStyle(fontSize: 14.5, color: Colors.white),
                      textAlign: TextAlign.left)),

              SizedBox(
                height: size.height * .1,
              ),

              // signup button
              Container(
                margin: const EdgeInsets.only(
                    top: 15, left: 28, right: 28, bottom: 5),
                width: size.width - 66,
                height: 43,
                decoration: BoxDecoration(
                    color: gkGetColor("gkBtnColor"),
                    borderRadius: BorderRadius.circular(5)),
                child: MaterialButton(
                  onPressed: () {




                      if(isValidationHasNoError()){
                        setUpPassword(context, firstName.text,lastName.text, widget.phoneNumber, password.text);

                      }
                    // Navigator.of(context).push(createRoute(VerifyCodeVC()));
                  },
                  child: const Text("Sign Up",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.white)),
                ),
              ),

            ],
          ),
        ),
      ),

    );
  }

  Widget passwordField(
      String hint, TextEditingController controller, Size size) {
    return Container(
        height: 52,
        width: size.width - 66,
        margin: const EdgeInsets.only(top: 7, bottom: 4),
        padding: const EdgeInsets.only(left: 7, right: 7),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: PwdTextField(textController: controller, txtLbl: hint));
  }

  Widget textFields(String hint, TextEditingController controller, Size size) {
    return Container(
        width: size.width - 66,
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.only(left: 7, right: 7),
        height: 53,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Container(
            margin: const EdgeInsets.only(bottom: 4),
            child: gkTxtField(hint, controller)));
  }


}
