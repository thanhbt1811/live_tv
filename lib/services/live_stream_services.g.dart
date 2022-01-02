// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_stream_services.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _StreamServices implements StreamServices {
  _StreamServices(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<void> helloStream(map) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(map);
    await _dio.fetch<void>(_setStreamType<void>(
        Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
            .compose(_dio.options, '/api/v1/hello',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    return null;
  }

  @override
  Future<StreamModel> livesStream(accessToken, map) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(map);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<StreamModel>(Options(
                method: 'POST',
                headers: <String, dynamic>{r'Authorization': accessToken},
                extra: _extra)
            .compose(_dio.options, '/api/v1/livestreams',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = StreamModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ReactionModel> reaction(accessToken, id, map) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(map);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ReactionModel>(Options(
                method: 'POST',
                headers: <String, dynamic>{r'Authorization': accessToken},
                extra: _extra)
            .compose(_dio.options, '/api/v1/livestreams/$id/reaction',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ReactionModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CommentModel> comment(accessToken, id, map) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(map);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommentModel>(Options(
                method: 'POST',
                headers: <String, dynamic>{r'Authorization': accessToken},
                extra: _extra)
            .compose(_dio.options, '/api/v1/livestreams/$id/comment',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CommentModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<StreamModel> getLiveStream(accessToken, id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<StreamModel>(Options(
                method: 'GET',
                headers: <String, dynamic>{r'Authorization': accessToken},
                extra: _extra)
            .compose(_dio.options, '/api/v1/livestreams/$id',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = StreamModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<List<StreamModel>> getLiveStreamOwned(accessToken) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<StreamModel>>(Options(
                method: 'GET',
                headers: <String, dynamic>{r'Authorization': accessToken},
                extra: _extra)
            .compose(_dio.options, '/api/v1/livestreams/owned',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => StreamModel.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<StreamModel>> getStreaming(accessToken) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<StreamModel>>(Options(
                method: 'GET',
                headers: <String, dynamic>{r'Authorization': accessToken},
                extra: _extra)
            .compose(_dio.options, 'api/v1/livestreams',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => StreamModel.fromJson(i as Map<String, dynamic>))
        .toList();
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
