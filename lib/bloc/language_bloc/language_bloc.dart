import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_tv/bloc/language_bloc/language_state.dart';
import 'package:live_tv/common/constants/language_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageBloc extends Cubit<LanguageState>{
  LanguageBloc() : super(const StartAppState(Locale(LanguageConstants.en)));

  Future<void> loadLanguageFromSharePreference()async {
    final prefs = await SharedPreferences.getInstance();
    final locale = Locale(prefs.getString('lang') ?? LanguageConstants.en);
    emit(LoadedLocaleState(locale));
  }
  Future<void> updateLanguage(Locale locale) async {
    emit(LoadingLocaleState(locale));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lang', locale.toString());
    emit(LoadedLocaleState(locale));
  }

}