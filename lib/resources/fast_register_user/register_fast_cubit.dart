import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:device_info/device_info.dart';
import 'package:family_pet/genaral/api_handler.dart';
import 'package:family_pet/genaral/constant/constant.dart';
import 'package:family_pet/main.dart';
import 'package:family_pet/model/entity.dart';
import 'package:family_pet/repository/user_repository.dart';
import 'package:meta/meta.dart';

part 'register_fast_state.dart';

class RegisterFastCubit extends Cubit<RegisterFastState> {
  RegisterFastCubit() : super(RegisterFastInitial());

  final UserRepository userRepository = UserRepository();

  Future<void> registerUser(String fullName) async {
    try {
      emit(RegisterFastStatePopUpLoading());
      final String deviceId = await _getId();
      prefs!.setString(Constant.cookie, '');
      final UserInfo? user =
          await userRepository.registerUserFast(fullName, 'xxxxxxx19');
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
