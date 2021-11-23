library languages;

import 'package:flutter/cupertino.dart';

part 'app_strings_vn.dart';

part 'app_strings_jp.dart';

class AppLocalizationDelegate extends LocalizationsDelegate<AppStrings> {
  @override
  bool isSupported(Locale locale) {
    return <String>['jp', 'vi'].contains(locale.languageCode);
  }

  @override
  Future<AppStrings> load(Locale locale) async {
    switch (locale.languageCode) {
      case 'jp':
        return _AppStringsJp();
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

  // String get textTmp;

  //*** Start- Introduce ***//
  String get textLabelIntroduceDemo;

  //*** End- Introduce ***//

  //*** Start - Đăng ký Nhanh***//
  String get textTitleRegisterUser;

  String get textLabelFieldNameUser;

  String get textSubLabelFieldNameUser;

  String get textRuleService;

  String get textPolicyProtected;

  String get textErrorNameMessage;

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
  String get textErrorEmptyPetName;
  String get textErrorWrongDateFormat;
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
  String get textChangeMediaPermission;
  String get textDeleteMedia;
  String get textSaveMediaToDevice;
  String get textSaveMediaChanges;
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
  String get textSignUpErrorEmptyEmail;
  String get textSignUpErrorWrongFormatEmail;
// *** End - SignUp ***//

// *** Start - SIGNIN - LOGIN ***//
  String get textSignInTitle;
  String get textSignInLabelEmail;
  String get textSignInLabelPassword;
  String get textSignInButtonSignIn;
  String get textSignInLabelOtherRegister;
// *** End - SIGNIN - LOGIN ***//

// *** Start - INVITATION***//
  String get invitationTitle;
  String get invitationQuestion;
  String get invitationButtonAccept;
  String get invitationButtonReject;
  String get invitationSuccess;
  String get invitationExpired;
  String get invitationButtonSuccess;
  String get invitationButtonCancel;

// *** End - INVITATION ***//

// *** Start - COMMON***//
  String get notice;
  String get close;
  String get retry;
  String get month;
  String get delete;

// *** End - COMMON***//

// *** Start - ERROR**//
  String get errorMessageServer;
  String get errorMessagePermission;

// *** End - ERROR***//

// *** Start - INTRODUCE***//
  String get firstPageTitle;
  String get firstPageContent;
  String get secondPageTitle;
  String get secondPageContent;
  String get thirdPageTitle;
  String get thirdPageContent;

// *** End - INTRODUCE***//

// *** Start - IMAGE DETAILS***//
  String get textEmptyFavouriteMedia;
  String get textEmptyShareMedia;
  String get textInvitationTitle;

// *** End - INTRODUCE***//

//

}
