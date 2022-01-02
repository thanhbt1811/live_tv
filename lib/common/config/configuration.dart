import 'package:live_tv/common/config/dev_env.dart';

class Configuration {
  static final _enviroment = DevEnvConfig();
  static const int connectTimeout = 30000;
  static const int responseTimeout = 30000;
  static const String authentication = 'Authorization';

  static const String contentType = 'application/json';

  static String _host = _enviroment.getHost();

  static String _stompHost = _enviroment.getStompHost();

  static String _streamHost = _enviroment.getStreamHost();

  static String _bearerAuth = _enviroment.getBearerAuth();

  static String _basicAuth = _enviroment.getBasicAuth();

  static String get host => _host;

  static String get stompHost => _stompHost;

  static String get streamHost => _streamHost;

  static String getBearerAuth(String accessToken) =>
      '$_bearerAuth $accessToken';

  static String get basicAuth => _basicAuth;
}
