// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Utility.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************



// API no SESSION


class _didStartCallAPInoSession implements didStartCallAPInoSession {
  _didStartCallAPInoSession(this._dio, {this.baseUrl}) {
    // baseUrl ??= 'http://localhost:8193/';
    baseUrl ??= link;
  }

  final Dio _dio;

  String? baseUrl;

  String? decryptedData;
  String decryptedMsg = '';
  static const encryptionChannel = MethodChannel('enc/dec');



  @override
  Future<ResponseDataModel> postAPInoSession(authenticationid, param, endPoint, callname, key) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'df06651788c884556a0b4b290fb40475ec9a45ba': param};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseDataModel>(Options(
                method: 'POST',
                headers: <String, dynamic>{
                  r'authenticationid': authenticationid
                },
                extra: _extra)
            .compose(_dio.options, endPoint,
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = ResponseDataModel.fromJson(_result.data!);


    String? status = value.status;
    switch (status) {

    case "000":
        decryptedData = await encryptionChannel
        .invokeMethod('decrypt', {
          'data': value.data,
          'key': key,
        });

        print("API-Name: $callname\nStatus: $status, Message: ${value.message}\nDecrypted: $decryptedData\n\n");
        debugPrint(authenticationid);

        value.data = decryptedData;

        // debugPrint('KEY: $value');
        //
        // if(callname == 'partialRegisterV2'){
        //   debugPrint('Do Nothing');
        // }else{
        //   var words =  decryptedData!.split('"');
        //   debugPrint(words.toString());
        //   debugPrint( words[3] );
        //   debugPrint( words[7] );
        //   debugPrint('SESSIONID');
        //
        //   SharedPreferences prefs = await SharedPreferences.getInstance();
        //
        //   prefs.setString('sessionId',words[7]);
        //   prefs.setString('borrowerId',words[3]);
        // }





        break;

    default:
      print("RESULT response = ${_result.data!.toString()}");

      decryptedMsg = await encryptionChannel
      .invokeMethod('decrypt', {
        'data': value.message,
        'key': key,
      });

      decryptedData = await encryptionChannel
      .invokeMethod('decrypt', {
        'data': value.data,
        'key': key,
      });

      print(callname);

      print("Status: $status, Message: $decryptedMsg");
      print("Decrypted: \n${decryptedData  ?? 'No dat found.\n\n'}");

      value.data = decryptedData;
      value.status = status;
      value.message = decryptedMsg;

      break;
    }
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}

// API with SESSION
class _didStartCallAPIwithSession implements didStartCallAPIwithSession {
  _didStartCallAPIwithSession(this._dio, {this.baseUrl}) {
    //baseUrl ??= 'http://localhost:8193/';
    baseUrl ??= link;
  }

  final Dio _dio;

  String? baseUrl;

  String? decryptedData;
  String decryptedMsg = '';
  static const encryptionChannel = MethodChannel('enc/dec');

  @override
  Future<ResponseDataModel> postAPIwithSession(authenticationid, sessionid, param, endPoint,callname,key) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'df06651788c884556a0b4b290fb40475ec9a45ba': param};

    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseDataModel>(Options(
                method: 'POST',
                headers: <String, dynamic>{
                  r'authenticationid': authenticationid,
                  r'sessionid': sessionid
                },
                extra: _extra)
            .compose(_dio.options, endPoint,
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = ResponseDataModel.fromJson(_result.data!);

    String? status = value.status;
    switch (status) {
    case "000":
        decryptedData = await encryptionChannel
        .invokeMethod('decrypt', {
          'data': value.data,
          'key': key,
        });

        print("API-Name: $callname\nStatus: $status, Message: ${value.message}\nDecrypted: $decryptedData\n\n");
        value.data = decryptedData;
      break;
    default:
      print("RESULT response = ${_result.data!.toString()}");

      decryptedMsg = await encryptionChannel
      .invokeMethod('decrypt', {
        'data': value.message,
        'key': key,
      });

      decryptedData = await encryptionChannel
      .invokeMethod('decrypt', {
        'data': value.data,
        'key': key,
      });

      print(callname);
      print("Status: $status, Message: $decryptedMsg");
      print("Decrypted: \n${decryptedData  ?? 'No dat found.\n\n'}");

      value.data = decryptedData;
      value.status = status;
      value.message = decryptedMsg;
      break;
    }
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
