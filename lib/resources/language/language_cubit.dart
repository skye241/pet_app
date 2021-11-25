import 'package:bloc/bloc.dart';
import 'package:family_pet/general/constant/constant.dart';
import 'package:family_pet/main.dart';
import 'package:meta/meta.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageInitial(locale: 'vi'));

  Future<void> changeLocale(String locale ) async {
    prefs!.setString(Constant.language, locale);
    print('hello + $locale');

    emit(LanguageInitial(locale: locale));
  }
}
