// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_services.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _NotificationServices implements NotificationServices {
  _NotificationServices(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<NotificationModel>> getNotification(accessToken) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<NotificationModel>>(Options(
                method: 'GET',
                headers: <String, dynamic>{r'Authorization': accessToken},
                extra: _extra)
            .compose(_dio.options, '/api/v1/notifications',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) =>
            NotificationModel.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<NotificationModel> readNotification(accessToken, id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<NotificationModel>(Options(
                method: 'PUT',
                headers: <String, dynamic>{r'Authorization': accessToken},
                extra: _extra)
            .compose(_dio.options, '/api/v1/notifications/$id/read',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = NotificationModel.fromJson(_result.data!);
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
