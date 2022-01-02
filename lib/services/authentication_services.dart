import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'authentication_services.g.dart';

@RestApi()
abstract class AuthenticationServices {
  factory AuthenticationServices(Dio dio) = _AuthenticationServices;

  @POST('/api/v1/register')
  Future<void> signUp(@Body() Map<String, dynamic> map);

  @POST('/api/v1/login')
  Future<String> signIn(@Body() Map<String, dynamic> map);
}
