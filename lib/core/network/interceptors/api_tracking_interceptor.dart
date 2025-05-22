import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiTrackingInterceptor extends Interceptor {
  ApiTrackingInterceptor();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    debugPrint('Request Base URL: ${options.baseUrl}');
    debugPrint('${options.path} | ${options.method}');
    debugPrint('${options.headers}');
    debugPrint('${options.queryParameters}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('Response Base URL: ${response.requestOptions.baseUrl}');
    debugPrint(
      '${response.requestOptions.path} | ${response.requestOptions.method}',
    );
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint('Error Base URL: ${err.requestOptions.baseUrl}');
    debugPrint('${err.requestOptions.path} | ${err.requestOptions.method}');
    throw err;
  }
}
