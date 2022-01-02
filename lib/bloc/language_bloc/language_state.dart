import 'package:equatable/equatable.dart';
import 'dart:ui';

abstract class LanguageState extends Equatable {
  final Locale locale;
  const LanguageState(this.locale);
}
class StartAppState extends LanguageState{
  const StartAppState(Locale locale) : super(locale);
  @override
  List<Object?> get props => [locale];

}
class LoadingLocaleState extends LanguageState {
  @override
  final Locale locale;

  const LoadingLocaleState(this.locale) : super(locale);
  @override
  List<Object?> get props => [locale];
}
class LoadedLocaleState extends LanguageState {
  @override
  final Locale locale;

  const LoadedLocaleState(this.locale) : super(locale);
  @override
  List<Object?> get props => [locale];
}