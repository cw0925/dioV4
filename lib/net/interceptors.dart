import 'dart:convert';

import 'package:dio/dio.dart';

class HeaderInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    ///动态添加请求头
    print("options: ${options.headers}");
    handler.next(options);
  }
}

class ApiInterceptor extends InterceptorsWrapper {

  RequestOptions _options;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _options = options;
    print('REQUEST[${options.method}] => PATH: ${options.path}');
    print('REQUEST[${options.queryParameters}] => PATH: ${options.queryParameters}');
    print('REQUEST[${options.data}] => PATH: ${options.data}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {

    print('原始请求返回：'+response.toString());

    if (response.statusCode == 200) {
      final data =
      (response.data is Map) ? response.data : json.decode(response.data);
      RespData respData = RespData.fromJson(data);
      if (respData.success) {
        response.data = respData.data;
        handler.resolve(response);
      }else {
        print('respData.fail请求返回：'+response.toString());
        // return handleFailed(path, respData);
      }
    } else {
      print('statusCode != 200请求返回：'+response.toString());
      // final respData = RespData(
      //     data: response.data,
      //     returnCode: response.statusCode,
      //     returnDesc: response.statusMessage);
      // return handleFailed(path, respData);
    }
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print('ERROR[${err.response}] => PATH:');
    handler.reject(err);
  }

  void handleFailed(ResponseInterceptorHandler handler , DioError err) {
    handler.reject(err);
  }

}

class RespData {
  dynamic data;

  int returnCode;

  String returnDesc;

  RespData({this.data, this.returnCode, this.returnDesc});

  bool get success => returnCode == 0;

  @override
  String toString() {
    return "RespData{ data: $data, code: $returnCode, message: $returnDesc}";
  }

  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();

    map["result"] = data;
    map["state"] = returnCode;
    map["message"] = returnDesc;

    return map;
  }

  RespData.fromJson(Map<String, dynamic> json) {
    data = json["result"];
    returnCode = json["state"] ?? int.parse(json["state"]);
    returnDesc = json["message"] == null ? json["message"] : json["message"];
  }
}
