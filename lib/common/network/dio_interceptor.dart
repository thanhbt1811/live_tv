import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:live_tv/bloc/loader_bloc/loader_bloc.dart';
import 'package:live_tv/bloc/snackbar_bloc/bloc.dart';
import 'package:live_tv/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:live_tv/bloc/snackbar_bloc/snackbar_type.dart';
import 'package:live_tv/common/injector/injector.dart';
import 'package:live_tv/model/error_model.dart';

class DioInterceptor extends Interceptor {
  final _dio = Dio();
  final _snackbarBloc = Injector.resolve<SnackbarBloc>();
  final _loaderBloc = Injector.resolve<LoaderBloc>();

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('DIO-Response-Data: ${response.data}');
    if (response.statusCode == 201) {
      if (response.data.runtimeType == String) {
        final responseData = json.decode(response.data);
        response.data = responseData['accessToken'];
      }
    }
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    _loaderBloc.finishLoading();
    _dio.lock();
    if (err.response?.data != null) {
      var errorModel;
      if (err.response!.data.runtimeType == String) {
        errorModel = ErrorModel.fromJson(json.decode(err.response?.data));
      } else {
        errorModel = ErrorModel.fromJson(err.response?.data);
      }
      _snackbarBloc.add(ShowSnackbar(
          type: SnackBarType.error, translationKey: errorModel.message));
    }
    _dio.unlock();
  }
}
