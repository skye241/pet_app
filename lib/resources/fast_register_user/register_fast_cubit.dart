import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:device_info/device_info.dart';
import 'package:family_pet/general/api_handler.dart';
import 'package:family_pet/model/entity.dart';
import 'package:family_pet/repository/user_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:meta/meta.dart';

part 'register_fast_state.dart';

class RegisterFastCubit extends Cubit<RegisterFastState> {
  RegisterFastCubit() : super(RegisterFastInitial());

  final UserRepository userRepository = UserRepository();

  Future<void> registerUser(String fullName) async {
    try {
      emit(RegisterFastStatePopUpLoading());
      final String deviceId = await _getId();
      final UserInfo? userInfo =
          await userRepository.registerUserFast(fullName, deviceId);
      // await userRepository.getNewToken();
      final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
      final String? token = await firebaseMessaging.getToken();
      await userRepository.createUserFcmToken(deviceId, token ?? '',
          Platform.isAndroid ? 'android' : 'ios', userInfo!.user!);
      emit(RegisterFastStateDismissPopUpLoading());
      emit(RegisterFastStateSuccess());
    } on APIException catch (e) {
      emit(RegisterFastStateDismissPopUpLoading());
      emit(RegisterFastStateFail(e.message()));
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
