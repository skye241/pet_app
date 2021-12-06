
import 'package:bloc/bloc.dart';
import 'package:family_pet/general/api_handler.dart';
import 'package:family_pet/general/constant/constant.dart';
import 'package:family_pet/general/constant/routes_name.dart';
import 'package:family_pet/main.dart';
import 'package:family_pet/repository/user_repository.dart';
import 'package:meta/meta.dart';

part 'welcome_state.dart';

class WelcomeCubit extends Cubit<WelcomeState> {
  WelcomeCubit() : super(WelcomeInitial());
  final UserRepository userRepository = UserRepository();

  Future<void> initEvent() async {
    final bool loggedIn = prefs!.getString(Constant.cookie) != null &&
        prefs!.getString(Constant.cookie)!.isNotEmpty;
    final List<String>? notiString =
        prefs!.getStringList(Constant.notificationList);
    if (notiString == null) {
      prefs!.setStringList(Constant.notificationList, <String>[]);
    }
    if (notiString == null) {
      prefs!.setStringList(Constant.notificationList, <String>[]);
    }
    if (loggedIn) {
      try {
        await userRepository.viewUserById();
        // final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
        // final String? token = await firebaseMessaging.getToken();
        // await userRepository.updateUserFcmToken(await _getId(), token ?? '',
        //     Platform.isAndroid ? 'android' : 'ios');
        // print('Token =============== $token');

        emit(WelcomeSuccess(RoutesName.topPage));
      } on APIException {
        // final bool loggedIn = prefs!.setString(Constant.cookie)
        emit(WelcomeSuccess(RoutesName.signInPage));
      }
    } else {
      emit(WelcomeSuccess(RoutesName.introducePage));
    }
  }

  // Future<String> _getId() async {
  //   final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  //   if (Platform.isIOS) {
  //     final IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
  //     return iosDeviceInfo.identifierForVendor; // unique ID on iOS
  //   } else {
  //     final AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
  //     return androidDeviceInfo.androidId; // unique ID on Android
  //   }
  // }
}
