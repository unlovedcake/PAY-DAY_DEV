import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/Components/Utilities/GlobalVar.dart';
import 'package:my_app/Components/Utilities/LinkList.dart';
import 'dart:collection';

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/GK-DataModel/GKBorrowerProfileDataModel.dart';
import '/Model/APIResponse/APIDataModel.dart';

import 'package:flutter/services.dart';

part 'Utility.g.dart';




// @RestApi(baseUrl: "http://localhost:8193/")
@RestApi(baseUrl: link)
abstract class didStartCallAPInoSession {
  factory didStartCallAPInoSession(Dio dio) = _didStartCallAPInoSession;

  @POST("POST")
  @FormUrlEncoded()
  Future<ResponseDataModel> postAPInoSession(
    @Header("authenticationid") String authenticationid,
    @Field("df06651788c884556a0b4b290fb40475ec9a45ba") String param,
    String endPoint,
    String callName,
    String key
  );
}

// @RestApi(baseUrl: "http://localhost:8193/")
@RestApi(baseUrl: link)
abstract class didStartCallAPIwithSession {
  factory didStartCallAPIwithSession(Dio dio) = _didStartCallAPIwithSession;
  
  @POST("POST")
  @FormUrlEncoded()
  Future<ResponseDataModel> postAPIwithSession(
    @Header("authenticationid") String authenticationid,
    @Header("sessionid") String sessionid,
    @Field("df06651788c884556a0b4b290fb40475ec9a45ba") String param,
    String endPoint,
    String callName,
    String key
  );
}