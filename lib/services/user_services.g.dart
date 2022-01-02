// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_services.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _UserServices implements UserServices {
  _UserServices(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<UserModel> getUser(accessToken) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UserModel>(Options(
                method: 'GET',
                headers: <String, dynamic>{r'Authorization': accessToken},
                extra: _extra)
            .compose(_dio.options, '/api/v1/users/me',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UserModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<bool> unForllow(accessToken, id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<bool>(_setStreamType<bool>(Options(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': accessToken},
            extra: _extra)
        .compose(_dio.options, '/api/v1/users/$id/unfollow',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<bool> follow(accessToken, id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<bool>(_setStreamType<bool>(Options(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': accessToken},
            extra: _extra)
        .compose(_dio.options, 'api/v1/users/$id/follow',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<List<UserModel>> getUsers(accessToken) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<UserModel>>(Options(
                method: 'GET',
                headers: <String, dynamic>{r'Authorization': accessToken},
                extra: _extra)
            .compose(_dio.options, 'api/v1/users',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => UserModel.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<UserModel> getUserById(accessToken, id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UserModel>(Options(
                method: 'GET',
                headers: <String, dynamic>{r'Authorization': accessToken},
                extra: _extra)
            .compose(_dio.options, 'api/v1/users/$id',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UserModel.fromJson(_result.data!);
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
