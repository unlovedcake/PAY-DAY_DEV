import 'dart:math';

import 'package:my_app/Components/Utilities/GlobalVar.dart';
import 'package:my_app/Components/Utilities/LinkList.dart';
import 'package:my_app/Components/Utilities/Extensions.dart';
import 'dart:collection';

import 'package:dio/dio.dart';
import '/Server/Utility.dart';
import '/Model/APIResponse/APIDataModel.dart';

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


class RepoClass {
  late didStartCallAPIwithSession mClient;
  late didStartCallAPInoSession mClient1;

  RepoClass() {
      mClient = didStartCallAPIwithSession(Dio());
      mClient1 = didStartCallAPInoSession(Dio());

  }

  String endPoint = '';
  String callName = '';
  String paramString = '';
  List indexVal = [];
  String authenticationid = '';
  String key = '';
  String encryptedData = '';
  String decryptedData = '';

  static const encryptionChannel = MethodChannel('enc/dec');



  Future<ResponseDataModel> didStartCallAPI_noSession(String endpoint, String callname, LinkListParams params) async {
    endPoint = endpoint;
    callName = callname;
    paramString = params.toParams();
    indexVal = params.index();

    print("{$paramString}");

    debugPrint("{$indexVal}");

    // STEP 1
    authenticationid = "${indexVal[1]}".getSha1();

    // STEP 2
    key = "$authenticationid$callName".getSha1();


    // // STEP 1
    // authenticationid = await encryptionChannel
    // .invokeMethod('sha1', {
    //   'data': indexVal[1]
    // });
    //
    // // STEP 2
    // key = await encryptionChannel
    // .invokeMethod('sha1', {
    //   'data': "$authenticationid$callName"
    // });

    // STEP 3
    encryptedData = await encryptionChannel
    .invokeMethod('encrypt', {
      'data': "{$paramString,${indexVal[0]}}",
      'key': key,
    });


    // STEP 4 : last
    return mClient1.postAPInoSession(authenticationid,encryptedData,endPoint,callname,key);
  }

  Future<ResponseDataModel> didStartCallAPI_withSession(String sessionid, String endpoint, String callname, LinkListParams params) async {
    endPoint = endpoint;
    callName = callname;
    paramString = params.toParams();

    // STEP 1
    Random random = Random();
    int randOTPsha = random.nextInt(5);
    List<String> splittedOTP = sha1OTP?.splitByLength(8) ?? [".",".",".",".","."];
    String getOTPshavalue = splittedOTP[randOTPsha];

    // STEP2
    indexVal = params.index(otpRandomInt: randOTPsha); //only insert otpRandomInt if API with session
    if(callName == 'setupPasswordV2'){
      authenticationid = "${indexVal[1]}$sessionid".getSha1();

    }else{
      authenticationid = "${indexVal[1]}$getOTPshavalue$sessionid".getSha1();
    }

    // STEP 3
    key = "$authenticationid$sessionid$callName".getSha1();

    // STEP 4
    encryptedData = await encryptionChannel
        .invokeMethod('encrypt', {
      'data': "{$paramString,${indexVal[0]}}",
      'key': key,
    });
    // STEP 5 : last
    return mClient.postAPIwithSession(authenticationid,sessionid,encryptedData,endPoint,callname,key);
  }
}