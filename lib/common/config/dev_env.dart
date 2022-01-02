import 'package:live_tv/common/config/env.dart';

class DevEnvConfig extends EnvConfig {
  final String _host = 'https://livetv.2soft.top/';
  final String _stompHost = 'wss://livetv.2soft.top/api/v1/ws/websocket';
  final String _streamHost = 'rtmp://livetv.2soft.top/live';
  final String _basicAuth = 'basicAuth';
  final String _bearerAuth = 'Bearer';
  final String _eviroment = 'dev';

  @override
  String getEnviroment() {
    return _eviroment;
  }

  @override
  String getBasicAuth() {
    return _basicAuth;
  }

  @override
  String getBearerAuth() {
    return _bearerAuth;
  }

  @override
  String getHost() {
    return _host;
  }

  @override
  String getStompHost() {
    return _stompHost;
  }

  @override
  String getStreamHost() {
    return _streamHost;
  }
}
