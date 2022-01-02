import 'package:dio/dio.dart';
import 'package:live_tv/common/config/configuration.dart';
import 'package:live_tv/common/constants/parameter_constants.dart';
import 'package:live_tv/model/user_model.dart';
import 'package:retrofit/http.dart';

part 'user_services.g.dart';

@RestApi()
abstract class UserServices {
  factory UserServices(Dio dio) = _UserServices;

  @GET('/api/v1/users/me')
  Future<UserModel> getUser(
      @Header(Configuration.authentication) String accessToken);

  @POST('/api/v1/users/{${ParameterConstants.id}}/unfollow')
  Future<bool> unForllow(
    @Header(Configuration.authentication) String accessToken,
    @Path() int id,
  );

  @POST('api/v1/users/{${ParameterConstants.id}}/follow')
  Future<bool> follow(
    @Header(Configuration.authentication) String accessToken,
    @Path() int id,
  );

  @GET('api/v1/users')
  Future<List<UserModel>> getUsers(
    @Header(Configuration.authentication) String accessToken,
  );

  @GET('api/v1/users/{${ParameterConstants.id}}')
  Future<UserModel> getUserById(
    @Header(Configuration.authentication) String accessToken,
    @Path() int id,
  );
}
