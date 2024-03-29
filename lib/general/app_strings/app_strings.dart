library languages;

import 'dart:io';

import 'package:family_pet/general/constant/constant.dart';
import 'package:family_pet/main.dart';
import 'package:flutter/cupertino.dart';

part 'app_strings_jp.dart';
part 'app_strings_vn.dart';

class AppLocalizationDelegate extends LocalizationsDelegate<AppStrings> {
  @override
  bool isSupported(Locale locale) {
    return <String>['ja', 'vi'].contains(locale.languageCode);
  }

  @override
  Future<AppStrings> load(Locale locale) async {
    if (prefs!.getString(Constant.language) == null) {
      prefs!.setString(
          Constant.language,
          <String>['ja', 'vi'].contains(Platform.localeName.substring(0, 2))
              ? Platform.localeName.substring(0, 2)
              : 'vi');
    }
    switch (locale.languageCode) {
      case 'ja':
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
    switch (prefs!.getString(Constant.language)) {
      case 'ja':
        return _AppStringsJp();
      case 'vi':
        return _AppStringsVn();
      default:
        return _AppStringsVn();
    }
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

  String get textErrorEmptyBirthday;

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

  String get textPopUpLabelChooseAlbum;

  // String get textSubLabelMine;
  //
  String get textSubLabelFamily;

  String get textSubLabelFriend;

//*** End - Album ***//

// *** Start - NEWS ***//
  String get textTitleNews;

  String get textLabelEmptyNews;

  String get recently;

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

  String get textButtonAddMedia;

  String get textPopUpSuccessUpload;

  String get textPopUpSuccessSaveToDevice;

  String get textButtonReturnToMain;

  String get textPopUpConfirmDeleteMedia;

  String get textPopUpConfirmDeleteComment;

  String get textPopUpConfirmButtonDelete;

  String get textPopUpCancelButtonDelete;

  String get textErrorCannotUploadImage;

  String get textErrorNoPermission;

  String get albumName;

//*** End - IPick Media ***//

// *** Start - Profile ***//
  String get textProfileTitle;

  String get textProfileNotLinkAccount;

  String get textProfileNotActivate;

  String get textProfileActivate;

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

  String get textProfileButtonSignOut;

  String get textProfileButtonDeleteAccount;

  String get textProfilePopUpButtonDeleteAccount;

  String get textProfileButtonEditAccount;

  String get textProfileButtonTitleEditAccount;

  String get textProfileButtonChangePassword;

  String get textProfilePopUpConfirmSignOut;

  String get textProfilePopUpConfirmDeleteAccount;

  String get textProfilePopUpConfirmChangePassword;

  String get textProfilePopUpSuccessChangePassword;

  String get textProfileButtonPolicyAndProtected;

  String get textProfileButtonConfirmLogOut;

  String get textProfileButtonConfirmDeleteAccount;

  String get textProfileButtonRequestNotification;

  String get textProfileButtonDismissRequestNotification;

  String get textProfileButtonOpenSetting;

// *** End - Profile ***//

// *** Start - ListRelatives ***//
  String get textListRelativesTitle;

  String get textListRelativesLabelFriend;

  String get textListRelativesLabelFamily;

  String get textListRelativesConfirmDelete;

  String get textListRelativesSystem;


// *** End - ListRelatives ***//

// *** Start - InviteRelatives ***//
  String get textInviteRelativesTitle;

  String get textInviteRelativesLabelMain;

  String get textInviteRelativesAlbum;

  String get textInviteRelativesButtonInviteFamily;

  String get textInviteRelativesButtonInviteFriend;

  String get textInviteRelativesButtonShare;

  String get textInviteRelativesButtonCopyUrl;

  String get textInviteRelativesSuccessCopyUrl;

  String get textTabFamily;

  String get textTabFriend;

  String get textTooltip;

// *** End - InviteRelatives ***//

// *** Start - SignUP ***//
  String get textSignUpTitle;

  String get textSignUpLabelEmail;

  String get textSignUpLabelPassword;

  String get textSignUpButtonSignUp;

  String get textSignUpLabelOtherRegister;

  String get textSignUpErrorEmptyEmail;

  String get textSignUpErrorEmptyPassword;

  String get textSignUpErrorWrongFormatEmail;

  String get textSignUpPopUpTitle;

  String get textSignUpPopUpContentBegin;

  String get textSignUpPopUpContentEnd;

// *** End - SignUp ***//

// *** Start - SIGNIN - LOGIN ***//
  String get textSignInTitle;

  String get textSignInLabelEmail;

  String get textSignInLabelPassword;

  String get textSignInButtonSignIn;

  String get textSignInLabelOtherRegister;

  String get textSignInErrorNotActive;

  String get textSignInErrorNotCorrectAccount;

  String get textSignInResendEmail;

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

  String get minute;

  String get day;

  String get age;

  String get hour;

  String get year;

  String get delete;

  String get successUpdate;

  String get successDelete;

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

  String get textButtonSend;

  String get textEmptyComment;

  String get textButtonWriteComment;

// *** End - INTRODUCE***//

//

}
