import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:device_info/device_info.dart';
import 'package:family_pet/general/api_handler.dart';
import 'package:family_pet/general/constant/constant.dart';
import 'package:family_pet/general/constant/routes_name.dart';
import 'package:family_pet/main.dart';
import 'package:family_pet/repository/user_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:meta/meta.dart';

part 'welcome_state.dart';

class WelcomeCubit extends Cubit<WelcomeState> {
  WelcomeCubit() : super(WelcomeInitial());
  final UserRepository userRepository = UserRepository();

  Future<void> initEvent() async {
    final bool loggedIn = prefs!.getInt(Constant.userId) != null &&
        prefs!.getInt(Constant.userId).toString().isNotEmpty;
    if (loggedIn) {
      try {
        await userRepository.viewUserById();
        final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
        final String? token = await firebaseMessaging.getToken();
        await userRepository.updateUserFcmToken(await _getId(), token ?? '',
            Platform.isAndroid ? 'android' : 'ios');
        print('Token =============== $token');
        emit(WelcomeSuccess(RoutesName.topPage));
      } on APIException {
        // final bool loggedIn = prefs!.setString(Constant.cookie)
        emit(WelcomeSuccess(RoutesName.introducePage));
      }
    } else {

      emit(WelcomeSuccess(RoutesName.introducePage));
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
