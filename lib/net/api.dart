import 'package:ball/models/ball.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'api_exceptions.dart';
import 'api_list.dart';
import 'http.dart';

/// 发送 http 请求.
/// 若无需返回值 T 可传递 Null
Future<T> request<T>(
  String url, {
  Map<String, dynamic> data,
  Map<String, dynamic> queryParameters,
  String method = "POST",
}) async {
  var result = await _requestImpl(
    url,
    data: data,
    queryParameters: queryParameters,
    method: method,
  );
  return _convertTo<T>(result);
}

/// 发送 http get 请求.
/// 若无需返回值 T 可传递 Null
Future<T> getRequest<T>(
  String url, {
  Map<String, dynamic> data,
}) async {
  return await request<T>(
    url,
    queryParameters: data,
    method: "GET",
  );
}


Future<dynamic> _requestImpl(
  String url, {
  dynamic data,
  Map<String, dynamic> queryParameters,
  String method,
  ProgressCallback onSendProgress,
}) async {
  try {
    print('method:'+method);
    var response = await http.request(
        ApiList.mainBaseUrl + url,
        queryParameters: queryParameters,
        data: data,
        options: Options(
            method: method,
            responseType: ResponseType.json
        ),
    );
    return response.data;
  } catch (e) {
    _netWorkErrorHandler(e, url);
  }
}

void _netWorkErrorHandler(dynamic error,String url) {
  print('请求错误'+error.toString());
  if (error is DioError) {
  }

  debugPrint(error.toString());
  throw error;
}

/// 新增模型时需添加新的 case 处理逻辑
T _convertTo<T>(dynamic data) {
  try {
    if (T == Null) {
      return data;
    } else if (T == bool) {
      return data;
    } else if (T == int) {
      return data;
    } else if (T == String) {
      return data;
    } else if (T == List) {
      return data;
    }  else if (T == Ball) {
      return Ball.fromJson(data) as T;
    } else {
      throw UnimplementedError("$T is undefined");
    }
  } on UnimplementedError catch (e) {
    throw e;
  } catch (e) {
    throw JsonDeserializeException("$T", data);
  }
}
