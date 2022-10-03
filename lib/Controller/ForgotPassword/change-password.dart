
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Components/UI Design/Colors-Design.dart';
import '../../Components/UI Design/TextField-Design.dart';
import '../Login/LoginVC/Login-ContentColumnView.dart';
import '../SignUp/SignUpVC/SetUpPassword-API.dart';

class ChangePassword extends StatefulWidget {

  final String phoneNumber;

  const ChangePassword({required this.phoneNumber,Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

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
    if (password.text.length < 8) {
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
                  height: 200,
                  padding: EdgeInsets.all(8),
                  child: Image.asset('assets/goodkredit-logo/gk_logo.png')),


              Container(
                  width: size.width - 66,
                  margin: const EdgeInsets.only(top: 25),
                  child: const Text(
                      'Enter your new account password. \n'
                          'Your new password will be used to\n'
                          'login to another account',
                      style: TextStyle(fontSize: 17, color: Colors.white),
                      textAlign: TextAlign.center)),

              SizedBox(
                height: 4,
              ),
              passwordField('New Password', password, size),
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
                       setUpPassword(context, "","", "FORGETPASSWORD", widget.phoneNumber, password.text, );

                    }
                    // Navigator.of(context).push(createRoute(VerifyCodeVC()));
                  },
                  child: const Text("Change Password",
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
