import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:live_tv/common/constants/language_constants.dart';
import 'package:live_tv/common/injector/injector.dart';
import 'package:live_tv/services/stromp_services.dart';
import 'package:live_tv/view/app.dart';

Future<void> main() async {
  Injector.setup();
  WidgetsFlutterBinding.ensureInitialized();
  StompServices.instance.client.activate();
  final delegate = await LocalizationDelegate.create(
      fallbackLocale: LanguageConstants.vn,
      supportedLocales: [LanguageConstants.en, LanguageConstants.vn]);
  runApp(LocalizedApp(delegate, App()));
}
