library languages;

import 'package:flutter/cupertino.dart';

part 'app_strings_vn.dart';

part 'app_strings_en.dart';

class AppLocalizationDelegate extends LocalizationsDelegate<AppStrings> {
  @override
  bool isSupported(Locale locale) {
    return ['en', 'vi'].contains(locale.languageCode);
  }

  @override
  Future<AppStrings> load(Locale locale) async {
    switch (locale.languageCode) {
      case "en":
        return _AppStringsEn();
      case "vi":
        return _AppStringsVn();
      default:
        return _AppStringsVn();
    }
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppStrings> old) {
    return this != old;
  }
}

abstract class AppStrings {
  static AppStrings of(BuildContext context) {
    return Localizations.of<AppStrings>(context, AppStrings)!;
  }

  String get APP_NAME;

  String get titleRegister;

  String get textTmp;

  //*** Start- Introduce ***//
  String get TEXT_LABEL_INTRODUCE_DEMO;

  //*** End- Introduce ***//

  //*** Start - Đăng ký Nhanh***//
  String get TEXT_TITLE_REGISTER_USER;

  String get TEXT_LABEL_FIELD_NAME_USER;

  String get TEXT_SUB_LABEL_FIELD_NAME_USER;

  String get TEXT_RULE_SERVICE;

  String get TEXT_POLICY_PROTECTED;

//Button
  String get TEXT_BUTTON_CONTINUE;

  String get TEXT_BUTTON_HAD_ACCOUNT;
//*** End - Đăng ký Nhanh***//

//*** Start - Register Pet ***//
  String get TEXT_TITLE_REGISTER_PET;
  String get TEXT_LABEL_FIELD_NAME_PET;
  String get TEXT_SUB_LABEL_FIELD_NAME_PET;
  String get TEXT_LABEL_FIELD_NAME_ALBUM;
  String get TEXT_LABEL_FIELD_TYPE_PET;
  String get TEXT_LABEL_FIELD_SEXUAL;
  String get TEXT_LABEL_CHOOSE_MEAL;
  String get TEXT_LABEL_CHOOSE_FEMEAL;
  String get TEXT_LABEL_FIELD_BIRTHDAY;
  //BUTTON
  String get TEXT_BUTTON_REGISTER_AND_CONTINUE;
  String get TEXT_SKIP_REGISTER_PET;
//*** End - Register Pet ***//

//*** Start - Add a Picture***//
  String get TEXT_TITLE_ADD_A_PICTURE;
  String get TEXT_BUTTON_CHOOSE_A_PICTURE;
  String get TEXT_BUTTON_SKIP_CHOOSE_A_PICTURE;
//*** End - Add a Picture***//

//*** Start - Album ***//
  String get TEXT_TITLE_ALBUM;
  String get TEXT_LABEL_ALBUM_EMPTY;
  String get TEXT_SUB_LABEL_ALBUM_EMPTY;
//*** End - Album ***//

// *** Start - NEWS ***//
  String get TEXT_TITLE_NEWS;
  String get TEXT_LABEL_EMPTY_NEWS;
//*** End - NEWS ***//


// *** Start - Interests ***//
  String get TEXT_TITLE_INTERESTS;
//*** End - Interests ***//


// *** Start - IPick Media ***//
  String get TEXT_PICKMEDIA_TITLE;
  String get TEXT_PICKMEDIA_LABEL_MONTH;
  String get TEXT_PICKMEDIA_BUTTON_FAMILY;
  String get TEXT_PICKMEDIA_BUTTON_FRIEND;
  String get TEXT_PICKMEDIA_BUTTON_ONLY_ME;
  String get TEXT_PICKMEDIA_CONTINUE;
//*** End - IPick Media ***//


// *** Start - Profile ***//
String get TEXT_PROFILE_TITLE;
String get TEXT_PROFILE_NOT_LINK_ACCOUNT;
String get TEXT_PROFILE_HAD_LINK_ACCOUNT;
String get TEXT_PROFILE_BUTTON_ADD_PET;
String get TEXT_PROFILE_LABEL_RELATIVES;
String get TEXT_PROFILE_LIST_RELATIVES;
String get TEXT_PROFILE_BUTTON_ADD_RELATIVES;
String get TEXT_PROFILE_LABEL_ACCOUNT;
String get TEXT_PROFILE_BUTTON_ADD_ACCOUNT;
String get TEXT_PROFILE_LABEL_SETTINGS;
String get TEXT_PROFILE_BUTTON_NOTIFICATION;
String get TEXT_PROFILE_LABEL_PET;
String get TEXT_PROFILE_BUTTON_CHANGE_LANGUAGES;
String get TEXT_PROFILE_BUTTON_POLICY_AND_PROTECTED;
// *** End - Profile ***//

// *** Start - ListRelatives ***//
    String get TEXT_LISTRELATIVES_TITLE;
    String get TEXT_LISTRELATIVES_LABEL_FRIEND;
    String get TEXT_LISTRELATIVES_LABEL_FAMILY;
// *** End - ListRelatives ***//

// *** Start - InviteRelatives ***//
  String get TEXT_INVITERELATIVES_TITLE;
  String get TEXT_INVITERELATIVES_LABEL_MAIN;
  String get TEXT_INVITERELATIVES_ALBUM;
  String get TEXT_INVITERELATIVES_BUTTON_INVITE_FAMILY;
  String get TEXT_INVITERELATIVES_BUTTON_INVITE_FRIEND;
  String get TEXT_INVITERELATIVES_BUTTON_SHARE;
  String get TEXT_INVITERELATIVES_BUTTON_COPY_URL;
// *** End - InviteRelatives ***//


// *** Start - SignUP ***//
  String get TEXT_SIGNUP_TITLE;
  String get TEXT_SIGNUP_LABEL_EMAIL;
  String get TEXT_SIGNUP_LABEL_PASSWORD;
  String get TEXT_SIGNUP_BUTTON_SIGNUP;
  String get TEXT_SIGNUP_LABEL_OTHER_REGISTER;
// *** End - SignUp ***//

// *** Start - SIGNIN - LOGIN ***//
  String get TEXT_SIGNIN_TITLE;
  String get TEXT_SIGNIN_LABEL_EMAIL;
  String get TEXT_SIGNIN_LABEL_PASSWORD;
  String get TEXT_SIGNIN_BUTTON_SIGNIN;
  String get TEXT_SIGNIN_LABEL_OTHER_REGISTER;
// *** End - SIGNIN - LOGIN ***//


}
