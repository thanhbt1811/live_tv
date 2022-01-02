import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:live_tv/bloc/language_bloc/language_bloc.dart';
import 'package:live_tv/bloc/loader_bloc/loader_bloc.dart';
import 'package:live_tv/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:live_tv/bloc/snackbar_bloc/snackbar_state.dart';
import 'package:live_tv/bloc/snackbar_bloc/snackbar_type.dart';
import 'package:live_tv/common/constants/language_constants.dart';
import 'package:live_tv/common/constants/route_constants.dart';
import 'package:live_tv/common/injector/injector.dart';
import 'package:live_tv/view/routes.dart';
import 'package:live_tv/view/widget/loading_container/loading_container.dart';
import 'package:live_tv/view/widget/snackbar_widget/snackbar_widget.dart';

class App extends StatelessWidget {
  final GlobalKey<NavigatorState> _navigator = GlobalKey<NavigatorState>();

  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext buildContext) {
    final localizationDelegate = LocalizedApp.of(buildContext).delegate;
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: () => MultiBlocProvider(
                providers: [
                  BlocProvider<LanguageBloc>(
                    create: (BuildContext context) =>
                        Injector.resolve<LanguageBloc>(),
                  ),
                  BlocProvider<LoaderBloc>(
                    create: (BuildContext context) =>
                        Injector.resolve<LoaderBloc>(),
                  ),
                  BlocProvider<SnackbarBloc>(
                      create: (BuildContext context) =>
                          Injector.resolve<SnackbarBloc>())
                ],
                child: GestureDetector(
                  onTap: () {
                    final currentFocus = FocusScope.of(buildContext);
                    if (!currentFocus.hasPrimaryFocus &&
                        currentFocus.focusedChild != null) {
                      FocusManager.instance.primaryFocus!.unfocus();
                    }
                  },
                  child: MaterialApp(
                    onGenerateRoute: Routes.generateRoute,
                    navigatorKey: _navigator,
                    locale: localizationDelegate.currentLocale,
                    localizationsDelegates: [
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                      localizationDelegate
                    ],
                    supportedLocales: const [
                      Locale(LanguageConstants.en),
                      Locale(LanguageConstants.vn)
                    ],
                    title: 'Live+',
                    initialRoute: RouteList.splash,
                    routes: Routes.getAll(),
                    builder: (context, widget) => LoadingContainer(
                        child: _buildBlocListener(
                            widget ?? const SizedBox(), context)),
                  ),
                )));
  }

  BlocListener<SnackbarBloc, SnackbarState> _buildBlocListener(
      Widget widget, BuildContext context) {
    return BlocListener<SnackbarBloc, SnackbarState>(
      listener: (context, state) {
        if (state is ShowSnackBarState) {
          TopSnackBar(
            title: translate(state.translationKey ?? ''),
            type: state.type ?? SnackBarType.success,
            key: state.key,
          ).showWithNavigator(
              _navigator.currentState ?? NavigatorState(), context);
        }
      },
      child: widget,
    );
  }
}
