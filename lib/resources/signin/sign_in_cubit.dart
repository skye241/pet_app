import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:device_info/device_info.dart';
import 'package:family_pet/general/api_handler.dart';
import 'package:family_pet/general/app_strings/app_strings.dart';
import 'package:family_pet/general/constant/constant.dart';
import 'package:family_pet/repository/user_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../main.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial(true));
  final UserRepository _userRepository = UserRepository();
  bool isShow = true;

  Future<void> changeShowPass(bool showPass) async {
    isShow = showPass;
    emit(SignInInitial(showPass));
  }

  Future<void> login(
      String email, String password, BuildContext context) async {
    try {
      emit(SignInShowPopUpLoading());
      final String deviceId = await _getId();
      await _userRepository.login(email, password);
      await _userRepository.updateUser(deviceId: deviceId);
      final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
      final String? token = await firebaseMessaging.getToken();

      prefs!.setString(Constant.registrationId, token ?? '');
      await _userRepository.createUserFcmToken(
          deviceId, token ?? '', Platform.isAndroid ? 'android' : 'ios');
      emit(SignInShowDismissPopUpLoading());
      emit(SignInStateSuccess());
    } on APIException catch (e) {
      emit(SignInShowDismissPopUpLoading());
      emit(SignInStateFail(getErrorMessage(context, e)));
    }
  }
  Future<void> resendEmail(BuildContext context, String email) async {
    try {
      emit(SignInShowPopUpLoading());
      // final UserInfo userInfo = UserInfo(
      //     deviceKey: prefs!.getString(Constant.deviceKey),
      //     fullName: prefs!.getString(Constant.fullName),
      //     user: User(
      //         id: prefs!.getInt(Constant.userId),
      //         email: email,
      //         password: password));
      await _userRepository.sendEmail(email);
      emit(SignInShowDismissPopUpLoading());
    } on APIException catch (e) {
      emit(SignInShowDismissPopUpLoading());
      emit(SignInStateFail(getErrorMessage(context, e)));
    }
  }
  Future<String> _getId() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      final IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      final AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }

  String getErrorMessage(BuildContext context, APIException e) {
    switch (e.apiResponse.code) {
      case 406:
        return AppStrings.of(context).textSignInErrorNotActive;
      case 404:
        return AppStrings.of(context).textSignInErrorNotCorrectAccount;
      case 401:
        return AppStrings.of(context).textSignInErrorNotCorrectAccount;
      default:
        return e.message();
    }
  }
}
