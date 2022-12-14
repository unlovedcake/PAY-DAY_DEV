import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GKBorrowerProfileDataModel {  
  //--------- set 10 ----------
  late int? id;
  late String? sessionid;
  late String? borrowerid;
  late String? borrowername;
  late String? borrowertype;
  late String? firstname;
  late String? middlename;
  late String? lastname;
  late String? birthdate;
  late String? gender; 

  late String? occupation;
  late String? interest;
  late String? emailaddress;
  late int? isverified;
  late String? mobileno;
  late String? imei;
  late String? userid;
  late String? password;
  late String? lastlogin;
  late String? longitude; 

  late String? latitude;
  late String? billingaddress;
  late String? streetaddress;
  late String? city;
  late String? province;
  late int? zip;
  late String? country;
  late String? dateregistration;
  late String? datetimelinked;
  late String? guarantorid; 

  late int? isviasubguarantor;
  late String? dateapprovedbyguarantor;
  late String? creditratingbyguarantor;
  late String? status;
  late String? profilepicurl;
  late String? recentotp;
  late String? extra1;
  late String? extra2;
  late String? extra3;
  late String? extra4;
  late String? notes1;
  late String? notes2;



  static final columns = ["id", "sessionid", "borrowerid", "borrowername", "borrowertype",
                        "firstname", "middlename", "lastname", "birthdate", "gender",
                        "occupation", "interest", "emailaddress", "isverified", "mobileno", 
                        "imei", "userid", "password", "lastlogin", "longitude", 
                        "latitude", "billingaddress", "streetaddress", "city", "province",
                        "zip", "country", "dateregistration", "datetimelinked", "guarantorid", 
                        "isviasubguarantor", "dateapprovedbyguarantor", "creditratingbyguarantor", "status", "profilepicurl", "recentotp",
                        "extra1", "extra2", "extra3", "extra4", "notes1", "notes2"];

  GKBorrowerProfileDataModel(this.id, this.sessionid, this.borrowerid, this.borrowername, this.borrowertype,
                            this.firstname, this.middlename, this.lastname, this.birthdate, this.gender, 
                            this.occupation, this.interest, this.emailaddress, this.isverified, this.mobileno, 
                            this.imei, this.userid, this.password, this.lastlogin, this.longitude, 
                            this.latitude, this.billingaddress, this.streetaddress, this.city, this.province,
                            this.zip, this.country, this.dateregistration, this.datetimelinked, this.guarantorid,
                            this.isviasubguarantor, this.dateapprovedbyguarantor, this.creditratingbyguarantor, this.status, this.profilepicurl, this.recentotp,
                            this.extra1, this.extra2, this.extra3, this.extra4, this.notes1, this.notes2);
  factory GKBorrowerProfileDataModel.fromMap(Map<String, dynamic> data) {
    return GKBorrowerProfileDataModel(
        data['ID'], data['sessionid'], data['BorrowerID'], data['BorrowerName'], data['BorrowerType'],
        data['FirstName'], data['MiddleName'], data['LastName'], data['BirthDate'], data['Gender'],
        data['Occupation'], data['Interest'], data['EmailAddress'], data['isVerified'], data['MobileNo'],
        data['imei'], data['UserID'], data['Password'], data['LastLogin'], data['Longitude'],
        data['Latitude'], data['BillingAddress'], data['StreetAddress'], data['City'], data['Province'],
        data['Zip'], data['Country'], data['DateRegistration'], data['DateTimeLinked'], data['GuarantorID'],
        data['isViaSubGuarantor'], data['DateApprovedByGuarantor'], data['CreditratingByGuarantor'], data['Status'], data['ProfilePicURL'], data['RecentOTP'],
        data['Extra1'], data['Extra2'], data['Extra3'], data['Extra4'], data['Notes1'], data['Notes2']
    );
  }


  // factory GKBorrowerProfileDataModel.fromMap(data) {
  //   return GKBorrowerProfileDataModel(
  //       id: data['ID'], sessionid: data['sessionid'], borrowerid: data['BorrowerID'], borrowername: data['BorrowerName'], borrowertype:data['BorrowerType'],
  //       firstname: data['FirstName'],middlename: data['MiddleName'], lastname:data['LastName'], birthdate:data['BirthDate'], gender:data['Gender'],
  //       occupation: data['Occupation'], interest:data['Interest'], emailaddress:data['EmailAddress'], isverified:data['isVerified'], mobileno:data['MobileNo'],
  //       imei: data['imei'], userid: data['UserID'], password:data['Password'], lastlogin:data['LastLogin'], longitude:data['Longitude'],
  //       latitude:data['Latitude'], billingaddress:data['BillingAddress'], streetaddress:data['StreetAddress'], city:data['City'], province:data['Province'],
  //       zip:data['Zip'], country:data['Country'], dateregistration:data['DateRegistration'], datetimelinked:data['DateTimeLinked'], guarantorid:data['GuarantorID'],
  //       isviasubguarantor:data['isViaSubGuarantor'], dateapprovedbyguarantor:data['DateApprovedByGuarantor'], creditratingbyguarantor:data['CreditratingByGuarantor'], status:data['Status'], profilepicurl:data['ProfilePicURL'], recentotp:data['RecentOTP'],
  //       extra1:data['Extra1'], extra2:data['Extra2'], extra3:data['Extra3'], extra4:data['Extra4'], notes1:data['Notes1'], notes2:data['Notes2']
  //   );
  // }



  Map<String, dynamic> toMap() => {
    "id": id, "sessionid": sessionid, "borrowerid": borrowerid, "borrowername": borrowername, "borrowertype": borrowertype,
    "firstname": firstname, "middlename": middlename, "lastname": lastname, "birthdate": birthdate, "gender": gender,
    "occupation": occupation, "interest": interest, "emailaddress": emailaddress, "isverified": isverified, "mobileno": mobileno,
    "imei": imei, "userid": userid, "password": password, "lastlogin": lastlogin, "longitude": longitude,
    "latitude": latitude, "billingaddress": billingaddress, "streetaddress": streetaddress, "city": city, "province": province,
    "zip": zip, "country": country, "dateregistration": dateregistration, "datetimelinked": datetimelinked, "guarantorid": guarantorid,
    "isviasubguarantor": isviasubguarantor, "dateapprovedbyguarantor": dateapprovedbyguarantor, "creditratingbyguarantor": creditratingbyguarantor, "status": status, "profilepicurl": profilepicurl,
    "extra1": extra1, "extra2": extra2, "extra3": extra3, "extra4": extra4, "notes1": notes1, "notes2": notes2
  };



  // GKBorrowerProfileDataModel.fromJson(Map<String, dynamic> json)
  //     :
  //       id= json['id'],
  //       sessionid= json['sessionid'],  borrowerid= json['borrowerid'],
  //       borrowername= json['borrowername'],  borrowertype= json['borrowertype'],
  //       firstname= json['firstname'], middlename= json['middlename'],
  //       lastname= json['lastname'],birthdate= json['birthdate'],
  //       gender = json['gender'],occupation= json['occupation'],
  //       interest= json['interest'],emailaddress= json['emailaddress'],
  //       isverified= json['isverified'],mobileno= json['mobileno'],
  //       imei= json['imei'],userid= json['userid'],
  //       password= json['password'],lastlogin= json['lastlogin'],
  //       longitude= json['longitude'],latitude= json['latitude'],
  //       billingaddress= json['billingaddress'],streetaddress= json['streetaddress'],
  //       city= json['city'],province= json['province'],
  //       zip= json['zip'],country= json['country'],
  //       dateregistration= json['dateregistration'],datetimelinked= json['datetimelinked'],
  //       guarantorid= json['guarantorid'],isviasubguarantor= json['isviasubguarantor'],
  //       dateapprovedbyguarantor= json['dateapprovedbyguarantor'],creditratingbyguarantor= json['creditratingbyguarantor'],
  //       status= json['status'],profilepicurl= json['profilepicurl'],
  //       extra1= json['extra1'], extra2= json[' extra2'],
  //       extra3= json['extra3'], extra4= json[' extra4'],
  //       notes1= json['notes1'],notes2= json['notes2'];


  GKBorrowerProfileDataModel.fromJson(Map<String, dynamic> json)
      :

        firstname= json['firstname'],
        lastname= json['lastname'],mobileno= json['mobileno'];



// static List< GKBorrowerProfileDataModel> decode(String musics) =>
  //     (json.decode(musics) as List<dynamic>)
  //         .map< GKBorrowerProfileDataModel>((item) => GKBorrowerProfileDataModel.fromMap(item))
  //         .toList();

  //
  // static String encode(List<GKBorrowerProfileDataModel> musics) => json.encode(
  //   musics
  //       .map<Map<String, dynamic>>((music) => GKBorrowerProfileDataModel.toMap(music))
  //       .toList(),
  // );

}

class User {
  String? firstName;
  String? lastName;
  String? mobile;


  User();

  User.fromJson(Map<String, dynamic> json)
      : firstName = json['firstName'],
        lastName = json['lastName'],
        mobile = json['mobile'];


  Map<String, dynamic> toJson() => {
    'firstName': firstName,
    'lastName': lastName,
    'mobile': mobile,

  };
}

class GKBorrowerProfileDataModel1 {  
  //--------- set 10 ----------
  final int id;
  late final String sessionid;
  late final String borrowerid;
  final String borrowername;
  final String borrowertype;
  final String firstname;

  static final columns = ["id", "sessionid", "borrowerid", "borrowername", "borrowertype", "firstname"]; 
  GKBorrowerProfileDataModel1(this.id, this.sessionid, this.borrowerid, this.borrowername, this.borrowertype, this.firstname); 
  factory GKBorrowerProfileDataModel1.fromMap(Map<String, dynamic> data) {
    return GKBorrowerProfileDataModel1( 
        data['id'],
        data['sessionid'],
        data['borrowerid'],
        data['borrowername'],
        data['borrowertype'],
        data['firstname']
    ); 
  } 
  Map<String, dynamic> toMap() => {
    "id": id,
    "sessionid": sessionid,
    "borrowerid": borrowerid,
    "borrowername": borrowername,
    "borrowertype": borrowertype,
    "firstname": firstname
  };



}



class SharedPref {
  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(key).toString());
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
