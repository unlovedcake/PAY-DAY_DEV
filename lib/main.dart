import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/Components/Utilities/GlobalVar.dart';
import 'package:my_app/Controller/Services/Payday_Today/PaydayTabbar/PaydayHomeTabbarVC.dart';
import 'package:my_app/Model/GK-DataModel/GKBorrowerProfileDataModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'Controller/Login/LoginVC/LoginVC.dart';
import 'Persistent/gk_sqllite.dart';

void main() async{

  const encryptionChannel = MethodChannel('enc/dec');

  WidgetsFlutterBinding.ensureInitialized();
  // List<GKBorrowerProfileDataModel> sqlUserData = await SQLiteDbProvider.db.getAllUserProfile();
  // if (sqlUserData.isNotEmpty) {
  //   userData = sqlUserData[0];
  //   //STORING sha1OTP
  //   sha1OTP = await encryptionChannel
  //   .invokeMethod('sha1', {
  //     'data': sqlUserData[0].recentotp
  //   });
  // }

  String? mobileNumber;



  SharedPreferences prefs = await SharedPreferences.getInstance();
  mobileNumber = prefs.getString('mobileNumber') ?? "";

  runApp(
    // ignore: prefer_const_constructors
    MaterialApp(
      debugShowCheckedModeBanner: false,
        home: mobileNumber == "" ? LoginVC() : PaydayHomeTabbar()
      // home: sqlUserData.isEmpty ? LoginVC() : PaydayHomeTabbar()
    )
  );
}