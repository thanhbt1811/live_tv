import 'package:dio/dio.dart';
import 'package:live_tv/common/config/configuration.dart';
import 'package:live_tv/common/constants/parameter_constants.dart';
import 'package:live_tv/model/notification_model.dart';
import 'package:retrofit/http.dart';

part 'notification_services.g.dart';

@RestApi()
abstract class NotificationServices {
  factory NotificationServices(Dio _dio) = _NotificationServices;

  @GET('/api/v1/notifications')
  Future<List<NotificationModel>> getNotification(
    @Header(Configuration.authentication) String accessToken,
  );

  @PUT('/api/v1/notifications/{${ParameterConstants.id}}/read')
  Future<NotificationModel> readNotification(
    @Header(Configuration.authentication) String accessToken,
    @Path() int id,
  );
}
