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

    print('请求返回：'+response.toString());

    handler.resolve(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print('ERROR[${err.response?.statusCode}] => PATH:');
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

  bool get success => returnCode % 17000 == 0;

  @override
  String toString() {
    return "RespData{ data: $data, code: $returnCode, message: $returnDesc}";
  }

  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();

    map["data"] = data;
    map["returnCode"] = returnCode;
    map["returnDesc"] = returnDesc;

    return map;
  }

  RespData.fromJson(Map<String, dynamic> json) {
    data = json["data"];
    returnCode = json["returnCode"] ?? int.parse(json["code"]) + 17000;
    returnDesc = json["returnCode"] == null ? json["msg"] : json["returnDesc"];
  }
}
