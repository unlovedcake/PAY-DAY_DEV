import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/Components/Utilities/GlobalVar.dart';
import 'package:my_app/Controller/Services/Payday_Today/PaydayTabbar/PaydayHomeTabbarVC.dart';
import 'package:my_app/Model/GK-DataModel/GKBorrowerProfileDataModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'Controller/Login/LoginVC/LoginVC.dart';
import 'Persistent/gk_sqllite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // List<PaydayCompanyListDataModel>?  listCompanyData;
  // if (prefs.containsKey("companyListData")) {
  //
  //   var companyJSONData = prefs.getString("companyListData");
  //   listCompanyData = (companyJSONData as List)
  //       .map((itemWord) => PaydayCompanyListDataModel.fromMap(itemWord))
  //       .toList();
  //
  //   print('DECODEZZZZ ');
  //   //listCompanyData.map((e) => debugPrint(e.CompanyName.toString()));
  // }

  String? mobileNumber;


  SharedPreferences prefs = await SharedPreferences.getInstance();
  mobileNumber = prefs.getString('mobileNumber') ?? "";


  runApp(

    MaterialApp(
        debugShowCheckedModeBanner: false,

        home: mobileNumber == "" ? LoginVC() : PaydayHomeTabbar()

    ),
  );
}
