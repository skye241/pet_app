library languages;

import 'package:flutter/cupertino.dart';

part 'app_strings_vn.dart';

part 'app_strings_en.dart';

class AppLocalizationDelegate extends LocalizationsDelegate<AppStrings> {
  @override
  bool isSupported(Locale locale) {
    return <String>['en', 'vi'].contains(locale.languageCode);
  }

  @override
  Future<AppStrings> load(Locale locale) async {
    switch (locale.languageCode) {
      case 'en':
        return _AppStringsEn();
      case 'vi':
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

  String get appName;

  String get titleRegister;

  String get textTmp;

  //*** Start- Introduce ***//
  String get textLabelIntroduceDemo;

  //*** End- Introduce ***//

  //*** Start - Đăng ký Nhanh***//
  String get textTitleRegisterUser;

  String get textLabelFieldNameUser;

  String get textSubLabelFieldNameUser;

  String get textRuleService;

  String get textPolicyProtected;

//Button
  String get textButtonContinue;

  String get textButtonHadAccount;
//*** End - Đăng ký Nhanh***//

//*** Start - Register Pet ***//
  String get textTitleRegisterPet;
  String get textLabelFieldNamePet;
  String get textSubLabelFieldNamePet;
  String get textLabelFieldNameAlbum;
  String get textLabelFieldTypePet;
  String get textLabelFieldSexual;
  String get textLabelChooseMale;
  String get textLabelChooseFemale;
  String get textLabelFieldBirthday;
  //BUTTON
  String get textButtonRegisterAndContinue;
  String get textSkipRegisterPet;
//*** End - Register Pet ***//

//*** Start - Add a Picture***//
  String get textTitleAddAPicture;
  String get textButtonChooseAPicture;
  String get textButtonSkipChooseAPicture;
//*** End - Add a Picture***//

//*** Start - Album ***//
  String get textTitleAlbum;
  String get textLabelAlbumEmpty;
  String get textSubLabelAlbumEmpty;
//*** End - Album ***//

// *** Start - NEWS ***//
  String get textTitleNews;
  String get textLabelEmptyNews;
//*** End - NEWS ***//


// *** Start - Interests ***//
  String get textTitleInterests;
//*** End - Interests ***//


// *** Start - IPick Media ***//
  String get textPickMediaTitle;
  String get textPickMediaLabelMonth;
  String get textPickMediaButtonFamily;
  String get textPickMediaButtonFriend;
  String get textPickMediaButtonOnlyMe;
  String get textPickMediaContinue;
//*** End - IPick Media ***//


// *** Start - Profile ***//
String get textProfileTitle;
String get textProfileNotLinkAccount;
String get textProfileHadLinkAccount;
String get textProfileButtonAddPet;
String get textProfileLabelRelatives;
String get textProfileListRelatives;
String get textProfileButtonAddRelatives;
String get textProfileLabelAccount;
String get textProfileButtonAddAccount;
String get textProfileLabelSettings;
String get textProfileButtonNotification;
String get textProfileLabelPet;
String get textProfileButtonChangeLanguages;
String get textProfileButtonPolicyAndProtected;
// *** End - Profile ***//

// *** Start - ListRelatives ***//
    String get textListRelativesTitle;
    String get textListRelativesLabelFriend;
    String get textListRelativesLabelFamily;
// *** End - ListRelatives ***//

// *** Start - InviteRelatives ***//
  String get textInviteRelativesTitle;
  String get textInviteRelativesLabelMain;
  String get textInviteRelativesAlbum;
  String get textInviteRelativesButtonInviteFamily;
  String get textInviteRelativesButtonInviteFriend;
  String get textInviteRelativesButtonShare;
  String get textInviteRelativesButtonCopyUrl;
// *** End - InviteRelatives ***//


// *** Start - SignUP ***//
  String get textSignUpTitle;
  String get textSignUpLabelEmail;
  String get textSignUpLabelPassword;
  String get textSignUpButtonSignUp;
  String get textSignUpLabelOtherRegister;
// *** End - SignUp ***//

// *** Start - SIGNIN - LOGIN ***//
  String get textSignInTitle;
  String get textSignInLabelEmail;
  String get textSignInLabelPassword;
  String get textSignInButtonSignIn;
  String get textSignInLabelOtherRegister;
// *** End - SIGNIN - LOGIN ***//


}
