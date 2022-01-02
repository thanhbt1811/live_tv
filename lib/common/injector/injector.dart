import 'package:dio/dio.dart';
import 'package:kiwi/kiwi.dart';
import 'package:live_tv/bloc/comment_bloc/comment_bloc.dart';
import 'package:live_tv/bloc/follow_bloc/follow_bloc.dart';
import 'package:live_tv/bloc/home_bloc/home_bloc.dart';
import 'package:live_tv/bloc/language_bloc/language_bloc.dart';
import 'package:live_tv/bloc/loader_bloc/loader_bloc.dart';
import 'package:live_tv/bloc/notification_bloc/notification_bloc.dart';
import 'package:live_tv/bloc/play_stream_bloc/play_stream_bloc.dart';
import 'package:live_tv/bloc/profile_bloc/profile_bloc.dart';
import 'package:live_tv/bloc/reaction_bloc/reaction_bloc.dart';
import 'package:live_tv/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:live_tv/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:live_tv/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:live_tv/bloc/stream_bloc/stream_bloc.dart';
import 'package:live_tv/common/network/dio_config.dart';
import 'package:live_tv/services/authentication_services.dart';
import 'package:live_tv/services/live_stream_services.dart';
import 'package:live_tv/services/notification_services.dart';
import 'package:live_tv/services/user_services.dart';

part 'injector.g.dart';

abstract class Injector {
  static KiwiContainer container = KiwiContainer();
  static void setup({bool forTest = false}) {
    container = KiwiContainer();
    final injector = _$Injector();
    if (forTest) {
      injector._configureMock();
    }
    injector._configure();
  }

  static final resolve = container.resolve;

  void _configure() {
    _configureAppModule();
  }

  void _configureMock() {}
  void _configureAppModule() {
    _configureCommon();
    _configureServices();
    _configureBloc();
    _configNetwork();
  }

  //-----Configure Bloc-----//
  @Register.singleton(LanguageBloc)
  @Register.singleton(LoaderBloc)
  @Register.singleton(SnackbarBloc)
  @Register.factory(SignInBloc)
  @Register.factory(SignUpBloc)
  @Register.factory(HomeBloc)
  @Register.factory(ProfileBloc)
  @Register.factory(StreamBloc)
  @Register.factory(PlayStreamBloc)
  @Register.factory(CommentBloc)
  @Register.factory(FollowBloc)
  @Register.factory(NotificationBloc)
  @Register.factory(ReactionBloc)
  void _configureBloc();
  //-----Configure Services-----//
  @Register.factory(AuthenticationServices)
  @Register.factory(UserServices)
  @Register.factory(StreamServices)
  @Register.factory(NotificationServices)
  void _configureServices();
  //-----Configure Common-----//
  void _configureCommon();
  //-----Configure Network------//
  void _configNetwork() {
    container.registerInstance(dio);
  }
}
