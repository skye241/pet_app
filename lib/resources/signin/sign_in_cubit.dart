import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:device_info/device_info.dart';
import 'package:family_pet/general/api_handler.dart';
import 'package:family_pet/repository/user_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:meta/meta.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial(true));
  final UserRepository _userRepository = UserRepository();
  bool isShow = true;

  Future<void> changeShowPass(bool showPass) async {
    isShow = showPass;
    emit(SignInInitial(showPass));
  }

  Future<void> login(String email, String password) async {
    try {
      emit(SignInShowPopUpLoading());
      final String deviceId = await _getId();
      await _userRepository.login(email, password);
      await _userRepository.updateUser(deviceId: deviceId);
      final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
      final String? token = await firebaseMessaging.getToken();
      await _userRepository.updateUserFcmToken(deviceId, token ?? '',
          Platform.isAndroid ? 'android' : 'ios');
      emit(SignInShowDismissPopUpLoading());
      emit(SignInStateSuccess());
    } on APIException catch (e) {
      emit(SignInShowDismissPopUpLoading());
      emit(SignInStateFail(e.message()));
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
}
