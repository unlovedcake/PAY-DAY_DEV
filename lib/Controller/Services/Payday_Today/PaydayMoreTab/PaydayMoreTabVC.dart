

import 'package:flutter/material.dart';
import 'package:my_app/Components/UI%20Design/Custom-Widget-Design.dart';
import 'package:my_app/Components/Utilities/GlobalVar.dart';
import 'package:my_app/Components/Utilities/Extensions.dart';
import 'package:my_app/Controller/Login/LoginVC/LoginVC.dart';

import 'package:my_app/Model/GK-DataModel/GKBorrowerProfileDataModel.dart';
import 'package:my_app/Persistent/gk_sqllite.dart';
import 'package:shared_preferences/shared_preferences.dart';

User userInfo = User();

Future<void> getUserInfo() async{
  SharedPref sharedPref = SharedPref();
  userInfo = User.fromJson(await sharedPref.read("user"));
}

Drawer sideBarDrawer(BuildContext context){



  void goToLoginPage(){
    Navigator.pushAndRemoveUntil<dynamic>(context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context1) => LoginVC(),
        ), (route) => false
    );
  }

  return 
    Drawer(
      elevation: 16.0,
      
      child: Column(
        children: [
          HeaderSideBar(),

          Container(height: 15),

          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 25, right: 10),
                child: const Text("Services", 
                  style: TextStyle(fontFamily: "SF-Pro-Round-Medium", fontSize: 15,color: Color(0xFF9A9A9A))
                ),
              ),

              gk_horizontalLine(color: const Color(0xFF9A9A9A))
            ]
          ),


          GestureDetector(
            child: ListTile(
              title: const Text("Logout"),
              leading: new Icon(Icons.mail),
            ),onTap: () async{


            SQLiteDbProvider.db.deleteDBQuery("UserProfile", userData?.id ?? -11);
            // SharedPref sharedPref = SharedPref();
            // GKBorrowerProfileDataModel user = GKBorrowerProfileDataModel.fromJson(await sharedPref.read("user"));



            SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('mobileNumber');

              goToLoginPage();

            },
          ),


          // Text(userData?.sessionid ?? ".")
        ]
      )

    );
}


Container HeaderSideBar(){



  getUserInfo();

  return 
  Container(
    color: const Color.fromARGB(232, 41, 55, 69),
    child: ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 50),
      child: IntrinsicHeight(

        child: 
          Stack(
            children: [
              Row(
                children: [
                  Row(
                    children: [
                      Container( 
                        margin: const EdgeInsets.only(left: 28),
                        width: 60, height: 60,
                        child: Image.asset('assets/payday-icon/pdy_profile_icon/pdy_default_photo.png')
                      ),

                      Container(
                        margin: const EdgeInsets.only(top: 55,bottom: 45,left: 15),
                        width: 180,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${userInfo.name?.capitalize()}",
                                style: const TextStyle(fontFamily: "SF-Pro-Round-Medium",fontSize: 17.7,color: Colors.white),
                                textAlign: TextAlign.right,
                              ),

                              Container(
                                margin: const EdgeInsets.only(top: 2),
                                width: 180,
                                child:  Text("+${userInfo.mobile?.capitalize()}",
                                          style: TextStyle(fontFamily: "SF-Pro-Round-Semibold", fontSize: 14, color: Color(0xFF9A9A9A))
                                        ),
                              )
                            ]
                        )
                      )
                    ]
                  ),

                  const Spacer(),
                ]
              ),

              Row(
                children: [
                  const Spacer(),
                  Column(
                    children: [
                      SizedBox(height:55,  
                        child: Image.asset('assets/payday-icon/pdy-tab-icon/payday_peelGK_menu/peelGK_icon.png')
                      ),
                      const Spacer()
                    ]
                  )
                ]
              )
            ]
          )
          

      )
    )
  );
}