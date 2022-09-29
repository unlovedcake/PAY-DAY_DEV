import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:my_app/Components/Utilities/CommonFunc.dart';

import 'package:my_app/Components/UI Design/Colors-Design.dart';
import 'package:my_app/Components/UI Design/TextField-Design.dart';

import 'SignUp-SetupVC.dart';
import 'SignUpVC.dart';
import 'VerifyMobileV2.dart';

class VerifyCodeVC extends StatefulWidget {
  final String phoneNumber;
  const VerifyCodeVC({required this.phoneNumber,super.key});


  @override
  State<VerifyCodeVC> createState() => _VerifyCodeVC();
}

class _VerifyCodeVC extends State<VerifyCodeVC> {
  late TextEditingController verifyCode;

  TextEditingController otpController1 = TextEditingController();
  TextEditingController otpController2 = TextEditingController();
  TextEditingController otpController3 = TextEditingController();
  TextEditingController otpController4 = TextEditingController();
  TextEditingController otpController5 = TextEditingController();
  TextEditingController otpController6 = TextEditingController();

  late String finalCodeTxt;

  @override
  void initState() {
    verifyCode = TextEditingController()
      ..addListener(() {
        setState(() {
          if (verifyCode.text.length <= 6) {
            finalCodeTxt = verifyCode.text;
          }

          if (verifyCode.text.length == 6) {
            Navigator.of(context).push(createRoute(SignUpVC()));
          }else{
            if (verifyCode.text.length > 6){
              verifyCode.text = finalCodeTxt;
              verifyCode.selection = TextSelection.fromPosition(TextPosition(offset: verifyCode.text.length));
            }
          }
        });
      });
    super.initState();
  }


  LayoutBuilder otpTextField(bool first, last, TextEditingController? controller) {
    return LayoutBuilder(builder: (context, constraint) {
      if (constraint.maxWidth <= 263.0) {

        print(constraint.maxWidth);
        print('OKE');
        return SizedBox(
          width: 30,
          height: 40,
          child: TextFormField(
            controller: controller,
            //autofocus: true,
            onChanged: (value) {
              if (value.length == 1 && last == false) {
                FocusScope.of(context).nextFocus();
              }
              if (value.length == 0 && first == false) {
                FocusScope.of(context).previousFocus();
              }
            },
            // showCursor: false,

            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            keyboardType: TextInputType.number,
            maxLength: 1,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 1, top: 2),
              counter: const Offstage(),
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1, color: Colors.black12),
                  borderRadius: BorderRadius.circular(8)),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1,),
                  borderRadius: BorderRadius.circular(12)),
            ),
          ),
        );
      }else{
        return SizedBox(
          width: 40,
          height: 50,
          child: TextFormField(
            controller: controller,
            //autofocus: true,
            onChanged: (value) {
              if (value.length == 1 && last == false) {
                FocusScope.of(context).nextFocus();
              }
              if (value.length == 0 && first == false) {
                FocusScope.of(context).previousFocus();
              }
            },
            // showCursor: false,

            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
            keyboardType: TextInputType.number,
            maxLength: 1,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 1, top: 2),
              counter: const Offstage(),
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1, color: Colors.white),
                  borderRadius: BorderRadius.circular(8)),
              focusedBorder: OutlineInputBorder(
                  borderSide:  BorderSide(width: 1,color:   last  ? Colors.white :Colors.black),
                  borderRadius: BorderRadius.circular(12)),
            ),
          ),
        );
      }

    }
    );
  }

  @override
  void dispose() {
    verifyCode.dispose();
    super.dispose();
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
        title: const Text("Enter Verification Code"),
        centerTitle: true,
        backgroundColor: gkGetColor("gkBGTheme"),
        leading:
        InkWell(onTap: (){
          Navigator.pop(context);
        },
            child:
            Icon(
              Icons.arrow_back_ios,
              color: gkGetColor("gkSkyBlue") ,
            )
        ),
      ),
      body:   Center(
        child: Container(
          width: double.infinity,
          color: gkGetColor("gkBGTheme"),

          child:
          inputVerificationCodeView(context,topPadding,size),
        ),
      ),

    );
  }

  Column inputVerificationCodeView(BuildContext context, double safeTop, Size screenSize){
    return
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),

          Wrap(
            spacing: 4,
            children: [
              otpTextField(true, false, otpController1),
              otpTextField(true, false, otpController2),
              otpTextField(true, false, otpController3),
              otpTextField(true, false, otpController4),
              otpTextField(true, false, otpController5),
              otpTextField(true, true, otpController6),
            ],
          ),


          // verification note msg
          Container(
              width: screenSize.width - 66,
              margin: const EdgeInsets.only(top: 45),
              child: const Text("A verification code was sent to you via SMS which can take a while.\n\nThank you for your patience!",
                  style: TextStyle(fontSize: 17, color: Colors.white),
                  textAlign: TextAlign.center)
          ),

          Spacer(),
          OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white, //<-- SEE HERE
              ),
              onPressed: (){


                init() async {
                  FocusScope.of(context).unfocus();


                  String otpCode = otpController1.text + otpController2.text + otpController3.text +
                      otpController4.text + otpController5.text + otpController6.text ;

                  verifyMobileV3(
                    context,
                    widget.phoneNumber,
                    otpCode,
                  );
                }

                init();


              }, child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text('       Continue        ', style: GoogleFonts.lato(
              textStyle: const TextStyle(
                  letterSpacing: 1,
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),),
          )),

          const Spacer()
        ],
      );
  }
}