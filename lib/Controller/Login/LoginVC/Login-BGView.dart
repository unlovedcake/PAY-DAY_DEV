import 'package:flutter/material.dart';

// START: background UI View
  Column columnBGView(double safeTop, Size screenSize) {
    return 
      Column(
        children: [
          Container(
            height: 40,
            margin: EdgeInsets.only(top: (safeTop + 17) - 15, bottom: 10),
            child: Center(child: Image.asset('assets/payday-login/pdy_logo_nav.png')),
          ),

          Center(child: pdyBGView(screenSize)),
        ],
      );
  }

  SizedBox pdyBGView(Size screenSize){
    return 
    SizedBox(
      width: (screenSize.width * 1.85),
      height: (screenSize.height * 0.95) - 50, // 50 = columnBGView() height
      child: Stack(

        alignment: AlignmentDirectional.topCenter,
        children: [
          Positioned(
            bottom: 40,
            right: -((screenSize.width / 2) + 40),
            top: 0,
            left: -79,
            child: Image.asset(
              'assets/payday-login/payday-login-bg.png',
              fit: BoxFit.fill,
            ),
          ),
        ],

      ),
    );
  }  
// END: background UI View