import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:live_tv/common/config/configuration.dart';
import 'package:live_tv/common/network/dio_interceptor.dart';

Dio dio = Dio(BaseOptions(
  connectTimeout: Configuration.connectTimeout,
  receiveTimeout: Configuration.responseTimeout,
  contentType: Configuration.contentType,
  headers: {'Accept': '*/*'},
  baseUrl: Configuration.host,
))
  ..interceptors.add(logInterceptor)
  ..interceptors.add(DioInterceptor());

LogInterceptor logInterceptor = LogInterceptor(
  requestHeader: kDebugMode,
  requestBody: kDebugMode,
  responseBody: kDebugMode,
  responseHeader: false,
);
