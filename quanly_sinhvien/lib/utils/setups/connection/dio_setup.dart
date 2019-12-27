import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:quanly_sinhvien/model/response/response_result.dart';

class SetupDio{
  Dio createDio({String accessToken}) {
    Dio dio=  Dio(
        BaseOptions(
          headers: {'x-access-token' : accessToken},
          connectTimeout: 10000,
          receiveTimeout: 10000,
        )
    );
    dio.interceptors.add(_setupLoggingInterceptor()); // setup logging interceptors

    return dio;
  }

  // return error
  ResponseResult handleError(var error){
    ResponseResult responseError;

    if(error is DioError){
      switch(error.type){
        case DioErrorType.CANCEL:
          responseError= ResponseResult(false, 0, 'Request to API server was cancelled');
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          responseError= ResponseResult(false, 0, "Connection timeout with API server");
          break;
        case DioErrorType.DEFAULT:
          responseError= ResponseResult(false, 0, "Connection to API server failed due to internet connection");
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          responseError= ResponseResult(false, 0, "Receive timeout in connection with API server");
          break;
        case DioErrorType.SEND_TIMEOUT:
          responseError= ResponseResult(false, 0, "Send timeout in connection with API server");
          break;
        case DioErrorType.RESPONSE:
          responseError= ResponseResult(true, error.response.statusCode, "Received invalid status code: ${error.response.statusCode}");
          break;
      }
    }else{
      responseError= ResponseResult(false, 0, 'Unexpected error occured: ${error.toString()}');
    }

    return responseError;
  }

  // writing logging
  Interceptor _setupLoggingInterceptor() {
    final interceptor= InterceptorsWrapper(
        onRequest: (RequestOptions options) {
          // do something before request is send
          debugPrint(
              "--> ${options.method != null ? options.method.toUpperCase() : 'METHOD'} ${"" + (options.baseUrl ?? "") + (options.path ?? "")}");
          debugPrint("Headers:");
          options.headers.forEach((k, v) => print('$k: $v'));
          if (options.queryParameters != null) {
            debugPrint("queryParameters:");
            options.queryParameters.forEach((k, v) => print('$k: $v'));
          }
          if (options.data != null) {
            debugPrint("Body: ${options.data}");
          }
          debugPrint(
              "--> END ${options.method != null ? options.method.toUpperCase() : 'METHOD'}");
          return options;
        },
        onResponse: (Response response) {
          // do something with da
          debugPrint(
              "<-- ${response.statusCode} ${(response.request != null ? (response.request.baseUrl + response.request.path) : 'URL')}");
          debugPrint("Headers:");
          response.headers?.forEach((k, v) => debugPrint('$k: $v'));
          debugPrint("Response: ${response.data}");
          debugPrint("<-- END HTTP");
          return response;
        },
        onError: (DioError err) async {
          // catch error
          debugPrint(
              "<-- ${err.message} ${(err.response?.request != null ? (err.response.request.baseUrl + err.response.request.path) : 'URL')}");
          debugPrint(
              "${err.response != null ? err.response.data : 'Unknown Error'}");
          debugPrint("<-- End error");
          return err;
        }

    );

    return interceptor;
  }
}