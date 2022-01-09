// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector.dart';

// **************************************************************************
// KiwiInjectorGenerator
// **************************************************************************

class _$Injector extends Injector {
  @override
  void _configureBloc() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerSingleton((c) => LanguageBloc())
      ..registerSingleton((c) => LoaderBloc())
      ..registerSingleton((c) => SnackbarBloc())
      ..registerFactory((c) => SignInBloc(
          authenticationServices: c<AuthenticationServices>(),
          userServices: c<UserServices>(),
          loaderBloc: c<LoaderBloc>()))
      ..registerFactory((c) => SignUpBloc(
          authenticationServices: c<AuthenticationServices>(),
          loaderBloc: c<LoaderBloc>(),
          snackbarBloc: c<SnackbarBloc>()))
      ..registerFactory((c) => HomeBloc(streamServices: c<StreamServices>()))
      ..registerFactory(
          (c) => ProfileBloc(c<UserServices>(), c<StreamServices>()))
      ..registerFactory((c) => StreamBloc(streamServices: c<StreamServices>()))
      ..registerFactory(
          (c) => PlayStreamBloc(streamServices: c<StreamServices>()))
      ..registerFactory((c) => CommentBloc(streamServices: c<StreamServices>()))
      ..registerFactory((c) => FollowBloc(userServices: c<UserServices>()))
      ..registerFactory((c) => NotificationBloc(
          notificationServices: c<NotificationServices>(),
          userServices: c<UserServices>()))
      ..registerFactory((c) => ReactionBloc(c<StreamServices>()))
      ..registerFactory(
          (c) => GiveStarBloc(c<StreamServices>(), c<SnackbarBloc>()));
  }

  @override
  void _configureServices() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerFactory((c) => AuthenticationServices(c<Dio>()))
      ..registerFactory((c) => UserServices(c<Dio>()))
      ..registerFactory((c) => StreamServices(c<Dio>()))
      ..registerFactory((c) => NotificationServices(c<Dio>()));
  }

  @override
  void _configureCommon() {}
}
