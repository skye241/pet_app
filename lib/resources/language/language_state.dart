part of 'language_cubit.dart';

@immutable
abstract class LanguageState {}

class LanguageInitial extends LanguageState {
  LanguageInitial({this.locale = 'vi'});

  final String locale;
}
