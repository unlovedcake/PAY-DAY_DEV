import 'package:flutter/material.dart';

import 'package:my_app/Controller/Login/LoginVC/Login-BGView.dart';
import 'package:my_app/Controller/Login/LoginVC/Login-ContentColumnView.dart';
import 'package:my_app/Model/GK-DataModel/GKBorrowerProfileDataModel.dart';
import 'package:my_app/Persistent/gk_sqllite.dart';

class LoginVC extends StatefulWidget {
  late StatefulElement _element;
  bool get mounted => _element != null;
  
  @override
  State<LoginVC> createState() => _LoginVC();
}

class _LoginVC extends State<LoginVC>{
  // Login Textfields UI
  late BuildContext loadingViewContext;
  late TextEditingController mobileNum;
  late String finalMobileNumTxt;
  final TextEditingController password = TextEditingController();

  @override
  void initState() {
    // mobile num
    mobileNum = TextEditingController()
    ..addListener(() {
      setState(() {
        if (mobileNum.text.isNotEmpty) {
          if (mobileNum.text[0] == "0"){
            mobileNum.text = mobileNum.text.substring(1);
            mobileNum.selection = TextSelection.fromPosition(TextPosition(offset: mobileNum.text.length));
          } 
          
          if (mobileNum.text.length <= 10) {
            finalMobileNumTxt = mobileNum.text;
          }

          if (mobileNum.text.length > 10){
            mobileNum.text = finalMobileNumTxt;
            mobileNum.selection = TextSelection.fromPosition(TextPosition(offset: mobileNum.text.length));
          }
        }
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    mobileNum.dispose();
    super.dispose();
  }

  @override  
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Size size = MediaQuery.of(context).size;
    loadingViewContext = context;

    return Scaffold(
      resizeToAvoidBottomInset: false,

      body:
      LayoutBuilder(
        
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight + keyboardHeight),

            child: IntrinsicHeight(
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Stack(
                  children: [
                    //background UI View - Login-BGView.dart
                    columnBGView(topPadding,size),

                    // Textform UI View - Login-ContentColumnView.dart
                    contentColumnView(loadingViewContext,context,topPadding,size,mobileNum,password)
                  ]
                )
              )
            )

          )
        )
        
      )

    );
  }
  
}

