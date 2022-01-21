import 'package:dio/dio.dart';
import 'package:live_tv/common/config/configuration.dart';
import 'package:live_tv/common/constants/parameter_constants.dart';
import 'package:live_tv/model/comment_model.dart';
import 'package:live_tv/model/reaction_model.dart';
import 'package:live_tv/model/stream_model.dart';
import 'package:retrofit/http.dart';

part 'live_stream_services.g.dart';

@RestApi()
abstract class StreamServices {
  factory StreamServices(Dio dio) = _StreamServices;

  @POST('/api/v1/hello')
  Future<void> helloStream(
    @Body() Map<String, dynamic> map,
  );

  @POST('/api/v1/livestreams')
  Future<StreamModel> livesStream(
    @Header(Configuration.authentication) String accessToken,
    @Body() Map<String, dynamic> map,
  );

  @POST('/api/v1/livestreams/{${ParameterConstants.id}}/reaction')
  Future<ReactionModel> reaction(
    @Header(Configuration.authentication) String accessToken,
    @Path() int id,
    @Body() Map<String, dynamic> map,
  );

  @POST('/api/v1/livestreams/{${ParameterConstants.id}}/comment')
  Future<CommentModel> comment(
    @Header(Configuration.authentication) String accessToken,
    @Path() int id,
    @Body() Map<String, dynamic> map,
  );

  @GET('/api/v1/livestreams/{${ParameterConstants.id}}')
  Future<StreamModel> getLiveStream(
    @Header(Configuration.authentication) String accessToken,
    @Path() int id,
  );

  @GET('/api/v1/livestreams/owned')
  Future<List<StreamModel>> getLiveStreamOwned(
    @Header(Configuration.authentication) String accessToken,
  );
  @GET('api/v1/livestreams')
  Future<List<StreamModel>> getStreaming(
    @Header(Configuration.authentication) String accessToken,
  );
  @PUT('api/v1/livestreams/{${ParameterConstants.id}}/end')
  Future<StreamModel> endStream(
    @Header(Configuration.authentication) String accessToken,
    @Path() int id,
  );
  @POST('api/v1/livestreams/{${ParameterConstants.id}}/give-stars')
  Future<String> giveStars(
      @Header(Configuration.authentication) String accessToken,
      @Path() int id,
      @Body() Map<String, dynamic> map);
}
