import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_tv/bloc/comment_bloc/comment_bloc.dart';
import 'package:live_tv/bloc/play_stream_bloc/play_stream_bloc.dart';
import 'package:live_tv/bloc/reaction_bloc/reaction_bloc.dart';
import 'package:live_tv/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:live_tv/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:live_tv/bloc/stream_bloc/stream_bloc.dart';
import 'package:live_tv/common/config/configuration.dart';
import 'package:live_tv/common/constants/argument_constants.dart';
import 'package:live_tv/common/constants/route_constants.dart';
import 'package:live_tv/common/injector/injector.dart';
import 'package:live_tv/model/stream_model.dart';
import 'package:live_tv/view/live/live_screen.dart';
import 'package:live_tv/view/login/login_screen.dart';
import 'package:live_tv/view/main/main_screen.dart';
import 'package:live_tv/view/play/play_screen.dart';
import 'package:live_tv/view/register/register_screen.dart';
import 'package:live_tv/view/splash/splash_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> _getCombinedRoutes() => {};

  static Map<String, WidgetBuilder> getAll() => _getCombinedRoutes();

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteList.splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case RouteList.login:
        return MaterialPageRoute(
            builder: (context) => BlocProvider<SignInBloc>(
                create: (context) => Injector.resolve<SignInBloc>(),
                child: LoginScreen()));
      case RouteList.register:
        return MaterialPageRoute(
            builder: (context) => BlocProvider<SignUpBloc>(
                create: (context) => Injector.resolve<SignUpBloc>(),
                child: RegisterScreen()));
      case RouteList.main:
        return MaterialPageRoute(builder: (contex) => MainScreen());
      case RouteList.live:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => Injector.resolve<StreamBloc>(),
              ),
              BlocProvider(
                create: (_) => Injector.resolve<CommentBloc>(),
              ),
              BlocProvider(create: (_) => Injector.resolve<ReactionBloc>())
            ],
            child: LiveScreen(),
          ),
        );
      case RouteList.play:
        {
          final args = settings.arguments as Map<String, dynamic>;
          final streamId = args[ArgumentConstants.steamIdKey] as int;
          final streamKey = args[ArgumentConstants.streamKey];
          return MaterialPageRoute(
              builder: (context) => MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (_) => Injector.resolve<CommentBloc>()
                            ..getComment(streamId),
                        ),
                        BlocProvider(
                          create: (_) => Injector.resolve<PlayStreamBloc>()
                            ..initial(streamId),
                        ),
                        BlocProvider(
                          create: (_) => Injector.resolve<ReactionBloc>()
                            ..getReaction(streamId),
                        ),
                      ],
                      child: PlayScreen(
                        streamUrl: '${Configuration.streamHost}/$streamKey',
                      )));
        }
      default:
        _emptyRoute(settings);
    }
  }

  static MaterialPageRoute _emptyRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        backgroundColor: Colors.green,
        appBar: AppBar(
          leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: const Center(
              child: Text(
                'Back',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
        body: Center(
          child: Text('No path for ${settings.name}'),
        ),
      ),
    );
  }
}
